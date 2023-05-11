export const brandColours = [
  'default',
  'gray',
  'turquoise',
  'orange',
  'yellow',
  'teal',
  'blue',
  'purple',
  'red',
  'pink'
];

export function randomThemeColour() {
  return brandColours[Math.floor(Math.random() * brandColours.length)];
}
