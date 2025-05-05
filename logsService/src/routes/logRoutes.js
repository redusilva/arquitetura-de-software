const express = require('express');
const router = express.Router();
const LogController = require('../controllers/logController');
const logController = new LogController();

/**
 * @swagger
 * /api/logs:
 *   post:
 *     summary: Cria um novo log
 *     tags: [Logs]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               message:
 *                 type: string
 *               level:
 *                 type: string
 *                 enum: [info, warn, error]
 *               source:
 *                 type: string
 *                 enum: [aplicacao, auth, emails]
 *               systemId:
 *                 type: string
 *               email:
 *                 type: string
 *     responses:
 *       201:
 *         description: Log criado com sucesso
 *       400:
 *         description: Erro de validação
 */
router.post('/', logController.create.bind(logController));

/**
 * @swagger
 * /api/logs/{systemId}:
 *   get:
 *     summary: Busca logs por ID do sistema
 *     tags: [Logs]
 *     parameters:
 *       - in: path
 *         name: systemId
 *         required: true
 *         schema:
 *           type: string
 *         description: ID do sistema para filtrar logs
 *     responses:
 *       200:
 *         description: Lista de logs
 *       404:
 *         description: Nenhum log encontrado para o sistema
 */
router.get('/:systemId', logController.getBySystem.bind(logController));

module.exports = router;
