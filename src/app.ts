import { PrismaClient } from '@prisma/client';
import { RedisClient, RedisClientType } from './redis';
import { Database } from './database';
import pino, { Logger } from 'pino';
import { PubSub } from '@google-cloud/pubsub';

export interface IApp {
  cache: RedisClientType;
  db: PrismaClient;
  logger: Logger;
  pubsub: PubSub;
}

export class App implements IApp {
  cache: RedisClientType;
  db: PrismaClient;
  logger: Logger;
  pubsub: PubSub;

  constructor() {
    this.cache = RedisClient();
    this.db = Database();
    this.logger = pino({
      messageKey: 'message',
    });
    this.pubsub = new PubSub();
  }

  public async init() {
    return await this.cache;
  }
}
