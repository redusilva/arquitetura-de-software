class DisciplineRepository {
    async getAll(database) {
        const result = await database.disciplinas.findMany({
            orderBy: {
                id: 'asc'
            }
        });
        return result || [];
    }

    async create(data, database) {
        const result = await database.disciplinas.create({
            data: {
                nome: data?.name
            }
        });
        return result;
    }

    async findById(id, database) {
        const result = await database.disciplinas.findUnique({
            where: {
                id
            }
        });
        return result;
    }

    async update(id, data, database) {
        const result = await database.disciplinas.update({
            where: {
                id
            },
            data: {
                nome: data?.name
            }
        });
        return result;
    }

    async delete(id, database) {
        const result = await database.disciplinas.delete({
            where: {
                id
            }
        });
        return result;
    }
}

module.exports = DisciplineRepository;