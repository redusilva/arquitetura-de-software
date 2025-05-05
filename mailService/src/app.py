from flask import Flask, request, jsonify
import requests
import smtplib
from email.message import EmailMessage
from flasgger import Swagger, swag_from
from dotenv import load_dotenv
import os

load_dotenv(dotenv_path=".env")

AUTH_SERVICE_URL = os.getenv("AUTH_SERVICE_URL")
LOG_SERVICE_URL = os.getenv("LOG_SERVICE_URL")
SYSTEM_ID = os.getenv("SYSTEM_ID", "email-service")

SMTP_SERVER = os.getenv("SMTP_SERVER")
SMTP_PORT = int(os.getenv("SMTP_PORT", 587))
SMTP_USERNAME = os.getenv("SMTP_USERNAME")
SMTP_PASSWORD = os.getenv("SMTP_PASSWORD")

app = Flask(__name__)
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
        return jsonify({"error": f"Erro ao enviar e-mail: {str(e)}"}), 500
    
    try:
        log_data = {
            "systemId": "email-service",
            "message": f"E-mail enviado para {to} com assunto '{subject}'",
            "level": "info",
            "source": "emails",
            "email": to
        }
        requests.post(
            LOG_SERVICE_URL + "/api/logs",
            json=log_data,
            headers={"Authorization": token}
        )
    except requests.exceptions.RequestException:
        print("Erro ao registrar log")

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=4002)
