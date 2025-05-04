const prisma = require('../config/db');

class StudentService {
    constructor(userRepository) {
        this.studentRepository = userRepository;
    }

    async getAllStudents() {
        const result = await this.studentRepository.getAllStudents(prisma);
        const formattedResult = result.map((student) => {
            return {
                id: student?.id,
                name: student?.nome,
                email: student?.email,
                registration: student?.matricula
            }
        })
        return {
            status: 200,
            message: formattedResult
        }
    }

    async createStudent(data) {
        const currentStudent = await this.studentRepository.findStudentByEmailOrRegistration(data?.email, data?.registration, prisma);
        if (currentStudent) {
            return {
                status: 400,
                message: 'Aluno ja cadastrado no sistema!'
            }
        }

        const result = await this.studentRepository.createStudent(data, prisma);
        if (!result) {
            return {
                status: 400,
                message: 'Erro ao cadastrar aluno!'
            }
        }

        return {
            status: 201,
            message: result
        }
    }

    async updateStudent(id, data) {
        const currentStudent = await this.studentRepository.findStudentById(id, prisma);
        if (!currentStudent) {
            return {
                status: 404,
                message: 'Aluno nao encontrado!'
            }
        }

        const result = await this.studentRepository.updateStudent(id, data, prisma);
        if (!result) {
            return {
                status: 400,
                message: 'Erro ao atualizar aluno!'
            }
        }

        return {
            status: 200,
            message: result
        };
    }

    async deleteStudent(id) {
        const currentStudent = await this.studentRepository.findStudentById(id, prisma);
        if (!currentStudent) {
            return {
                status: 404,
                message: 'Aluno não encontrado!'
            }
        }

        const result = await this.studentRepository.deleteStudent(id, prisma);
        if (!result) {
            return {
                status: 400,
                message: 'Erro ao deletar aluno!'
            }
        }

        return {
            status: 200,
            message: result
        };
    }
}

module.exports = StudentService;