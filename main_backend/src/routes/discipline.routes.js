const express = require('express');
const DisciplineRepository = require('../repositories/discipline.repository');
const DisciplineService = require('../services/discipline.service');
const DisciplineController = require('../controllers/discipline.controller');
const TeacherDisciplineRepository = require('../repositories/teacher_discipline.repository');
const TeacherRepository = require('../repositories/teacher.repository');
const StudentDisciplineRepository = require('../repositories/student_discipline.repository');
const StudentRepository = require('../repositories/students.repository');

const router = express.Router();

const disciplineRepository = new DisciplineRepository();
const teacherRepository = new TeacherRepository();
const teacherDisciplineRepository = new TeacherDisciplineRepository();
const studentDisciplineRepository = new StudentDisciplineRepository();
const studentRepository = new StudentRepository();
const disciplineService = new DisciplineService(
    disciplineRepository,
    teacherDisciplineRepository,
    teacherRepository,
    studentDisciplineRepository,
    studentRepository
);
const disciplineController = new DisciplineController(disciplineService);

router.post('/teacher', async (req, res) => {
    try {
        const result = await disciplineController.registerTeacherDiscipline(req, res);
        return result;
    } catch (error) {
        console.error(error);
        return res.status(500).json({ error: 'Erro ao criar aluno' });
    }
});

router.get('/teacher/:id', async (req, res) => {
    try {
        const result = await disciplineController.searchListOfTeachersBySubject(req, res);
        return result;
    } catch (error) {
        console.error(error);
        return res.status(500).json({ error: 'Erro ao criar aluno' });
    }
});

router.delete('/teacher/:idDisciplina/:idProfessor', async (req, res) => {
    try {
        const result = await disciplineController.deleteTeacherFromDiscipline(req, res);
        return result;
    } catch (error) {
        console.error(error);
        return res.status(500).json({ error: 'Erro ao criar aluno' });
    }
});

router.post('/aluno', async (req, res) => {
    try {
        const result = await disciplineController.registerStudentDiscipline(req, res);
        return result;
    } catch (error) {
        console.error(error);
        return res.status(500).json({ error: 'Erro ao criar aluno' });
    }
});

router.get('/aluno/:id', async (req, res) => {
    try {
        const result = await disciplineController.searchListOfStudentsBySubject(req, res);
        return result;
    } catch (error) {
        console.error(error);
        return res.status(500).json({ error: 'Erro ao criar aluno' });
    }
});

router.delete('/aluno/:idDisciplina/:idAluno', async (req, res) => {
    try {
        const result = await disciplineController.deleteStudentsFromDiscipline(req, res);
        return result;
    } catch (error) {
        console.error(error);
        return res.status(500).json({ error: 'Erro ao criar aluno' });
    }
});

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