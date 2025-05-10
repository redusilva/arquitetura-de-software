const LoggerService = require("../services/logs.service");

class NotesController {
    constructor(notesService) {
        this.notesService = notesService;
    }

    async create(req, res) {
        const data = req.body;
        if (!data?.studentId || !data?.disciplineId || !data?.value) {
            return res.status(400).json({
                error: 'Envie todos os campos obrigatórios!'
            })
        }

        const studentId = Number(data?.studentId);
        const disciplineId = Number(data?.disciplineId);
        const value = Number(data?.value);

        const logger = new LoggerService();
        const result = await this.notesService.create(studentId, disciplineId, value);
        if (result?.status === 201) {
            logger.createLog({
                message: `Nota ${result?.message?.value} cadastrada para o aluno ${result?.message?.studentId} na disciplina ${result?.message?.disciplineId} com sucesso!`,
            }, req.token);
            return res.status(result?.status).json({
                message: "Nota criada com sucesso!",
                data: result?.message
            })
        }

        return res.status(result?.status).json({
            error: result?.message
        });
    }

    async getAllTheStudentsNotes(req, res) {
        const id = Number(req?.params?.id);
        const result = await this.notesService.getAllTheStudentsNotes(id);
        if (result?.status === 200) {
            return res.status(result?.status).json(result?.message)
        }
        return res.status(result?.status).json({
            error: result?.message
        });
    }

    async deleteNote(req, res) {
        const id = Number(req?.params?.id);

        if (!id) {
            return res.status(400).json({
                error: 'Envie todos os campos obrigatórios!'
            })
        }

        const result = await this.notesService.deleteNote(id);

        if (result?.status === 200) {
            return res.status(result?.status).json({ message: result?.message })
        }

        return res.status(result?.status).json({
            error: result?.message
        });
    }

    async updateNote(req, res) {
        const id = Number(req?.params?.id);
        const data = req.body;

        if (!id) {
            return res.status(400).json({
                error: 'Envie todos os campos obrigatórios!'
            })
        }

        const value = Number(data?.value);

        if (!value) {
            return res.status(400).json({
                error: 'Envie pelo menos um campo para ser atualizado!'
            })
        }

        const result = await this.notesService.updateNote(id, value);

        if (result?.status === 200) {
            return res.status(result?.status).json({
                message: "Nota atualizada com sucesso!",
                data: result?.message
            })
        }

        return res.status(result?.status).json({
            error: result?.message
        });
    }
}

module.exports = NotesController;