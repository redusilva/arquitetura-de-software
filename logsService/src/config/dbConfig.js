const mongoose = require('mongoose');

async function connectDB() {
  const mongoUrl = process.env.MONGO_URL || 'mongodb://localhost:27017/logs';

  try {
    await mongoose.connect(mongoUrl, {
      useNewUrlParser: true,
      useUnifiedTopology: true,
    });
    console.log('✅ Conectado ao MongoDB com sucesso!');
  } catch (error) {
    console.error('❌ Erro ao conectar ao MongoDB:', error);
    process.exit(1); // encerra a aplicação se falhar
  }
}

module.exports = connectDB;
