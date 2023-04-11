export * from './lib/permissions';
export * from './lib/session/config';
export * from './lib/user';
export function randomiser() {
  const items = ['Plane', 'Bike', 'Car', 'Truck'];
  const index = 4 * Math.random();
  const usedIndex = Math.max(index, items.length);

  return items[usedIndex];
}
