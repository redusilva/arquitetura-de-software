const LoggerService = require("../services/logs.service");

class StudentController {
    constructor(userService) {
        this.studentService = userService;
    }

    async getAllStudents(req, res) {
        const result = await this.studentService.getAllStudents();
        return res.status(result?.status).json(result?.message);
    }

    async createStudent(req, res) {
        const data = req.body;

        if (!data?.name || !data?.email || !data?.registration) {
            return res.status(400).json({
                error: 'Envie todos os campos obrigatórios!'
            })
        }

        const result = await this.studentService.createStudent(data);
        const logger = new LoggerService();

        if (result?.status === 201) {
            await logger.createLog({
                message: `Estudante ${result?.message?.id} cadastrado com sucesso!`,
            }, req.token);
            return res.status(result?.status).json({
                message: "Aluno cadastrado com sucesso!",
                data: result?.message
            })
        }

        return res.status(result?.status).json({
            error: result?.message
        });
    }

    async updateStudent(req, res) {
        const data = req.body;
        const id = Number(req?.params?.id);

        if (!id) {
            return res.status(400).json({
                error: 'Envie todos os campos obrigatórios!'
            })
        }

        if (!data?.name && !data?.email && !data?.registration) {
            return res.status(400).json({
                error: 'Envie pelo menos um campo para ser atualizado!'
            })
        }

        const result = await this.studentService.updateStudent(id, data);

        if (result?.status === 200) {
            return res.status(result?.status).json({
                message: "Dados do aluno atualizados com sucesso!",
                data: result?.message
            })
        }

        return res.status(result?.status).json({
            error: result?.message
        });
    }

    async deleteStudent(req, res) {
        const id = Number(req?.params?.id);

        if (!id) {
            return res.status(400).json({
                error: 'Envie todos os campos obrigatórios!'
            })
        }

        const result = await this.studentService.deleteStudent(id);

        if (result?.status === 200) {
            return res.status(result?.status).json({
                message: "Aluno deletado com sucesso!"
            })
        }

        return res.status(result?.status).json({
            error: result?.message
        });
    }
}

module.exports = StudentController;