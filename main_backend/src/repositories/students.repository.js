class StudentRepository {
    async getAllStudents(database) {
        const result = await database.alunos.findMany({
            orderBy: {
                id: 'asc'
            }
        });
        return result || [];
    }

    async findStudentByEmailOrRegistration(email, registration, database) {
        const result = await database.alunos.findFirst({
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

    async createStudent(data, database) {
        const result = await database.alunos.create({
            data: {
                nome: data?.name,
                email: data?.email,
                matricula: data?.registration
            }
        });
        return result;
    }

    async findStudentById(id, database) {
        const result = await database.alunos.findUnique({
            where: {
                id
            }
        });
        return result;
    }

    async updateStudent(id, data, database) {
        const result = await database.alunos.update({
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

    async deleteStudent(id, database) {
        const result = await database.alunos.delete({
            where: {
                id
            }
        });
        return result;
    }
}

module.exports = StudentRepository;