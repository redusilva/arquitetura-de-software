const { emailServiceUrl, systemToken } = require('../config/env');
const axios = require('axios');

const sendEmail = async (message, subject, to) => {
    try {
        console.log("sendo email: ", message, subject, to);
        const response = await axios.post(`${emailServiceUrl}/send-email`,
            {
                message: message,
                subject: subject,
                to: to
            },
            {
                headers: {
                    Authorization: systemToken
                }
            }
        );

        console.log(response?.status, response?.data);

        if (response.status !== 200) {
            throw new Error(response.data.error);
        }
    } catch (error) {
        console.error(error.status, error.response.data);
        throw new Error(error);
    }
}

module.exports = { sendEmail };