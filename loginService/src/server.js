const express = require('express');
const app = express();
const userRouter = require('./routes/user.route');

const { serverPort: port } = require('./config/env');

// Middleware para aceitar JSON
app.use(express.json());

app.use('/users', userRouter);

app.get('/', (req, res) => {
    res.send('Servidor Express está rodando!');
});

// Inicia o servidor
app.listen(port, () => {
    console.log(`Servidor rodando na porta ${port}`);
});
