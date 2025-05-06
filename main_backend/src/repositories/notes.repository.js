class NotesRepository {
    async create(studentId, disciplineId, note, database) {
        const result = await database.notas.create({
            data: {
                id_aluno: studentId,
                id_disciplina: disciplineId,
                valor: note
            }
        });
        return result;
    }

    async findNotesByDisciplineIdAndStudentId(disciplineId, studentId, database) {
        const result = await database.notas.findFirst({
            where: {
                id_disciplina: disciplineId,
                id_aluno: studentId
            }
        });
        return result;
    }

    async getStudentsNotes(studentId, database) {
        const result = await database.notas.findMany({
            where: {
                id_aluno: studentId
            }
        });
        return result;
    }

    async getAllTheStudentsNotes(id, database) {
        const result = await database.alunos.findUnique({
            where: {
                id,
            },
            include: {
                alunos_disciplinas: {
                    include: {
                        disciplinas: {
                            include: {
                                notas: {
                                    where: {
                                        id_aluno: id
                                    },
                                    select: {
                                        valor: true,
                                        id: true
                                    }
                                },
                                professores_disciplinas: {
                                    include: {
                                        professores: {
                                            select: {
                                                id: true,
                                                nome: true,
                                                email: true
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        });

        return result;
    }

    async deleteNote(id, database) {
        const result = await database.notas.delete({
            where: {
                id
            }
        });
        return result;
    }

    async findById(id, database) {
        const result = await database.notas.findUnique({
            where: {
                id
            }
        });
        return result;
    }

    async updateNote(id, value, database) {
        const result = await database.notas.update({
            where: {
                id
            },
            data: {
                valor: value
            }
        });
        return result;
    }
}

module.exports = NotesRepository;