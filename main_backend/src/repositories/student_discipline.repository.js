class StudentDisciplineRepository {
    async findStudentDisciplineByStudentIdAndDisciplineId(studentId, disciplineId, database) {
        const result = await database.alunos_disciplinas.findFirst({
            where: {
                id_aluno: studentId,
                id_disciplina: disciplineId
            }
        });
        return result;
    }

    async registerStudentDiscipline(studentId, disciplineId, database) {
        const result = await database.alunos_disciplinas.create({
            data: {
                id_aluno: studentId,
                id_disciplina: disciplineId
            }
        });
        return result;
    }

    async searchListOfStudentsBySubject(disciplineId, database) {
        const result = await database.alunos_disciplinas.findMany({
            where: {
                id_disciplina: disciplineId
            },
            include: {
                alunos: true
            }
        });
        return result;
    }

    async deleteStudentsFromDiscipline(disciplineId, studentId, database) {
        const result = await database.alunos_disciplinas.deleteMany({
            where: {
                id_disciplina: disciplineId,
                id_aluno: studentId
            }
        });
        return result;
    }

    async getAllCandidateRegisteredSubjects(id, database) {
        const result = await database.alunos_disciplinas.findMany({
            where: {
                id_aluno: id
            }
        })
        return result;
    }
}

module.exports = StudentDisciplineRepository;