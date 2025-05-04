const axios = require('axios');
const { authServiceUrl } = require('../config/env');

const authMiddleware = async (req, res, next) => {
    try {
        const token = req?.headers?.authorization?.split('Bearer ')[1];
        const response = await axios.post(`${authServiceUrl}/users/authenticate`, {
            token
        });
        if (response.status === 200) {
            return next();
        }
        return res.status(401).json({ error: 'Usuário não autenticado!' });
    } catch (error) {
        console.error(error);
        return res.status(401).json({ error: 'Usuário não autenticado!' });
    }
};

module.exports = authMiddleware;