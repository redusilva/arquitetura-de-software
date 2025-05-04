const express = require('express');
const router = express.Router();
// const logController = require('../controllers/logController');
const authenticateToken = require('../middlewares/authMiddleware');

const LogController = require('../controllers/logController');
const logController = new LogController();  // Criando a instância

// Rota para criar log
router.post('/',logController.create.bind(logController));

// Rota para buscar logs por sistema
router.get('/:systemId', logController.getBySystem.bind(logController));

module.exports = router;
