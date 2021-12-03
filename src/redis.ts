import * as redis from 'redis';

const REDIS_HOST = process.env.REDISHOST ?? 'redis://localhost';
const REDIS_PORT = process.env.REDISPORT ?? '6379';
const REDIS_URL = `redis://${REDIS_HOST}:${REDIS_PORT}`;

console.log('Creating Redis Client:', REDIS_URL);

let connected = false;
let connectionTries = 0;

const _client = redis.createClient({
  url: REDIS_URL,
});

_client.on('connect', () => {
  connectionTries += 1;
  console.log('Connecting To Redis', _client.options.url);
});

_client.on('error', (err) => {
  console.log('Redis Client Error:', err);
  if (connectionTries >= 10) {
    _client.quit();
  }
});

_client.on('ready', () => {
  connected = true;
  console.log('Connected To Redis', _client.options.url);
});

_client.on('reconnecting', () => {
  connectionTries += 1;
  console.log('Retrying Redis Connection', connectionTries);
});

export async function RedisClient() {
  if (connected) {
    return _client;
  }

  await _client.connect();

  return _client;
}
