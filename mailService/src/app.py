from flask import Flask, request, jsonify
import requests
from flasgger import Swagger, swag_from
from dotenv import load_dotenv
import os

load_dotenv(dotenv_path='.env')

AUTH_SERVICE_URL = os.getenv("AUTH_SERVICE_URL")
LOG_SERVICE_URL = os.getenv("LOG_SERVICE_URL")

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
    except requests.exceptions.RequestException:
        return jsonify({"error": "Erro ao verificar token"}), 500

    data = request.get_json()
    to = data.get("to")
    subject = data.get("subject", "Sem assunto")
    message = data.get("message")

    if not to or not message:
        return jsonify({"error": "Campos obrigatórios ausentes"}), 400

    print(f"Enviando e-mail para {to} | Assunto: {subject} | Mensagem: {message}")

    try:
        log_data = {
            "system": "email-service",
            "message": f"E-mail enviado para {to} com assunto '{subject}'"
        }
        requests.post(LOG_SERVICE_URL, json=log_data, headers={"Authorization": token})
    except requests.exceptions.RequestException:
        print("Erro ao registrar log")

    return jsonify({"message": "E-mail enviado com sucesso"}), 200

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=4002)
