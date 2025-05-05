const prisma = require('../config/db');

class NotesService {
    constructor(
        notesRepository,
        studentDisciplineRepository
    ) {
        this.notesRepository = notesRepository;
        this.studentDisciplineRepository = studentDisciplineRepository;
    }

    async create(studentId, disciplineId, value) {
        const currentStudentDiscipline = await this.studentDisciplineRepository.findStudentDisciplineByStudentIdAndDisciplineId(
            studentId,
            disciplineId,
            prisma
        );
        if (!currentStudentDiscipline) {
            return {
                status: 400,
                message: 'Aluno não cadastrado na disciplina!'
            }
        }

        const currentNote = await this.notesRepository.findNotesByDisciplineIdAndStudentId(disciplineId, studentId, prisma);
        if (currentNote) {
            return {
                status: 400,
                message: 'Aluno já foi avaliado nessa disciplina!'
            }
        }

        const result = await this.notesRepository.create(studentId, disciplineId, value, prisma);
        if (!result) {
            return {
                status: 400,
                message: 'Erro ao criar nota!'
            }
        }

        return {
            status: 201,
            message: {
                id: result?.id,
                studentId: result?.id_aluno,
                disciplineId: result?.id_disciplina,
                value: result?.valor
            }
        };
    }

    async getAllTheStudentsNotes(id) {
        const result = await this.notesRepository.getAllTheStudentsNotes(id, prisma);
        const formattedResult = result?.alunos_disciplinas?.map((note) => {
            return {
                studentId: note?.id_aluno,
                disciplineId: note?.disciplinas?.id,
                disciplineName: note?.disciplinas?.nome,
                subjectNote: note?.disciplinas?.notas[0]?.valor || 0,
                teachers: note?.disciplinas?.professores_disciplinas?.map((teacher) => ({
                    id: teacher?.professores?.id,
                    name: teacher?.professores?.nome,
                    email: teacher?.professores?.email,
                    registration: teacher?.professores?.matricula
                })),
            }
        })

        return {
            status: 200,
            message: formattedResult
        }
    }

    async deleteNote(id) {
        const currentNote = await this.notesRepository.findById(id, prisma);
        if (!currentNote) {
            return {
                status: 404,
                message: 'Nota não encontrada!'
            }
        }

        const result = await this.notesRepository.deleteNote(id, prisma);
        return {
            status: 200,
            message: 'Nota deletada com sucesso!'
        }
    }

    async updateNote(id, value) {
        const currentNote = await this.notesRepository.findById(id, prisma);
        if (!currentNote) {
            return {
                status: 404,
                message: 'Nota não encontrada!'
            }
        }

        const result = await this.notesRepository.updateNote(id, value, prisma);
        return {
            status: 200,
            message: {
                id: result?.id,
                studentId: result?.id_aluno,
                disciplineId: result?.id_disciplina,
                value: result?.valor
            }
        }
    }
}

module.exports = NotesService;