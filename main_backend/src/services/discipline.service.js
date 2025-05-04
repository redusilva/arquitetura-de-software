const prisma = require('../config/db');

class RegistrationService {
    constructor(
        disciplineRepository,
        teacherDisciplineRepository,
        teacherRepository,
        studentDisciplineRepository,
        studentRepository
    ) {
        this.disciplineRepository = disciplineRepository;
        this.teacherDisciplineRepository = teacherDisciplineRepository;
        this.teacherRepository = teacherRepository;
        this.studentDisciplineRepository = studentDisciplineRepository;
        this.studentRepository = studentRepository;
    }

    async getAll() {
        const result = await this.disciplineRepository.getAll(prisma);
        const formattedResult = result?.map((discipline) => {
            return {
                id: discipline?.id,
                name: discipline?.nome
            }
        });

        return {
            status: 200,
            message: formattedResult
        }
    }

    async create(data) {
        const result = await this.disciplineRepository.create(data, prisma);
        if (!result) {
            return {
                status: 400,
                message: 'Erro ao criar disciplina!'
            }
        }

        return {
            status: 201,
            message: result
        }
    }

    async update(id, data) {
        const currentDiscipline = await this.disciplineRepository.findById(id, prisma);
        if (!currentDiscipline) {
            return {
                status: 404,
                message: 'Disciplina não encontrada!'
            }
        }

        const result = await this.disciplineRepository.update(id, data, prisma);
        if (!result) {
            return {
                status: 400,
                message: 'Erro ao atualizar disciplina!'
            }
        }

        return {
            status: 200,
            message: result
        }
    }

    async delete(id) {
        const currentDiscipline = await this.disciplineRepository.findById(id, prisma);
        if (!currentDiscipline) {
            return {
                status: 404,
                message: 'Disciplina não encontrada!'
            }
        }

        const result = await this.disciplineRepository.delete(id, prisma);
        if (!result) {
            return {
                status: 400,
                message: 'Erro ao deletar disciplina!'
            }
        }

        return {
            status: 200,
            message: result
        };
    }

    async registerTeacherDiscipline(teacherId, disciplineId) {
        const [
            teacher,
            discipline
        ] = await Promise.all([
            this.teacherRepository.findTeacherById(teacherId, prisma),
            this.disciplineRepository.findById(disciplineId, prisma)
        ]);

        if (!teacher || !discipline) {
            return {
                status: 404,
                message: 'Disciplina ou professor não encontrados!'
            }
        }

        const currentTeacherDiscipline = await this.teacherDisciplineRepository.findTeacherDisciplineByTeacherIdAndDisciplineId(teacherId, disciplineId, prisma);
        if (currentTeacherDiscipline) {
            return {
                status: 400,
                message: 'Professor já cadastrado na disciplina!'
            }
        }

        const result = await this.teacherDisciplineRepository.registerTeacherDiscipline(teacherId, disciplineId, prisma);
        if (!result) {
            return {
                status: 400,
                message: 'Erro ao cadastrar disciplina!'
            }
        }

        return {
            status: 200,
            message: {
                disciplineId: result?.id_disciplina,
                teacherId: result?.id_professor
            }
        }

    }

    async searchListOfTeachersBySubject(disciplineId) {
        const currentDiscipline = await this.disciplineRepository.findById(disciplineId, prisma);
        if (!currentDiscipline) {
            return {
                status: 404,
                message: 'Disciplina não encontrada!'
            }
        }

        const result = await this.teacherDisciplineRepository.searchListOfTeachersBySubject(disciplineId, prisma);

        const formattedData = result?.map((teacherDiscipline) => {
            return {
                id: teacherDiscipline?.id,
                teacherId: teacherDiscipline?.id_professor,
                disciplineId: teacherDiscipline?.id_disciplina,
                teacherName: teacherDiscipline?.professores?.nome,
                teacherEmail: teacherDiscipline?.professores?.email,
                teacherRegistration: teacherDiscipline?.professores?.matricula
            }
        });

        return {
            status: 200,
            message: formattedData
        }
    }

    async deleteTeacherFromDiscipline(disciplineId, teacherId) {
        const currentDiscipline = await this.disciplineRepository.findById(disciplineId, prisma);
        if (!currentDiscipline) {
            return {
                status: 404,
                message: 'Disciplina não encontrada!'
            }
        }

        const teacher = await this.teacherRepository.findTeacherById(teacherId, prisma);
        if (!teacher) {
            return {
                status: 404,
                message: 'Professor não encontrado!'
            }
        }

        const result = await this.teacherDisciplineRepository.deleteTeacherFromDiscipline(disciplineId, teacherId, prisma);
        if (!result) {
            return {
                status: 400,
                message: 'Erro ao deletar disciplina!'
            }
        }

        return {
            status: 200,
            message: result
        };
    }

    async registerStudentDiscipline(studentId, disciplineId) {
        const [
            student,
            discipline
        ] = await Promise.all([
            this.studentRepository.findStudentById(studentId, prisma),
            this.disciplineRepository.findById(disciplineId, prisma)
        ]);

        if (!student || !discipline) {
            return {
                status: 404,
                message: 'Disciplina ou aluno não encontrados!'
            }
        }

        const currentStudentDiscipline = await this.studentDisciplineRepository.findStudentDisciplineByStudentIdAndDisciplineId(studentId, disciplineId, prisma);
        if (currentStudentDiscipline) {
            return {
                status: 400,
                message: 'Aluno já cadastrado na disciplina!'
            }
        }

        const result = await this.studentDisciplineRepository.registerStudentDiscipline(studentId, disciplineId, prisma);
        if (!result) {
            return {
                status: 400,
                message: 'Erro ao cadastrar aluno na disciplina!'
            }
        }

        return {
            status: 200,
            message: {
                disciplineId: result?.id_disciplina,
                studentId: result?.id_aluno
            }
        }
    }

    async searchListOfStudentsBySubject(disciplineId) {
        const currentDiscipline = await this.disciplineRepository.findById(disciplineId, prisma);
        if (!currentDiscipline) {
            return {
                status: 404,
                message: 'Disciplina não encontrada!'
            }
        }

        const result = await this.studentDisciplineRepository.searchListOfStudentsBySubject(disciplineId, prisma);

        const formattedData = result?.map((studentDiscipline) => {
            return {
                id: studentDiscipline?.id,
                studentId: studentDiscipline?.id_aluno,
                disciplineId: studentDiscipline?.id_disciplina,
                studentName: studentDiscipline?.alunos?.nome,
                studentEmail: studentDiscipline?.alunos?.email,
                studentRegistration: studentDiscipline?.alunos?.matricula
            }
        });

        return {
            status: 200,
            message: formattedData
        }
    }

    async deleteStudentsFromDiscipline(disciplineId, studentId) {
        const currentDiscipline = await this.disciplineRepository.findById(disciplineId, prisma);
        if (!currentDiscipline) {
            return {
                status: 404,
                message: 'Disciplina não encontrada!'
            }
        }

        const student = await this.studentRepository.findStudentById(studentId, prisma);
        if (!student) {
            return {
                status: 404,
                message: 'Aluno não encontrado!'
            }
        }

        const result = await this.studentDisciplineRepository.deleteStudentsFromDiscipline(disciplineId, studentId, prisma);
        if (!result) {
            return {
                status: 400,
                message: 'Erro ao deletar disciplina!'
            }
        }

        return {
            status: 200,
            message: result
        };
    }
}

module.exports = RegistrationService;