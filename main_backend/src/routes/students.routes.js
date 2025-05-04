const express = require('express');
const StudentRepository = require('../repositories/students.repository');
const StudentService = require('../services/students.service');
const StudentController = require('../controllers/students.controller');

const router = express.Router();

const studentRepository = new StudentRepository();
const studentService = new StudentService(studentRepository);
const studentController = new StudentController(studentService);

router.put('/:id', async (req, res) => {
    try {
        const result = await studentController.updateStudent(req, res);
        return result;
    } catch (error) {
        console.error(error);
        return res.status(500).json({ error: 'Erro ao criar aluno' });
    }
});

router.delete('/:id', async (req, res) => {
    try {
        const result = await studentController.deleteStudent(req, res);
        return result;
    } catch (error) {
        console.error(error);
        return res.status(500).json({ error: 'Erro ao criar aluno' });
    }
});

router.post('/', async (req, res) => {
    try {
        const result = await studentController.createStudent(req, res);
        return result;
    } catch (error) {
        console.error(error);
        return res.status(500).json({ error: 'Erro ao criar aluno' });
    }
});

router.get('/', async (req, res) => {
    try {
        const result = await studentController.getAllStudents(req, res);
        return result;
    } catch (error) {
        console.error(error);
        return res.status(500).json({ error: 'Erro ao buscar os alunos' });
    }
});

module.exports = router;