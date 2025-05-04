// services/systemService.js
const systemRepository = require('../repositories/systemRepository');

async function createSystem({ name, description }) {
  const systemData = { name, description };
  return await systemRepository.save(systemData);
}

async function getSystemById(systemId) {
  return await systemRepository.findById(systemId);
}

module.exports = {
  createSystem,
  getSystemById
};
