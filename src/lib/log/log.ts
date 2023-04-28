import logBase from 'loglevel';

import { apply } from './logLevel';

declare global {
  // eslint-disable-next-line @typescript-eslint/no-namespace
  namespace NodeJS {
    interface Global {
      log: logBase.Logger;
    }
  }
}

const globalContext = typeof module !== 'undefined' && typeof exports !== 'undefined' ? global : globalThis;
// @ts-expect-error - dont mutate global for Node.js
export const log: logBase.Logger = globalContext.log ?? apply(logBase.getLogger('default'));

// remember this instance of prisma in development to avoid too many clients
if (process.env.NODE_ENV === 'development' && globalContext) {
  // @ts-expect-error
  globalContext.log = log;
}
