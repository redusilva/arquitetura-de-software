const express = require('express');
const cors = require('cors'); // Importando o pacote CORS
const swaggerUi = require('swagger-ui-express'); // Importando o Swagger UI
const path = require('path'); // Para lidar com caminhos de arquivos

const studentRouter = require('./routes/students.routes');
const teacherRouter = require('./routes/teacher.routes');
const disciplineRouter = require('./routes/discipline.routes');
const notesRouter = require('./routes/notes.routes');

const { serverPort: port } = require('./config/env');
const authMiddleware = require('./middlewares/auth');

const app = express();

app.use(cors());
app.use(express.json());

const swaggerDocument = require(path.join(__dirname, 'swagger.json'));
app.use('/api-docs', swaggerUi.serve, swaggerUi.setup(swaggerDocument));

app.get('/', (req, res) => {
    res.send('Servidor Express está rodando!');
});

// Rotas protegidas
const protectedRoutes = express.Router();
protectedRoutes.use(authMiddleware);
protectedRoutes.use('/alunos', studentRouter);
protectedRoutes.use('/professores', teacherRouter);
protectedRoutes.use('/disciplinas', disciplineRouter);
protectedRoutes.use('/notas', notesRouter);

app.use(protectedRoutes);

app.listen(port, () => {
    console.log(`Servidor rodando na porta ${port}`);
});
