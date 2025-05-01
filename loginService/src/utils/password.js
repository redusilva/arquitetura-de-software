const bcrypt = require('bcrypt');
const { bcryptSaltRounds } = require('../config/env');

async function hashPassword(password) {
    const hashed = await bcrypt.hash(password, bcryptSaltRounds);
    return hashed;
}

async function comparePassword(plainPassword, hashedPassword) {
    const isMatch = await bcrypt.compare(plainPassword, hashedPassword);
    return isMatch;
}

module.exports = {
    hashPassword,
    comparePassword,
};
