# Usar Debian como imagen base
FROM debian:latest

# Instalar Apache
RUN apt-get update && apt-get install -y apache2

# Instalar curl
RUN apt-get install -y curl

# Instalar Node.js y npm
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
    apt-get install -y nodejs

# Instalar npm manualmente
RUN apt-get install -y npm

# Verificar la instalación de Node.js y npm
RUN node -v && npm -v

# Instalar Angular CLI globalmente
RUN npm install -g @angular/cli

# Establecer el directorio de trabajo
WORKDIR /usr/src/app

# Copiar los archivos de la aplicación Angular
COPY . .

# Instalar las dependencias de la aplicación Angular
RUN npm install

# Construir la aplicación Angular
RUN ng build --configuration production

# Copiar la aplicación Angular construida al directorio web de Apache
RUN cp -r dist/* /var/www/html/

# Exponer el puerto 80
EXPOSE 80

# Iniciar el servidor Apache
CMD ["apachectl", "-D", "FOREGROUND"]