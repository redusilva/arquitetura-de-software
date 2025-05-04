const express = require('express');
const router = express.Router();
const logController = require('../controllers/logController');

// Rota para criar log
router.post('/', logController.create);

// Rota para buscar logs por sistema
router.get('/:systemId', logController.getBySystem);

module.exports = router;
