require('dotenv').config();

const databaseUser = process.env.DB_USER;
const databasePassword = process.env.DB_PASSWORD;
const databaseName = process.env.DB_NAME;
const databaseHost = process.env.DB_HOST;
const databasePort = parseInt(process.env.DB_PORT, 10);

const serverPort = parseInt(process.env.SERVER_PORT, 10);

const bcryptSaltRounds = parseInt(process.env.BCRYPT_SALT_ROUNDS, 10);
const JWT_SECRET = process.env.JWT_SECRET;
const JWT_EXPIRES_IN = process.env.JWT_EXPIRES_IN;

const systemToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJzdHJpbmciLCJuYW1lIjoic3RyaW5nIiwiaWF0IjoxNzQ2OTY0MTcwfQ.ITM1N3kHpgMrTJOszlp2n8NSdnlcav--MAP3BQ0vHZY";
const logsServiceUrl = process.env.LOGS_SERVICE_URL;
const logsServiceName = process.env.EMAIL_SERVICE_NAME;
const logsSystemId = process.env.EMAIL_SYSTEM_ID;

module.exports = {
    databaseUser,
    databasePassword,
    databaseName,
    databaseHost,
    databasePort,
    serverPort,
    bcryptSaltRounds,
    JWT_SECRET,
    JWT_EXPIRES_IN,
    systemToken,
    logsServiceUrl,
    logsServiceName,
    logsSystemId
};
