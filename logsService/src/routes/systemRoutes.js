const express = require('express');
const router = express.Router();
const systemController = require('../controllers/systemController');

// Rota para criar sistema
router.post('/', systemController.create);

module.exports = router;
