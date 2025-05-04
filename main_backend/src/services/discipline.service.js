const prisma = require('../config/db');

class RegistrationService {
    constructor(disciplineRepository) {
        this.disciplineRepository = disciplineRepository;
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
}

module.exports = RegistrationService;