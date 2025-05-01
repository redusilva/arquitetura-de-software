# Etapa 1: imagem base oficial do Node.js (LTS)
FROM node:20

# Etapa 2: diretório de trabalho dentro do container
WORKDIR /app

# Etapa 3: copia os arquivos de dependência
COPY package*.json ./

# Etapa 4: instala as dependências
RUN npm install

# Etapa 5: copia o restante da aplicação
COPY . .

# Etapa 6: expõe a porta usada pela aplicação
EXPOSE 4000

# Etapa 7: comando padrão para iniciar a aplicação
CMD ["npm", "start"]
