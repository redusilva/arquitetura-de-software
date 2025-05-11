from flask import Flask, request, jsonify
import requests
import smtplib
from email.message import EmailMessage
from flasgger import Swagger, swag_from
from dotenv import load_dotenv
from flask_cors import CORS
from pymongo.mongo_client import MongoClient
from pymongo.server_api import ServerApi
from bson.objectid import ObjectId
import os

dotenv_path = os.path.join(os.path.dirname(__file__), ".env")
load_dotenv(dotenv_path=dotenv_path)

AUTH_SERVICE_URL = os.getenv("AUTH_SERVICE_URL")
LOG_SERVICE_URL = os.getenv("LOG_SERVICE_URL")
SYSTEM_ID = "60b8f37e3d024e3b2c5f6a6c"

SMTP_SERVER = os.getenv("SMTP_SERVER")
SMTP_PORT = int(os.getenv("SMTP_PORT", 587))
SMTP_USERNAME = os.getenv("SMTP_USERNAME")
SMTP_PASSWORD = os.getenv("SMTP_PASSWORD")

MONGO_URI = os.getenv("MONGO_URI")
client = MongoClient(MONGO_URI, server_api=ServerApi('1'))
db = client["mails"]
mail_collection = db["mail_list"]

app = Flask(__name__)
CORS(app)
swagger = Swagger(app)

@app.route("/send-email", methods=["POST"])
@swag_from({
    'tags': ['Emails'],
    'parameters': [
        {
            'name': 'Authorization',
            'in': 'header',
            'type': 'string',
            'required': True,
            'description': 'Token JWT'
        },
        {
            'name': 'body',
            'in': 'body',
            'required': True,
            'schema': {
                'type': 'object',
                'properties': {
                    'to': {'type': 'string'},
                    'subject': {'type': 'string'},
                    'message': {'type': 'string'}
                },
                'required': ['to', 'message']
            }
        }
    ],
    'responses': {
        200: {'description': 'Email enviado com sucesso'},
        401: {'description': 'Não autorizado'},
        400: {'description': 'Campos obrigatórios ausentes'}
    }
})
def send_email():
    token = request.headers.get("Authorization")
    if not token:
        return jsonify({"error": "Token ausente"}), 401

    try:
        auth_response = requests.post(AUTH_SERVICE_URL, json={"token": token})
        if auth_response.status_code != 200:
            return jsonify({"error": "Token inválido"}), 401
        user_info = auth_response.json().get("data", {})
    except requests.exceptions.RequestException:
        return jsonify({"error": "Erro ao verificar token"}), 500

    data = request.get_json()
    to = data.get("to")
    subject = data.get("subject", "Sem assunto")
    message = data.get("message")

    if not to or not message:
        return jsonify({"error": "Campos obrigatórios ausentes"}), 400

    email_status = {
        "to": to,
        "subject": subject,
        "message": message,
        "user_info": user_info,
        "status": "success",
        "log_saved": False
    }

    try:
        msg = EmailMessage()
        msg["From"] = SMTP_USERNAME
        msg["To"] = to
        msg["Subject"] = subject
        msg.set_content(message)

        with smtplib.SMTP(SMTP_SERVER, SMTP_PORT) as server:
            server.starttls()
            server.login(SMTP_USERNAME, SMTP_PASSWORD)
            server.send_message(msg)

    except Exception as e:
        email_status["status"] = "error"
        email_status["error_message"] = f"Erro ao enviar e-mail: {str(e)}"
        result = mail_collection.insert_one(email_status)
        return jsonify({
            "error": email_status["error_message"],
            "_id": str(result.inserted_id)
        }), 500

    try:
        log_data = {
            "systemId": SYSTEM_ID,
            "service": "emails",
            "message": f"E-mail enviado para {to} com assunto '{subject}'",
            "level": "info",
            "source": "emails",
            "email": to
        }
        requests.post(
            LOG_SERVICE_URL + "/api/logs",
            json=log_data,
            headers={"Authorization": "Bearer " + token}
        )
        email_status["log_saved"] = True
    except requests.exceptions.RequestException:
        print("Erro ao registrar log")

    result = mail_collection.insert_one(email_status)

    return jsonify({
        "message": "Email enviado com sucesso",
        "_id": str(result.inserted_id)
    }), 200


@app.route("/emails", methods=["GET"])
def get_all_emails():
    emails = list(mail_collection.find())
    for email in emails:
        email["_id"] = str(email["_id"])
    return jsonify(emails), 200


@app.route("/emails/<id>", methods=["GET"])
def get_email_by_id(id):
    try:
        email = mail_collection.find_one({"_id": ObjectId(id)})
        if not email:
            return jsonify({"error": "Email não encontrado"}), 404
        email["_id"] = str(email["_id"])
        return jsonify(email), 200
    except Exception:
        return jsonify({"error": "ID inválido"}), 400


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=4002)
