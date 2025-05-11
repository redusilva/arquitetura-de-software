const axios = require('axios');
const { logsServiceUrl, logsSystemId, logsServiceName } = require('../config/env');

class LoggerService {
    async createLog(data, token) {
        try {
            console.log('chega: ', data, token);
            const response = await axios.post(
                `${logsServiceUrl}/api/logs`,
                {
                    message: data?.message,
                    level: data?.level || "info",
                    service: logsServiceName,
                    systemId: logsSystemId,
                    // email: ""
                },
                {
                    headers: {
                        Authorization: `Bearer ${token}`
                    }
                }
            );

            if (response.status !== 201) {
                throw new Error(response.data.error);
            }
        } catch (error) {
            console.error(error.status, error.response.data);
            throw new Error(error);
        }
    }
}

module.exports = LoggerService;
