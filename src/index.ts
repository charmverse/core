export type { Prisma } from '@prisma/client'
export { PrismaClient } from '@prisma/client';


export function randomiser() {
    const random = Math.random();

    return random;
}

console.log('Greeter')