const System = require('../models/system');

async function createSystem({ name, description }) {
  const system = new System({ name, description });
  return await system.save();
}

module.exports = {
  createSystem
};
