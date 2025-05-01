const { Pool } = require('pg');
const config = require('./env');

const pool = new Pool({
    user: config.databaseUser,
    host: config.databaseHost,
    database: config.databaseName,
    password: config.databasePassword,
    port: config.databasePort
});

module.exports = pool;
