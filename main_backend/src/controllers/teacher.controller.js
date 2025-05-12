const LoggerService = require("../services/logs.service");

class TeacherController {
    constructor(teacherService) {
        this.teacherService = teacherService;
    }

    async createTeacher(req, res) {
        try {
            const data = req.body;

            if (!data?.name || !data?.email || !data?.registration) {
                return res.status(400).json({ error: 'Envie todos os campos obrigatórios!' });
            }

            const logger = new LoggerService();
            const result = await this.teacherService.createTeacher(data);
            if (result?.status === 201) {
                await logger.createLog({
                    message: `Professor ${result?.message?.id} cadastrado com sucesso!`,
                }, req.token);
                return res.status(result?.status).json({
                    message: "Professor cadastrado com sucesso!",
                    data: result?.message
                })
            }

            return res.status(result?.status).json({
                error: result?.message
            });
        } catch (error) {
            console.error(error);
            return res.status(500).json({ error: 'Erro ao criar professor' });
        }
    }

    async getAllTeachers(req, res) {
        try {
            const result = await this.teacherService.getAllTeachers();
            if (result?.status === 200) {
                return res.status(result?.status).json(result?.message);
            }
            throw new Error('Não foi possivel buscar todos os professores no sistema!');
        } catch (error) {
            console.error(error);
            return res.status(500).json({ error: 'Erro ao buscar os professores' });
        }
    }

    async updateTeacher(req, res) {
        try {
            const id = Number(req?.params?.id);
            const data = req.body;

            if (!id) {
                return res.status(400).json({
                    error: 'Id do professor é inválido!'
                })
            }

            if (!data?.name && !data?.email && !data?.registration) {
                return res.status(400).json({
                    error: 'Envie pelo menos um campo para ser atualizado!'
                })
            }

            const result = await this.teacherService.updateTeacher(id, data);

            if (result?.status === 200) {
                return res.status(result?.status).json({
                    message: "Dados do professor atualizados com sucesso!",
                    data: result?.message
                })
            }

            return res.status(result?.status).json({
                error: result?.message
            });
        } catch (error) {
            console.error(error);
            return res.status(500).json({ error: 'Erro ao atualizar professor' });
        }
    }

    async deleteTeacher(req, res) {
        try {
            const id = Number(req?.params?.id);
            const result = await this.teacherService.deleteTeacher(id);
            if (result?.status === 200) {
                return res.status(result?.status).json({
                    message: "Professor excluido com sucesso!"
                })
            }
            return res.status(result?.status).json({
                error: result?.message
            });
        } catch (error) {
            console.error(error);
            return res.status(500).json({ error: 'Erro ao deletar professor' });
        }
    }
}

module.exports = TeacherController;