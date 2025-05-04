class RegistrationController {
    constructor(disciplineService) {
        this.disciplineService = disciplineService;
    }

    async getAll(req, res) {
        const result = await this.disciplineService.getAll();
        return res.status(result?.status).json(result?.message);
    }

    async create(req, res) {
        const data = req.body;

        if (!data?.name) {
            return res.status(400).json({
                error: 'Envie todos os campos obrigatórios!'
            })
        }

        const result = await this.disciplineService.create(data);
        if (result?.status === 201) {
            return res.status(result?.status).json({
                message: "Disciplina cadastrada com sucesso!",
                data: result?.message
            })
        }

        return res.status(result?.status).json({
            error: result?.message
        });
    }

    async update(req, res) {
        const id = Number(req?.params?.id);
        const data = req.body;

        if (!id) {
            return res.status(400).json({
                error: 'Id da disciplina é inválido!'
            })
        }

        if (!data?.name) {
            return res.status(400).json({
                error: 'Envie pelo menos um campo para ser atualizado!'
            })
        }

        const result = await this.disciplineService.update(id, data);

        if (result?.status === 200) {
            return res.status(result?.status).json({
                message: "Disciplina atualizada com sucesso!",
                data: result?.message
            })
        }

        return res.status(result?.status).json({
            error: result?.message
        });
    }

    async delete(req, res) {
        const id = Number(req?.params?.id);
        const result = await this.disciplineService.delete(id);
        if (result?.status === 200) {
            return res.status(result?.status).json({
                message: "Disciplina removida com sucesso!"
            })
        }
        return res.status(result?.status).json({
            error: result?.message
        });
    }
}

module.exports = RegistrationController;