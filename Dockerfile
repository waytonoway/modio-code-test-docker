# Use an official PHP image with the required extensions
FROM php:8.1-fpm

# Install necessary dependencies, PHP extensions, and Git
RUN apt-get update && apt-get install -y \
    git \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    libmcrypt-dev \
    libicu-dev \
    libxml2-dev \
    zip \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd pdo pdo_mysql intl xml opcache

# Install Composer (PHP package manager)
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Set the working directory to /var/www
WORKDIR /var/www

# Clone the GitHub repository into the container
RUN git clone https://github.com/waytonoway/modio-code-test.git .

# Install Composer dependencies
RUN composer install --no-interaction --optimize-autoloader

# Copy the .env.example to .env
RUN cp .env.example .env

# Generate the Laravel application key
RUN php artisan key:generate

# Expose the port the app runs on
EXPOSE 8000

# Start the Laravel development server
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"]
