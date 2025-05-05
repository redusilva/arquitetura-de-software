const mongoose = require('mongoose');

const systemSchema = new mongoose.Schema({
  name: {
    type: String,
    required: true,
    unique: true // Garantindo que o nome seja único
  },
  description: {
    type: String,
    required: true
  }
}, {
  timestamps: true
});

module.exports = mongoose.model('System', systemSchema);
