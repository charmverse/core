import { githubContributionSchemaDefinition } from './githubContributionReceiptSchema';
import { scoutGameUserProfileSchemaDefinition } from './scoutGameUserProfileSchema';
import type { EASSchema } from './types';

export * from './constants';
export * from './githubContributionReceiptSchema';
export * from './scoutGameUserProfileSchema';
export * from './types';

export const allSchemas: EASSchema[] = [githubContributionSchemaDefinition, scoutGameUserProfileSchemaDefinition];
