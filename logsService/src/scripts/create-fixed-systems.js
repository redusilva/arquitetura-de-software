const mongoose = require('mongoose');
const ObjectId = require('mongoose').Types.ObjectId;
const System = require('../models/system');

// Definindo os sistemas com IDs fixos e nome/descrição
const systems = [
  { 
    _id: new ObjectId("60b8f37e3d024e3b2c5f6a6b"), // ID fixo para o sistema "Aplicação"
    name: 'Aplicação', 
    description: 'Serviço principal de aplicação' 
  },
  { 
    _id: new ObjectId("60b8f37e3d024e3b2c5f6a6c"), // ID fixo para o sistema "Email"
    name: 'Email', 
    description: 'Microsserviço de envio de e-mails' 
  },
  { 
    _id: new ObjectId("60b8f37e3d024e3b2c5f6a6d"), // ID fixo para o sistema "Autenticação"
    name: 'Autenticação', 
    description: 'Microsserviço de autenticação de usuários' 
  }
];

async function seed() {
  try {
    await mongoose.connect('mongodb://mongodb:27017/logs');
    for (const data of systems) {
      const exists = await System.findOne({ _id: data._id }); // Verifica se já existe pelo ID fixo
      if (!exists) {
        await System.create(data);
        console.log(`✅ Sistema '${data.name}' criado com ID fixo.`);
      } else {
        console.log(`⚠️ Sistema '${data.name}' já existe.`);
      }
    }
    mongoose.disconnect();
  } catch (error) {
    console.error('Erro ao rodar o seed:', error);
    mongoose.disconnect();
  }
}

seed();
