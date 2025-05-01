const pool = require('../config/db');
const { generateToken, verifyToken } = require('../utils/auth');
const { hashPassword, comparePassword } = require('../utils/password');

class UserService {
    constructor(userRepository) {
        this.userRepository = userRepository;
    }

    async createUser(data) {
        const createdUser = await this.userRepository.findUserByEmail(data?.email, pool);
        if (createdUser) {
            return {
                status: 400,
                message: 'Usuário já cadastrado no sistema!'
            }
        }

        const formattedData = {
            name: data?.name,
            email: data?.email,
            password: await hashPassword(data?.password)
        }

        const result = await this.userRepository.createUser(formattedData, pool);
        const formattedResult = {
            id: result?.id,
            name: result?.nome,
            email: result?.email
        }
        return {
            status: 201,
            message: formattedResult
        };
    }

    async loginUser(data) {
        const createdUser = await this.userRepository.findUserByEmail(data?.email, pool);
        if (!createdUser) {
            return {
                status: 404,
                message: 'Usuário não cadastrado no sistema!'
            }
        }

        const isMatch = await comparePassword(data?.password, createdUser?.senha);
        if (!isMatch) {
            return {
                status: 401,
                message: 'Credenciais inválidas!'
            }
        }

        const token = generateToken({
            id: createdUser?.id,
            email: createdUser?.email,
            name: createdUser?.nome
        });

        return {
            status: 200,
            message: {
                id: createdUser?.id,
                name: createdUser?.nome,
                email: createdUser?.email,
                token
            }
        };
    }

    async validateUserToken(userId, token) {
        const createdUser = await this.userRepository.findUserById(userId, pool);
        if (!createdUser) {
            return {
                status: 404,
                message: 'Usuário não cadastrado no sistema!'
            }
        }

        const decoded = verifyToken(token);
        if (!decoded?.valid) {
            return {
                status: 401,
                message: 'Token inválido!'
            }
        }

        const payload = decoded?.payload;
        if (payload?.id !== userId) {
            return {
                status: 401,
                message: 'Usuário não autorizado!'
            }
        }

        return {
            status: 200,
            message: 'Token válido!'
        };
    }
}

module.exports = UserService;