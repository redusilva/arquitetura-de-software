const pool = require('../config/db');

class UserRepository {
    async findUserByEmail(email, database) {
        const response = await database.query(
            'SELECT * FROM usuarios WHERE email = $1',
            [email]
        );
        return response.rows[0];
    }

    async findUserById(userId, database) {
        const response = await database.query(
            'SELECT * FROM usuarios WHERE id = $1',
            [userId]
        );
        return response.rows[0];
    }

    async createUser(data, database) {
        const response = await database.query(
            'INSERT INTO usuarios (nome, email, senha) VALUES ($1, $2, $3) RETURNING *',
            [data?.name, data?.email, data?.password]
        );
        return response.rows[0];
    }
}

module.exports = UserRepository;
