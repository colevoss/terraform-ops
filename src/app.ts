import { PrismaClient } from '@prisma/client';
import { RedisClient, RedisClientType } from './redis';
import { Database } from './database';
import pino, { Logger } from 'pino';

export interface IApp {
  cache: RedisClientType;
  db: PrismaClient;
  logger: Logger;
}

export class App implements IApp {
  cache: RedisClientType;
  db: PrismaClient;
  logger: Logger;

  constructor() {
    this.cache = RedisClient();
    this.db = Database();
    this.logger = pino({
      messageKey: 'message',
    });
  }

  public async init() {
    return await this.cache;
  }
}
