#!/bin/bash

npm run migrate:status

# Run prisma migrations in prod mode
npm run migrate:prod 

exec "$@"