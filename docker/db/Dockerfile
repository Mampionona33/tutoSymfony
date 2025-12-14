FROM php:8.3-cli

# Installer les extensions nécessaires
RUN docker-php-ext-install pdo pdo_mysql

WORKDIR /var/www/html

# Installer Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer
