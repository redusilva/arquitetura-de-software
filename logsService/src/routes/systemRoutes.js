const express = require('express');
const router = express.Router();
const systemController = require('../controllers/systemController');
const authenticateToken = require('../middlewares/authMiddleware');

// Rota para criar sistema
router.post('/', authenticateToken, systemController.create);

module.exports = router;
