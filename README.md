# Mod.io Laravel Code Test

This repository contains a Laravel application for the Mod.io coding test, wrapped in a Docker container. Follow the steps below to run the application and execute the feature tests.

## Prerequisites

Make sure Docker and Docker Compose are installed on your machine. You can follow the official documentation to install them:
- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)

## Setup Instructions

1. Clone the repositories:

   ```bash
   git clone https://github.com/waytonoway/modio-code-test-docker.git

2. Change into the ```modio-code-test-docker``` directory:

    ```bash
    cd modio-code-test-docker`

3. Create the Custom Network (if it doesn’t exist):

   ```bash
   docker network create laravel-network
   
3. Build and run Mysql container:

    ```bash
    docker run --name mysql -e MYSQL_ROOT_PASSWORD=your_mysql_password -e MYSQL_PASSWORD=your_mysql_password -e MYSQL_DATABASE=laravel -p 3306:3306 --network laravel-network -d mysql:8


4. Build the App Container:

   ```bash
   docker build --build-arg DB_PASSWORD=your_mysql_password -t laravel-app .

5. Run the App Container:

   ```bash
   docker run --name laravel-app --network laravel-network -e DB_HOST=mysql -e MYSQL_PASSWORD=your_mysql_password -p 8000:8000 -d laravel-app

7. Enter container

   ```bash
   docker exec -it laravel-app bash

6. Prepare env variables:
   ```bash
      sed -i 's/DB_HOST=127.0.0.1/DB_HOST=mysql/' .env
      sed -i 's/DB_PASSWORD=/DB_PASSWORD=your_mysql_password/' .env

7. Run Tests:
   ```bash
   php artisan test
