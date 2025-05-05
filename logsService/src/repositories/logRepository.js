const Log = require('../models/log');
const mongoose = require('mongoose');

class LogRepository {
  // Método para salvar um novo log no banco de dados
  async save(logData) {
    try {
      // Verificando se os dados são válidos
      if (!logData || !logData.systemId || !logData.message || !logData.source) {
        throw new Error('Dados de log incompletos. Verifique os campos: systemId, message e source.');
      }

      const log = new Log(logData);
      await log.save();
      return log;  // Retorna o log salvo
    } catch (error) {
      console.error('Erro ao salvar o log:', error.message || error);  // Logando o erro completo
      throw new Error('Erro ao salvar o log no banco de dados: ' + error.message);
    }
  }

  // Método para buscar logs por sistema e usuário
  async findBySystem(systemId) {
    console.log('Consultando logs com systemId:', systemId);
  
    try {
      if (!systemId) {
        throw new Error('systemId é obrigatório para a busca de logs.');
      }
  
      const systemObjectId = new mongoose.Types.ObjectId(systemId);
  
      const logs = await Log.find({ systemId: systemObjectId });
      return logs;
    } catch (error) {
      console.error('Erro ao buscar logs:', error.message || error);
      throw new Error('Erro ao buscar logs no banco de dados: ' + error.message);
    }
  }
}

module.exports = new LogRepository();
