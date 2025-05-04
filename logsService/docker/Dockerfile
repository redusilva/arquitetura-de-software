FROM node:14

# Criar diretório do app
WORKDIR /app

# Copiar os arquivos de configuração
COPY package*.json ./

# Instalar dependências
RUN npm install

# Copiar o restante do código
COPY . .

# Expor a porta que o app vai rodar
EXPOSE 5000

# Comando para rodar o servidor
CMD ["node", "src/app.js"]