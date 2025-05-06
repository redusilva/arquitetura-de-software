const logRepository = require('../repositories/logRepository');
const mongoose = require('mongoose');  // Importando mongoose para usar o ObjectId

class LogService {
  // Método para criar um novo log
  async createLog(userId, logData) {
    console.log('Dados recebidos para criar log:', logData);  // Verifique os dados recebidos

    try {
      // Verificando se o logData contém as informações necessárias
      if (!logData || !logData.systemId || !logData.message || !logData.service || !logData.level) {
        throw new Error('Dados de log incompletos');
      }

      // Associando o log ao usuário autenticado (userId)
      const log = {
        userId,
        systemId: logData.systemId,
        message: logData.message,
        service: logData.service,
        level: logData.level,
      };

      // Lógica para salvar o log no banco de dados
      const result = await logRepository.save(log);
      return {
        status: 201,
        data: result
      };
    } catch (error) {
      console.error('Erro ao criar o log:', error); // Logando erro para depuração
      return {
        status: 500,
        message: 'Erro interno ao salvar o log'
      };
    }
  }

  // Método para buscar logs por sistema
  async getLogsBySystem(systemId) {
    console.log('Buscando logs para systemId:', systemId);
  
    try {
      const objectId = new mongoose.Types.ObjectId(systemId);
  
      // Lógica para buscar logs por sistema
      const logs = await logRepository.findBySystem(objectId);
  
      // Verificando se logs foram encontrados
      if (logs && logs.length > 0) {
        console.log('Logs encontrados:', logs);
        return logs;
      } else {
        console.log('Nenhum log encontrado para o systemId:', systemId);
        return [];  // Retorna um array vazio se não houver logs
      }
    } catch (error) {
      console.error('Erro ao buscar logs:', error);  // Logando erro para depuração
      return {
        status: 500,
        message: 'Erro interno ao buscar logs'
      };
    }
  }
}

module.exports = new LogService();
