const express = require('express');
const UserRepository = require('../repositories/user.repository');
const UserService = require('../services/user.service');
const UserController = require('../controllers/user.controller');

const router = express.Router();

const userRepository = new UserRepository();
const userService = new UserService(userRepository);
const userController = new UserController(userService);

router.post('/', async (req, res) => {
    try {
        const result = await userController.createUser(req, res);
        return result;
    } catch (error) {
        console.error(error);
        return res.status(500).send('Erro ao criar usuário');
    }
});

router.post('/login', async (req, res) => {
    try {
        const result = await userController.loginUser(req, res);
        return result;
    } catch (error) {
        console.error(error);
        return res.status(500).send('Erro ao criar usuário');
    }
});

router.post('/authenticate', async (req, res) => {
    try {
        const result = await userController.validateUserToken(req, res);
        return result;
    } catch (error) {
        console.error(error);
        return res.status(500).send('Erro ao criar usuário');
    }
});

module.exports = router;