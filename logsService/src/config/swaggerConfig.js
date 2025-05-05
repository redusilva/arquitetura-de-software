const swaggerJsdoc = require('swagger-jsdoc');
const swaggerUi = require('swagger-ui-express');

const options = {
  definition: {
    openapi: '3.0.0', // Versão do OpenAPI
    info: {
      title: 'API de Logs', // Título da sua API
      version: '1.0.0',
      description: 'Documentação da API do microsserviço de Logs',
    },
  },
  apis: ['./src/routes/*.js'], // Caminho para os arquivos das rotas
};

const swaggerSpec = swaggerJsdoc(options);

const setupSwagger = (app) => {
  app.use('/api-docs', swaggerUi.serve, swaggerUi.setup(swaggerSpec));
};

module.exports = setupSwagger;
