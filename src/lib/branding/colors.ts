export const brandColors = [
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

export function randomThemeColor() {
  return brandColors[Math.floor(Math.random() * brandColors.length)];
}
