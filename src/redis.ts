import * as redis from 'redis';

const REDIS_HOST = process.env.REDISHOST ?? 'redis://localhost';
const REDIS_PORT = process.env.REDISPORT ?? '6379';
const REDIS_URL = `redis://${REDIS_HOST}:${REDIS_PORT}`;

console.log('Creating Redis Client:', REDIS_URL);

let connected = false;
let connecting = false;
let connectionTries = 0;

const _client = redis.createClient({
  url: REDIS_URL,
});

export type RedisClientType = typeof _client;

_client.on('connect', () => {
  connecting = true;
  connectionTries += 1;
  console.log('Connecting To Redis', _client.options.url);
});

_client.on('error', (err) => {
  console.log('Redis Client Error:', err);
  if (connectionTries >= 10) {
    connecting = false;
    _client.quit();
  }
});

_client.on('ready', () => {
  connected = true;
  connecting = false;
  console.log('Connected To Redis', _client.options.url);
});

_client.on('reconnecting', () => {
  connectionTries += 1;
  connecting = true;
  console.log('Retrying Redis Connection', connectionTries);
});

export function RedisClient() {
  if (connected || connecting) {
    return _client;
  }

  _client.connect();

  return _client;
}
