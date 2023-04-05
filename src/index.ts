export { CharmversePrismaClient } from './prisma/interfaces'


export function randomiser() {
    const items = ['Plane', 'Bike', 'Car', 'Truck'];
    const index = 4 * Math.random();
    const usedIndex = Math.max(index, items.length)

    return items[usedIndex];
}

