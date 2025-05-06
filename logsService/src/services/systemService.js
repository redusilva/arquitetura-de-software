const systemRepository = require('../repositories/systemRepository');
const logService = require('../services/logService'); // Importando o serviço de log

// Função para criar um sistema
async function createSystem({ name, description }, userId) {
  const systemData = { name, description };
  
  // Cria o sistema
  const system = await systemRepository.save(systemData);

  // Agora, criamos o log com o systemId
  const logMessage = `Sistema ${name} criado com sucesso.`;
  await logService.createLog(userId, {
    systemId: system._id,  // ID do sistema recém-criado
    message: logMessage,
    level: 'info',  // Definindo o nível do log (pode ser ajustado conforme necessário)
    service: 'aplicacao'
  });

  return system;
}

// Função para buscar um sistema pelo ID
async function getSystemById(systemId) {
  return await systemRepository.findById(systemId);
}

// Função para encontrar um sistema pelo nome
async function findSystemByName(name) {
  return await systemRepository.findOne({ name });
}

module.exports = {
  createSystem,
  getSystemById,
  findSystemByName
};
