# Use a imagem oficial do NGINX (leve, baseada em Alpine)
FROM nginx:alpine

# Remove a configuração default do nginx (opcional)
RUN rm /etc/nginx/conf.d/default.conf

# Copia sua configuração customizada de nginx
COPY nginx.conf /etc/nginx/conf.d/

# Copia todo o build estático do Flutter Web
COPY web/ /usr/share/nginx/html/

# Expõe a porta 80 no container
EXPOSE 80

# Comando padrão
CMD ["nginx", "-g", "daemon off;"]
