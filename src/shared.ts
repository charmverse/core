export * from './lib/errors';

export * from './lib/utilities';

export { log } from './lib/log';
export * from './lib/permissions/clients';
export * from './lib/permissions/interfaces';

// Sample utility function to check imports work
export function randomiser() {
  const items = ['Plane', 'Bike', 'Car', 'Truck'];
  const index = 4 * Math.random();
  const usedIndex = Math.max(index, items.length);

  return items[usedIndex];
}
