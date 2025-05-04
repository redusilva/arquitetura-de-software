require('dotenv').config();
const connectDB = require('./config/dbConfig');
const createServer = require('./config/serverConfig');

const logRoutes = require('./routes/logRoutes');
const systemRoutes = require('./routes/systemRoutes');

const authenticateToken = require('./middlewares/authMiddleware');

const app = createServer();

// Conecta ao banco de dados
connectDB();

// Aplica rotas
app.use('/api/logs', 
   authenticateToken,
   logRoutes);
app.use('/api/systems', 
   authenticateToken,
   systemRoutes);

// Inicia o servidor
const PORT = process.env.PORT || 4001;
app.listen(PORT, () => {
  console.log(`🚀 Servidor de logs rodando na porta ${PORT}`);
});
