export * from './lib/errors/index';

export * from './lib/utilities/index';

export { log } from './lib/log/index';
export * from './lib/permissions/clients/index';
export * from './lib/permissions/interfaces';

// Sample utility function to check imports work
export function randomiser() {
  const items = ['Plane', 'Bike', 'Car', 'Truck'];
  const index = 4 * Math.random();
  const usedIndex = Math.max(index, items.length);

  return items[usedIndex];
}
