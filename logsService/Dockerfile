FROM node:18

WORKDIR /app
COPY . .

RUN npm install

# Expor a porta que o app vai rodar
EXPOSE 5000

# Comando de entrada
CMD ["npm", "start"]