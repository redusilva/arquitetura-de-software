const systemService = require('../services/systemService');
const logService = require('../services/logService');

exports.create = async (req, res) => {
  try {
    const { name, description } = req.body;
    const userId = req.userId;

    if (!name || !description) {
      return res.status(400).json({ error: 'Campos obrigatórios: name, description' });
    }

    const existingSystem = await systemService.findSystemByName(name);
    if (existingSystem) {
      return res.status(400).json({ error: 'Já existe um sistema com esse nome.' });
    }

    const system = await systemService.createSystem({ name, description }, userId);

    const logMessage = `Sistema ${name} criado com sucesso.`;
    await logService.createLog(userId, {
      systemId: system._id,
      message: logMessage,
      source: 'aplicacao',
      level: 'info',
    });

    res.status(201).json(system);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Erro ao cadastrar sistema' });
  }
};
