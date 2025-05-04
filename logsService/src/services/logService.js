const Log = require('../models/log');

async function createLog({ systemId, message, level, source }) {
  const log = new Log({ systemId, message, level, source });
  return await log.save();
}

async function getLogsBySystem(systemId) {
  return await Log.find({ systemId });
}

module.exports = {
  createLog,
  getLogsBySystem
};
