import * as dotenv from 'dotenv';
import { createServer, IncomingMessage, ServerResponse } from 'http';
import { RedisClient } from './redis';

dotenv.config();

const requestListener = async (req: IncomingMessage, res: ServerResponse) => {
  try {
    const redis = await RedisClient();
    let value = await redis.get('visits');

    if (!value) {
      await redis.set('visits', '0');
      console.log('Set value');
    }

    value = String(await redis.incr('visits'));

    res.writeHead(200);
    console.log('Request:', value);
    res.end(`Hello, World! Redis Value: ${value}`);
  } catch (err) {
    res.writeHead(500);
    res.end(err.message);
  }
};

const server = createServer(requestListener);

const PORT = process.env.PORT ?? 8080;

server.listen(PORT, () => {
  console.log('Listening on port', PORT);
});
