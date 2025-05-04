const Log = require('../models/log'); // O modelo de Log que você já tem

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
  async findBySystemAndUser(systemId, userId) {
    try {
      if (!systemId || !userId) {
        throw new Error('systemId e userId são obrigatórios para a busca de logs.');
      }

      const logs = await Log.find({ systemId, userId });
      return logs;
    } catch (error) {
      console.error('Erro ao buscar logs:', error.message || error);
      throw new Error('Erro ao buscar logs no banco de dados: ' + error.message);
    }
  }

  // Outros métodos de busca ou atualização de logs podem ser adicionados aqui, se necessário.
}

module.exports = new LogRepository(); // Exporta uma instância única do repositório
