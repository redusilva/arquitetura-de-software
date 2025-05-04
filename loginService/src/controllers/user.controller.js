class UserController {
    constructor(userService) {
        this.userService = userService;
    }

    async createUser(req, res) {
        const data = req.body;

        if (!data?.name || !data?.email || !data?.password) {
            return res.status(400).json({ error: 'Dados inválidos' });
        }

        const result = await this.userService.createUser(data);
        if (result?.status === 201) {
            return res.status(result?.status).json({
                message: "Usuário cadastrado com sucesso!",
                data: result?.message
            });
        }

        return res.status(result?.status).json({
            error: result?.message
        });
    }

    async loginUser(req, res) {
        const data = req.body;

        if (!data?.email || !data?.password) {
            return res.status(400).json({ error: 'Dados inválidos' });
        }

        const login = await this.userService.loginUser(data);
        if (login?.status === 200) {
            return res.status(login?.status).json({
                message: 'Login realizado com sucesso!',
                data: login?.message
            });
        }

        return res.status(login?.status).json({
            error: login?.message || 'Erro ao realizar login!'
        });
    }

    async validateUserToken(req, res) {
        const token = req?.body?.token;
        if (!token) {
            return res.status(400).json({ error: 'Token inválido!' });
        }

        const result = await this.userService.validateUserToken(token);
        if (result?.status === 200) {
            return res.status(200).json({ message: 'Token válido!' });
        }

        return res.status(result?.status).json({ error: result?.message });
    }
}

module.exports = UserController;