

export function randomiser() {
    const random = Math.random();

    return random <= 0.3 ? 'Car' : random <= 0.6 ? 'Bike' : 'Plane';
}

console.log('Greeter')