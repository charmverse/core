export type { Prisma } from '@prisma/client'
export { PrismaClient } from '@prisma/client';


export function randomiser() {
    const items = ['Plane', 'Bike', 'Car', 'Truck'];
    const index = 4 * Math.random();
    const usedIndex = Math.max(index, items.length)

    return items[usedIndex];
}

