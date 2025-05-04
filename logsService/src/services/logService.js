const logRepository = require('../repositories/logRepository');

class LogService {
  // Método para criar um novo log
  async createLog(userId, logData) {
    console.log('Dados recebidos para criar log:', logData);  // Verifique os dados recebidos


    try {
      // Verificando se o logData contém as informações necessárias
      if (!logData || !logData.systemId || !logData.message || !logData.source) {
        throw new Error('Dados de log incompletos');
      }

      // Associando o log ao usuário autenticado (userId)
      const log = {
        userId,
        systemId: logData.systemId,
        message: logData.message,
        source: logData.source,
        timestamp: new Date()
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

  // Método para buscar logs por sistema e usuário
  async getLogsBySystem(systemId, userId) {
    try {
      // Lógica para buscar logs por sistema, podendo filtrar por usuário
      const logs = await logRepository.findBySystemAndUser(systemId, userId);
      return logs;
    } catch (error) {
      console.error('Erro ao buscar logs:', error); // Logando erro para depuração
      return {
        status: 500,
        message: 'Erro interno ao buscar logs'
      };
    }
  }
}

module.exports = LogService;
