const { Pool } = require('pg');
const config = require('./env');

const pool = new Pool({
    user: config.databaseUser,
    host: config.databaseHost,
    database: config.databaseName,
    password: config.databasePassword,
    port: config.databasePort
});

async function validateDatabase() {
    try {
        await pool.query(`
            CREATE TABLE IF NOT EXISTS public.usuarios (
                id SERIAL PRIMARY KEY,
                nome VARCHAR(255) NOT NULL,
                email VARCHAR(255) NOT NULL,
                senha VARCHAR(255) NOT NULL
            );    
        `);
        return true;
    } catch (error) {
        console.error('Erro ao conectar ao banco de dados:', error);
        return false;
    }
}

setTimeout(() => {
    validateDatabase();
}, 3000);

module.exports = pool;
