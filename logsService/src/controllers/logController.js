const logService = require('../services/logService');

exports.create = async (req, res) => {
  try {
    const { systemId, message, level, source } = req.body;

    if (!systemId || !message || !source) {
      return res.status(400).json({ error: 'Campos obrigatórios: systemId, message, source' });
    }

    const log = await logService.createLog({ systemId, message, level, source });
    res.status(201).json(log);
  } catch (err) {
    res.status(500).json({ error: 'Erro ao cadastrar log' });
  }
};

exports.getBySystem = async (req, res) => {
  try {
    const logs = await logService.getLogsBySystem(req.params.systemId);
    res.json(logs);
  } catch (err) {
    res.status(500).json({ error: 'Erro ao buscar logs' });
  }
};
