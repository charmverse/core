// https://github.com/TypeStrong/ts-node/discussions/1450#discussioncomment-1806115

// "serve": "cross-env TS_NODE_PROJECT=\"tsconfig.build.json\" node --experimental-specifier-resolution=node --loader ./loader.js src/index.ts",
// TS_NODE_PROJECT=\"tsconfig.build.json\" node --experimental-specifier-resolution=node --loader ./loader.js src/index.ts"

import { pathToFileURL } from 'url';

import { resolve as resolveTs } from 'ts-node/esm';
import * as tsConfigPaths from 'tsconfig-paths';

const { absoluteBaseUrl, paths } = tsConfigPaths.loadConfig();
const matchPath = tsConfigPaths.createMatchPath(absoluteBaseUrl, paths);

export function resolve(specifier, ctx, defaultResolve) {
  const match = matchPath(specifier);
  return match
    ? resolveTs(pathToFileURL(`${match}`).href, ctx, defaultResolve)
    : resolveTs(specifier, ctx, defaultResolve);
}

export { load, getFormat, transformSource } from 'ts-node/esm';
