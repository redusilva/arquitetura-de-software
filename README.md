# Arquitetura de Software – Plataforma Acadêmica

Repositório: https://github.com/redusilva/arquitetura-de-software/tree/main

---

## 📝 Visão Geral

Plataforma acadêmica composta por microsserviços e aplicações web para gestão de alunos, professores, disciplinas, matrículas e envio de e-mails, com registro centralizado de logs e autenticação unificada.

---

## 🚀 Serviços e Portas

| Serviço                        | Responsável | Porta  | Descrição resumida                                       |
|--------------------------------|-------------|--------|----------------------------------------------------------|
| Microsserviço de Autenticação  | Rodrigo     | 4000   | Registro e login de usuários; validação de tokens        |
| Microsserviço de Logs          | Geovanna    | 4001   | Cadastro de sistemas, registro e consulta de logs        |
| Microsserviço de E-mail        | Tarcísio    | 4002   | Envio de e-mails; log de mensagens                      |
| Backend Principal              | Rodrigo     | 4003   | CRUD de alunos/professores/disciplinas; renovação de matrícula |
| Front-end Web                  | Tarcyo      | 6660   | Interface de login e cadastros; boletim e renovação      |

---

## 🔧 Funcionalidades Detalhadas

### Microsserviço de Autenticação (porta 4000)
- **Rotas principais**  
  - `POST /users/register` – cria novo usuário  
  - `POST /users/login` – autentica e gera token  
  - `GET  /users/validate` – valida token JWT  
- **Persistência**: banco de dados relacional  
- **Logs**: registra todas as operações no microsserviço de logs  
- **Documentação**: disponível em `http://localhost:4000/api-docs/`

### Microsserviço de Logs (porta 4001)
- **Rotas principais**  
  - `POST /api/systems` – cadastra novo sistema/aplicação  
  - `POST /api/logs`    – registra um log  
  - `GET  /api/logs/{systemId}` – lista logs do sistema solicitado  
- **Autenticação**: valida token no microsserviço de autenticação  
- **Persistência**: banco de dados dedicado (serviço Docker separado)  
- **Documentação**: `http://localhost:4001/api-docs/#/Logs/post_api_logs`

### Microsserviço de E-mail (porta 4002)
- **Rotas principais**  
  - `POST /api/emails/send` – envia e-mail (mensagem + destinatário)  
- **Autenticação**: verifica token no microsserviço de autenticação  
- **Logs**: envia registros de cada mensagem para o microsserviço de logs  
- **Documentação**: `http://localhost:4002/apidocs`  
  - Swagger JSON: `mailService/docs/swagger.json`

### Backend Principal (porta 4003)
- **Rotas principais**  
  - `POST   /api/alunos`        – cadastra aluno  
  - `POST   /api/professores`   – cadastra professor  
  - `POST   /api/disciplinas`   – cadastra disciplina  
  - `PUT    /api/disciplinas/{id}/renovar` – renova matrícula  
  - `POST   /users/login`       – login via microsserviço de autenticação  
- **Logs**: todas as chamadas registradas no microsserviço de logs  
- **Documentação**: `http://localhost:4003/api-docs/`

### Front-end Web (porta 6660)
- **Fluxos de tela**  
  - Login  
  - Cadastro de Aluno  
  - Cadastro de Professor  
  - Cadastro de Disciplinas  
  - Renovação de Disciplina  
  - Boletim  
- **Integrações**: consome APIs de autenticação, backend e microsserviços  
- **Container**: Docker + Docker Compose

---

## 📦 Pré-requisitos

1. [Docker](https://www.docker.com/) instalado  
2. [Docker Compose](https://docs.docker.com/compose/) instalado  

---

## ⚙️ Como Executar

1. Clone o repositório:  
   ```bash
   git clone https://github.com/redusilva/arquitetura-de-software.git
   cd arquitetura-de-software
2. Na raiz do projeto execute: docker compose up -d
3. Aguarde todos os contêineres iniciarem (pode levar alguns instantes na primeira vez).

4. No navegador, acesse: http://localhost:6660
5. Você verá a seguinte tela abaixo, crie um usuário teste e então faça login.

![image](https://github.com/user-attachments/assets/9c95103d-4d43-4b47-956f-0afccf6156c6)


