import fs from 'node:fs/promises';

const packageJson = {
  type: 'module'
};

fs.writeFile('./dist/esm/package.json', JSON.stringify(packageJson, null, 2)).then(() =>
  // eslint-disable-next-line no-console
  console.log('package.json created')
);
