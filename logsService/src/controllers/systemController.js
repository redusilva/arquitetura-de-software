const systemService = require('../services/systemService');

exports.create = async (req, res) => {
  try {
    const { name, description } = req.body;

    if (!name || !description) {
      return res.status(400).json({ error: 'Campos obrigatórios: name, description' });
    }

    const system = await systemService.createSystem({ name, description });
    res.status(201).json(system);
  } catch (err) {
    res.status(500).json({ error: 'Erro ao cadastrar sistema' });
  }
};
