
export * from './lib/user'
export * from './lib/session/config';
export * from './lib/permissions';

export function randomiser() {
    const items = ['Plane', 'Bike', 'Car', 'Truck'];
    const index = 4 * Math.random();
    const usedIndex = Math.max(index, items.length)

    return items[usedIndex];
}
console.log('Hello world')
