FROM node:18

# Criar diretório do app
WORKDIR /app

# Copiar os arquivos de configuração
COPY package*.json ./

# Instalar dependências
RUN npm install

# Copiar o restante do código
COPY . .

# Copiar e dar permissão ao entrypoint
COPY entrypoint.sh .
RUN chmod +x entrypoint.sh

# Expor a porta que o app vai rodar
EXPOSE 5000

# Comando de entrada
CMD ["./entrypoint.sh"]