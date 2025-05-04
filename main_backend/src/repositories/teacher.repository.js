class TeacherRepository {
    async findTeacherByEmailOrRegistration(email, registration, database) {
        const result = await database.professores.findFirst({
            where: {
                OR: [
                    { email },
                    { matricula: registration }
                ]
            },
            orderBy: {
                id: 'asc'
            }
        });
        return result;
    }

    async createTeacher(data, database) {
        const result = await database.professores.create({
            data: {
                nome: data?.name,
                email: data?.email,
                matricula: data?.registration
            }
        });
        return result;
    }

    async getAllTeachers(database) {
        const result = await database.professores.findMany({
            orderBy: {
                id: 'asc'
            }
        });
        return result || [];
    }

    async findTeacherById(id, database) {
        const result = await database.professores.findUnique({
            where: {
                id
            }
        });
        return result;
    }

    async updateTeacher(id, data, database) {
        const result = await database.professores.update({
            where: {
                id
            },
            data: {
                nome: data?.name,
                email: data?.email,
                matricula: data?.registration
            }
        });
        return result;
    }

    async deleteTeacher(id, database) {
        const result = await database.professores.delete({
            where: {
                id
            }
        });
        return result;
    }
}

module.exports = TeacherRepository;