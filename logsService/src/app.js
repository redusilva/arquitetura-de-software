require('dotenv').config();
const connectDB = require('./config/dbConfig');
const createServer = require('./config/serverConfig');

const logRoutes = require('./routes/logRoutes');
const systemRoutes = require('./routes/systemRoutes');

// const authMiddleware = require('./middlewares/auth');

const app = createServer();

// Conecta ao banco de dados
connectDB();

// Aplica rotas
app.use('/api/logs', 
  // authMiddleware,
   logRoutes);
app.use('/api/systems', 
 // authMiddleware,
   systemRoutes);

// Inicia o servidor
const PORT = process.env.PORT || 4001;
app.listen(PORT, () => {
  console.log(`🚀 Servidor de logs rodando na porta ${PORT}`);
});
