const express = require('express');
const router = express.Router();
const systemController = require('../controllers/systemController');
// const authenticateToken = require('../middlewares/authMiddleware');

/**
 * @swagger
 * /api/systems:
 *   post:
 *     summary: Cria um novo sistema
 *     tags: [Sistemas]
 *     security:
 *       - bearerAuth: []
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               name:
 *                 type: string
 *               description:
 *                 type: string
 *             required:
 *               - name
 *               - description
 *     responses:
 *       201:
 *         description: Sistema criado com sucesso
 *       400:
 *         description: Dados inválidos
 */
router.post('/', systemController.create);

module.exports = router;
