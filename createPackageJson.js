const fs = require('node:fs/promises');

const packageJson = {
  type: 'module'
};

async function createPackageJson() {
  try {
    await fs.readdir('./dist/esm');
  } catch (err) {
    await fs.mkdir('./dist/esm');
  } finally {
    await fs.writeFile('./dist/esm/package.json', JSON.stringify(packageJson, null, 2));
  }
}
// eslint-disable-next-line no-console
createPackageJson().then(() => console.log('package.json created'));
