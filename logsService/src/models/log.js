const mongoose = require('mongoose');

const logSchema = new mongoose.Schema({
  message: { type: String, required: true },
  level: { type: String, enum: ['info', 'warn', 'error'], default: 'info' },
  timestamp: { type: Date, default: Date.now },
  systemId: { type: mongoose.Schema.Types.ObjectId, ref: 'System' },
  source: { type: String, enum: ['aplicacao', 'auth', 'emails'], required: true }
});

module.exports = mongoose.model('Log', logSchema);
