const jwt = require('jsonwebtoken');
const {
    JWT_SECRET,
    JWT_EXPIRES_IN,
} = require('../config/env');

function generateToken(payload) {
    const token = jwt.sign(payload, JWT_SECRET, {
        expiresIn: JWT_EXPIRES_IN,
    });
    return token;
}

function verifyToken(token) {
    try {
        const decoded = jwt.verify(token, JWT_SECRET);
        return { valid: true, payload: decoded };
    } catch (error) {
        return { valid: false, error: error.message };
    }
}

module.exports = {
    generateToken,
    verifyToken,
};
