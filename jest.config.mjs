// eslint-disable-next-line import/no-extraneous-dependencies
import { createJsWithTsEsmPreset } from 'ts-jest';

/** @type {import('ts-jest').JestConfigWithTsJest} */
export default {
  ...createJsWithTsEsmPreset({
    tsconfig: 'tsconfig.esm.json'
  }),
  testMatch: ['**/*.spec.ts'],
  moduleNameMapper: {
    '^prisma$': '<rootDir>/src/prisma.ts',
    '^prisma-client$': '<rootDir>/src/prisma-client.ts'
  },
  moduleDirectories: ['node_modules', 'src']
};
