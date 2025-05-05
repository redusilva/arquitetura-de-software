const System = require('../models/system');

class SystemRepository {
  async save(systemData) {
    const system = new System(systemData);
    return await system.save();
  }

  async findById(systemId) {
    return await System.findById(systemId);
  }

  async findOne(query) {
    return await System.findOne(query); // Método para buscar um sistema pelo nome
  }

  async findAll() {
    return await System.find();
  }

}

module.exports = new SystemRepository();
