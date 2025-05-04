const express = require('express');
const TeacherRepository = require('../repositories/teacher.repository');
const TeacherService = require('../services/teacher.service');
const TeacherController = require('../controllers/teacher.controller');

const router = express.Router();

const teacherRepository = new TeacherRepository();
const teacherService = new TeacherService(teacherRepository);
const teacherController = new TeacherController(teacherService);

router.post('/', async (req, res) => {
    try {
        const result = await teacherController.createTeacher(req, res);
        return result;
    } catch (error) {
        console.error(error);
        return res.status(500).json({ error: 'Erro ao criar aluno' });
    }
});

router.get('/', async (req, res) => {
    try {
        const result = await teacherController.getAllTeachers(req, res);
        return result;
    } catch (error) {
        console.error(error);
        return res.status(500).json({ error: 'Erro ao criar aluno' });
    }
});

router.put('/:id', async (req, res) => {
    try {
        const result = await teacherController.updateTeacher(req, res);
        return result;
    } catch (error) {
        console.error(error);
        return res.status(500).json({ error: 'Erro ao criar aluno' });
    }
});

router.delete('/:id', async (req, res) => {
    try {
        const result = await teacherController.deleteTeacher(req, res);
        return result;
    } catch (error) {
        console.error(error);
        return res.status(500).json({ error: 'Erro ao criar aluno' });
    }
});

module.exports = router;