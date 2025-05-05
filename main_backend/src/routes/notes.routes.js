const express = require('express');
const NotesRepository = require('../repositories/notes.repository');
const NotesService = require('../services/notes.service');
const NotesController = require('../controllers/notes.controller');
const StudentDisciplineRepository = require('../repositories/student_discipline.repository');

const router = express.Router();

const notesRepository = new NotesRepository();
const studentDisciplineRepository = new StudentDisciplineRepository();
const notesService = new NotesService(
    notesRepository,
    studentDisciplineRepository
);
const controller = new NotesController(notesService);

router.post('/', async (req, res) => {
    try {
        const result = await controller.create(req, res);
        return result;
    } catch (error) {
        console.error(error);
        return res.status(500).json({ error: 'Erro ao criar nota do aluno' });
    }
});

router.get('/:id', async (req, res) => {
    try {
        const result = await controller.getAllTheStudentsNotes(req, res);
        return result;
    } catch (error) {
        console.error(error);
        return res.status(500).json({ error: 'Erro ao buscar as notas dos alunos' });
    }
});

router.delete('/:id', async (req, res) => {
    try {
        const result = await controller.deleteNote(req, res);
        return result;
    } catch (error) {
        console.error(error);
        return res.status(500).json({ error: 'Erro ao buscar as notas dos alunos' });
    }
});

router.put('/:id', async (req, res) => {
    try {
        const result = await controller.updateNote(req, res);
        return result;
    } catch (error) {
        console.error(error);
        return res.status(500).json({ error: 'Erro ao buscar as notas dos alunos' });
    }
});

module.exports = router;