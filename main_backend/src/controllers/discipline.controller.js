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

    async registerTeacherDiscipline(req, res) {
        const data = req.body;

        if (!data?.teacherId || !data?.disciplineId) {
            return res.status(400).json({
                error: 'Envie todos os campos obrigatórios!'
            })
        }

        const result = await this.disciplineService.registerTeacherDiscipline(data?.teacherId, data?.disciplineId);
        if (result?.status === 200) {
            return res.status(result?.status).json({
                message: "Professor cadastrado na disciplina!",
                data: result?.message
            })
        }

        return res.status(result?.status).json({
            error: result?.message
        });
    }

    async searchListOfTeachersBySubject(req, res) {
        const id = Number(req?.params?.id);

        const result = await this.disciplineService.searchListOfTeachersBySubject(id);
        if (result?.status === 200) {
            return res.status(result?.status).json(result?.message)
        }

        return res.status(result?.status).json({
            error: result?.message
        });
    }

    async deleteTeacherFromDiscipline(req, res) {
        const disciplineId = Number(req?.params?.idDisciplina);
        const teacherId = Number(req?.params?.idProfessor);

        if (!disciplineId || !teacherId) {
            return res.status(400).json({
                error: 'Informe todos os campos obrigatórios!'
            })
        }

        const result = await this.disciplineService.deleteTeacherFromDiscipline(disciplineId, teacherId);
        if (result?.status === 200) {
            return res.status(result?.status).json({
                message: "Professor removido da disciplina!"
            })
        }
        return res.status(result?.status).json({
            error: result?.message
        });
    }

    async registerStudentDiscipline(req, res) {
        const data = req.body;

        if (!data?.studentId || !data?.disciplineId) {
            return res.status(400).json({
                error: 'Envie todos os campos obrigatórios!'
            })
        }

        const result = await this.disciplineService.registerStudentDiscipline(data?.studentId, data?.disciplineId);
        if (result?.status === 200) {
            return res.status(result?.status).json({
                message: "Aluno cadastrado na disciplina!",
                data: result?.message
            })
        }

        return res.status(result?.status).json({
            error: result?.message
        });
    }

    async searchListOfStudentsBySubject(req, res) {
        const id = Number(req?.params?.id);

        const result = await this.disciplineService.searchListOfStudentsBySubject(id);
        if (result?.status === 200) {
            return res.status(result?.status).json(result?.message)
        }

        return res.status(result?.status).json({
            error: result?.message
        });
    }

    async deleteStudentsFromDiscipline(req, res) {
        const disciplineId = Number(req?.params?.idDisciplina);
        const studentId = Number(req?.params?.idAluno);

        if (!disciplineId || !studentId) {
            return res.status(400).json({
                error: 'Informe todos os campos obrigatórios!'
            })
        }

        const result = await this.disciplineService.deleteStudentsFromDiscipline(disciplineId, studentId);
        if (result?.status === 200) {
            return res.status(result?.status).json({
                message: "Aluno removido da disciplina!"
            })
        }
        return res.status(result?.status).json({
            error: result?.message
        });
    }
}

module.exports = RegistrationController;