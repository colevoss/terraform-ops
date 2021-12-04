import { PrismaClient } from '@prisma/client';

let _db: PrismaClient;

export function Database() {
  if (_db) {
    return _db;
  }

  _db = new PrismaClient({
    log: ['query', 'error', 'info'],
  });

  return _db;
}
