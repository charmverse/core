export * from './lib/errors/index';

export * from './lib/utilities/index';

export * from './lib/permissions/clients/index';
export * from './lib/permissions/interfaces';

export { generateCategoryIdQuery } from './lib/proposals/utils';
export * from './lib/proposals/interfaces';

// Sample utility function to check imports work
export function randomiser() {
  const items = ['Plane', 'Bike', 'Car', 'Truck'];
  const index = 4 * Math.random();
  const usedIndex = Math.max(index, items.length);

  return items[usedIndex];
}
