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

const authServiceUrl = process.env.AUTH_SERVICE_URL;
const logsServiceUrl = process.env.LOGS_SERVICE_URL;
const logsSystemId = process.env.LOGS_SYSTEM_ID;
const logsServiceName = process.env.LOGS_SERVICE_NAME;

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
    authServiceUrl,
    logsServiceUrl,
    logsSystemId,
    logsServiceName
};
