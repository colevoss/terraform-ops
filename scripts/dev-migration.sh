#!/bin/bash

# Script used to create migration files from updates to the prisma.schema file in
# development environments.

# To make sure that the back end app has a chance to reload/regenerate Prisma types,
# we stop the application so that we can do a fresh restart after migration generation
docker-compose stop app

# Use the app container without starting the application to run the development
# migration script.
docker-compose run app npm run migrate:dev

# Restart the app container, allowing it to run all of the prisma prep it needs
# before starting the server
docker-compose start app prisma
