
# =====================================
# Build Step
# =====================================
FROM node:16 as build

ARG NODE_ENV=production
ENV CI=true
ENV NODE_ENV=${NODE_ENV}

# Install latest npm version
RUN npm i -g npm@latest

WORKDIR /app

# Install dependencies
COPY package*.json ./
COPY ./scripts ./scripts

RUN npm ci --production=false

# Build Typescript App
COPY . .
RUN npm run prisma:generate
RUN npm run build

# =====================================
# Run Step
# =====================================
FROM node:16-slim

WORKDIR /app

# Needed for prisma
RUN apt-get update \
  && apt-get install --no-install-recommends -y openssl \
  && rm -rf /var/lib/apt/lists/*

# Intstall prod dependencies
COPY --from=build /app/package*.json ./
COPY ./scripts/prepare.js ./scripts/prepare.js

ENV CI=true

RUN npm ci --production

COPY --from=build /app/build ./build
COPY --from=build /app/prisma ./prisma
COPY --from=build /app/docker-entrypoint.sh ./

ARG NODE_ENV
ENV NODE_ENV=${NODE_ENV}

# Use non-priv `node` user
# @see https://github.com/nodejs/docker-node/blob/main/docs/BestPractices.md#non-root-user
USER node

EXPOSE 8080

ENTRYPOINT [ "/app/docker-entrypoint.sh" ]
CMD [ "node", "./build/index.js" ]