class TeacherDisciplineRepository {
    async findTeacherDisciplineByTeacherIdAndDisciplineId(teacherId, disciplineId, database) {
        const result = await database.professores_disciplinas.findFirst({
            where: {
                id_professor: teacherId,
                id_disciplina: disciplineId
            }
        });
        return result;
    }

    async registerTeacherDiscipline(teacherId, disciplineId, database) {
        const result = await database.professores_disciplinas.create({
            data: {
                id_professor: teacherId,
                id_disciplina: disciplineId
            }
        });
        return result;
    }

    async searchListOfTeachersBySubject(disciplineId, database) {
        const result = await database.professores_disciplinas.findMany({
            where: {
                id_disciplina: disciplineId
            },
            include: {
                professores: true
            }
        });
        return result;
    }

    async deleteTeacherFromDiscipline(disciplineId, teacherId, database) {
        const result = await database.professores_disciplinas.deleteMany({
            where: {
                id_disciplina: disciplineId,
                id_professor: teacherId
            }
        });
        return result;
    }
}

module.exports = TeacherDisciplineRepository;