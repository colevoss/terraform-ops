import * as dotenv from 'dotenv';
import * as express from 'express';
import { App } from './app';

const server = express();
server.use(express.json());

dotenv.config();

const PORT = process.env.PORT ?? 8080;

const app = new App();

server.get('/', async (req: express.Request, res: express.Response) => {
  try {
    const userCount = await app.cache.get('user-count');
    app.logger.info({ userCount }, 'User count fetched');

    const users = await app.db.user.findMany();
    app.logger.info({ users }, 'Users fetched');

    res.json({ users, userCount: Number(userCount || 0) });
  } catch (err) {
    app.logger.error(err, 'App Error');
    res.status(500).send(err.message);
  }
});

server.post('/users', async (req: express.Request, res: express.Response) => {
  const data = req.body as Record<string, string>;

  const name = data.name;

  if (!name) {
    res.status(400).send({ message: '`name` required' });
    return;
  }

  app.logger.debug({ name }, 'Creating User');

  const user = await app.db.user.create({
    data: {
      name: name.trim(),
    },
  });

  app.logger.info({ user }, 'Created user');

  app.logger.debug('Incrementing uesr count');
  const userCount = await app.cache.incr('user-count');
  app.logger.info({ userCount }, 'Incrementing uesr count');

  res.status(201).send({ user, userCount });
});

server.listen(PORT, () => {
  app.logger.info({ port: PORT }, 'App listening on port');
  console.log('Listening on port', PORT);
});
