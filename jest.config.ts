import type { JestConfigWithTsJest } from 'ts-jest';

const jestConfig: JestConfigWithTsJest = {
  preset: 'ts-jest/presets/default-esm',
  runtime: 'jest-runtime',
  globals: {},
  transform: {
    '^.+\\.ts$': [
      'ts-jest',
      {
        babelConfig: {
          //                presets: ['@babel/preset-env'],
          caller: {
            //                  supportsTopLevelAwait: true,
            supportsStaticESM: true
          }
        },
        // tsconfig: true,
        useESM: true
      }
    ]
  },
  extensionsToTreatAsEsm: ['.ts'],
  testEnvironment: 'jest-environment-node',
  // An array of directory names to be searched recursively up from the requiring module's location
  moduleDirectories: ['node_modules', 'src'],
  testTimeout: 30000,
  testMatch: ['**/*.spec.ts']
};

export default jestConfig;
