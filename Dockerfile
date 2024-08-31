# Utilise l'image officielle PHP avec Apache
FROM php:8.2-apache

# Installer les dépendances
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libpq-dev \
    libicu-dev \
    libxml2-dev \
    libzip-dev \
    libonig-dev \
    zip \
    && docker-php-ext-install pdo pdo_pgsql intl xml zip

# Installer Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copier les fichiers de l'application
COPY . /var/www/html/

# Configurer les permissions
RUN chown -R www-data:www-data /var/www/html \
    && a2enmod rewrite

# Exposer le port 80 pour l'Apache
EXPOSE 80

# Commande pour démarrer Apache
CMD ["apache2-foreground"]
