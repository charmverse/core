import { log } from './lib/log/log';

function main() {
  log.info('test');
  log.error('test', { error: new Error('test error') });
  log.warn('test', new Error('test error inline'));
  log.debug('test', ['test', 'test2']);
  log.trace('test', 'another string');
  setTimeout(() => {
    process.exit(0);
  }, 1000);
}

main();
