const express = require('express');
const DisciplineRepository = require('../repositories/discipline.repository');
const DisciplineService = require('../services/discipline.service');
const DisciplineController = require('../controllers/discipline.controller');

const router = express.Router();

const disciplineRepository = new DisciplineRepository();
const disciplineService = new DisciplineService(disciplineRepository);
const disciplineController = new DisciplineController(disciplineService);

router.post('/', async (req, res) => {
    try {
        const result = await disciplineController.create(req, res);
        return result;
    } catch (error) {
        console.error(error);
        return res.status(500).json({ error: 'Erro ao criar aluno' });
    }
});

router.get('/', async (req, res) => {
    try {
        const result = await disciplineController.getAll(req, res);
        return result;
    } catch (error) {
        console.error(error);
        return res.status(500).json({ error: 'Erro ao buscar as disciplinas' });
    }
});

router.put('/:id', async (req, res) => {
    try {
        const result = await disciplineController.update(req, res);
        return result;
    } catch (error) {
        console.error(error);
        return res.status(500).json({ error: 'Erro ao criar aluno' });
    }
});

router.delete('/:id', async (req, res) => {
    try {
        const result = await disciplineController.delete(req, res);
        return result;
    } catch (error) {
        console.error(error);
        return res.status(500).json({ error: 'Erro ao criar aluno' });
    }
});

module.exports = router;