const System = require('../models/system');

class SystemRepository {
  async save(systemData) {
    const system = new System(systemData);
    console.log('Tentando salvar o sistema:', systemData);
    try {
      const savedSystem = await system.save();
      console.log('Sistema salvo com sucesso:', savedSystem);
      return savedSystem;
    } catch (error) {
      console.error('Erro ao salvar sistema:', error);
      throw error;
    }
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
