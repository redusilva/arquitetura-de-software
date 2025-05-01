const express = require('express');
const cors = require('cors'); // Importando o pacote CORS
const swaggerUi = require('swagger-ui-express'); // Importando o Swagger UI
const path = require('path'); // Para lidar com caminhos de arquivos
const userRouter = require('./routes/user.route');

const { serverPort: port } = require('./config/env');

const app = express();

app.use(cors());
app.use(express.json());

const swaggerDocument = require(path.join(__dirname, 'swagger.json'));
app.use('/api-docs', swaggerUi.serve, swaggerUi.setup(swaggerDocument));
app.use('/users', userRouter);

app.get('/', (req, res) => {
    res.send('Servidor Express está rodando!');
});

app.listen(port, () => {
    console.log(`Servidor rodando na porta ${port}`);
});
