// repositories/systemRepository.js
const System = require('../models/system');

class SystemRepository {
  async save(systemData) {
    const system = new System(systemData);
    return await system.save();
  }

  async findById(systemId) {
    return await System.findById(systemId);
  }

  async findAll() {
    return await System.find();
  }

  // Outros métodos, se necessário
}

module.exports = new SystemRepository();
