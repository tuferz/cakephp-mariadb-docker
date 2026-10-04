# Imagen base oficial multi-arquitectura (Soporta nativo ARM64 de Mac M4 y AMD64 de Windows)
FROM php:8.3-apache

# Actualizar repositorios e instalar librerías C necesarias para compilar extensiones PHP
RUN apt-get update && apt-get install -y \
    libicu-dev \
    libonig-dev \
    unzip \
    git \
    && docker-php-ext-install intl pdo_mysql mbstring \
    && a2enmod rewrite

# Copiar el binario oficial de Composer desde su imagen oficial
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Configurar Apache para que su DocumentRoot apunte al subdirectorio webroot de CakePHP
ENV APACHE_DOCUMENT_ROOT=/var/www/html/webroot
RUN mkdir -p ${APACHE_DOCUMENT_ROOT}
RUN sed -ri -e 's!/var/www/html!/var/www/html/webroot!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!AllowOverride None!AllowOverride All!g' /etc/apache2/apache2.conf
RUN sed -ri -e 's!/var/www/!/var/www/html/webroot/!g' /etc/apache2/apache2.conf

# Establecer el directorio de trabajo predeterminado
WORKDIR /var/www/html
