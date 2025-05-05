const logService = require('../services/logService');
const mongoose = require('mongoose');

class LogController {
  async create(req, res) {
    try {
      const userId = req.userId;
      console.log('Usuário autenticado:', userId);

      const logData = req.body;
      console.log('Dados do log:', logData);

      const result = await logService.createLog(userId, logData);

      if (result?.status === 201) {
        return res.status(201).json({
          message: 'Log criado com sucesso!',
          data: result.data
        });
      }

      return res.status(result?.status || 500).json({
        error: result?.message || 'Erro ao criar log!'
      });
    } catch (error) {
      console.error('Erro no controller ao criar log:', error);
      return res.status(500).json({ error: 'Erro interno no servidor.' });
    }
  }

  async getBySystem(req, res) {
    try {
      const { systemId } = req.params;
      const userId = req.user?.id || req.userId;

      console.log('Buscando logs para o systemId:', systemId);

      // Converte systemId para ObjectId
      const objectId = new mongoose.Types.ObjectId(systemId);

      const logs = await logService.getLogsBySystem(objectId, userId);

      if (logs?.length > 0) {
        return res.status(200).json({
          message: 'Logs encontrados!',
          data: logs
        });
      }

      return res.status(404).json({
        error: 'Nenhum log encontrado para o sistema solicitado.'
      });
    } catch (error) {
      console.error('Erro no controller ao buscar logs:', error);
      return res.status(500).json({ error: 'Erro interno no servidor.' });
    }
  }
}

module.exports = LogController;
