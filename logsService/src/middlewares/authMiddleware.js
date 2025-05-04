const { verifyToken } = require('../utils/auth');

const authenticateToken = (req, res, next) => {
    const token = req.headers['authorization']?.split(' ')[1];

    if (!token) {
        return res.status(401).json({ error: 'Token de autenticação não fornecido' });
    }

    const result = verifyToken(token);

    if (!result.valid) {
        return res.status(401).json({ error: 'Token inválido' });
    }

    req.user = result.payload;
    next();
};

module.exports = authenticateToken;
