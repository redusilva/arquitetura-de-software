const prisma = require('../config/db');

class TeacherService {
    constructor(teacherRepository) {
        this.teacherRepository = teacherRepository;
    }

    async createTeacher(data) {
        const currentTeacher = await this.teacherRepository.findTeacherByEmailOrRegistration(
            data?.email,
            data?.registration,
            prisma
        )
        if (currentTeacher) {
            return {
                status: 400,
                message: 'Professor já cadastrado no sistema!'
            }
        }

        const result = await this.teacherRepository.createTeacher(data, prisma);
        if (!result) {
            return {
                status: 400,
                message: 'Erro ao cadastrar professor!'
            }
        }

        return {
            status: 201,
            message: result
        }
    }

    async getAllTeachers() {
        const result = await this.teacherRepository.getAllTeachers(prisma);
        const formattedData = result.map((teacher) => {
            return {
                id: teacher.id,
                name: teacher.nome,
                email: teacher.email,
                registration: teacher.matricula
            }
        })
        return {
            status: 200,
            message: formattedData
        }
    }

    async updateTeacher(id, data) {
        const currentTeacher = await this.teacherRepository.findTeacherById(id, prisma);
        if (!currentTeacher) {
            return {
                status: 404,
                message: 'Professor não encontrado!'
            }
        }
        const result = await this.teacherRepository.updateTeacher(id, data, prisma);
        if (!result) {
            return {
                status: 400,
                message: 'Erro ao atualizar professor!'
            }
        }

        return {
            status: 200,
            message: result
        };
    }

    async deleteTeacher(id) {
        const currentTeacher = await this.teacherRepository.findTeacherById(id, prisma);
        if (!currentTeacher) {
            return {
                status: 404,
                message: 'Professor não encontrado!'
            }
        }

        const result = await this.teacherRepository.deleteTeacher(id, prisma);
        if (!result) {
            return {
                status: 400,
                message: 'Erro ao deletar professor!'
            }
        }

        return {
            status: 200,
            message: result
        };
    }
}

module.exports = TeacherService;