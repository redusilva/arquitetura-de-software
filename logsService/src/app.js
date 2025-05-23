require('dotenv').config();
const cors = require('cors');
const connectDB = require('./config/dbConfig');
const createServer = require('./config/serverConfig');
const setupSwagger = require('./config/swaggerConfig');

const logRoutes = require('./routes/logRoutes');
const systemRoutes = require('./routes/systemRoutes');

const authenticateToken = require('./middlewares/authMiddleware');

const app = createServer();

app.use(cors());

// Conecta ao banco de dados
connectDB();

// Aplica rotas
app.use('/api/logs',
   authenticateToken,
   logRoutes);
app.use('/api/systems',
   authenticateToken,
   systemRoutes);

// Configuração do Swagger
setupSwagger(app);


// Inicia o servidor
const PORT = process.env.PORT || 4001;
app.listen(PORT, () => {
   console.log(`🚀 Servidor de logs rodando na porta ${PORT}`);
});
