const LogService = require('../services/logService');
const logService = new LogService();

class LogController {
  async create(req, res) {
      // O usuário autenticado pode ser acessado através de req.user
      const userId = req.user.id;  // O ID do usuário autenticado
      console.log('Usuário autenticado:', userId);  // Verifique o valor

      const logData = req.body;
      console.log('Dados do log:', logData);  // Verifique os dados do log

      // Lógica para criar o log, associando ao usuário autenticado
      const result = await logService.createLog(userId, logData);

      if (result?.status === 201) {
          return res.status(201).json({
              message: 'Log criado com sucesso!',
              data: result?.data
          });
      }

      return res.status(result?.status).json({
          error: result?.message || 'Erro ao criar log!'
      });
  }

  async getBySystem(req, res) {
      const { systemId } = req.params;
      const userId = req.user.id;  // ID do usuário autenticado

      // Lógica para buscar logs do sistema, possivelmente filtrando por usuário também
      const logs = await logService.getLogsBySystem(systemId, userId);

      if (logs?.length > 0) {
          return res.status(200).json({
              message: 'Logs encontrados!',
              data: logs
          });
      }

      return res.status(404).json({
          error: 'Nenhum log encontrado para o sistema solicitado.'
      });
  }
}

module.exports = LogController;
