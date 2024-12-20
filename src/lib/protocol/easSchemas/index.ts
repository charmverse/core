import { contributionSchemaDefinition } from './contributionReceiptSchema';
import { scoutGameUserProfileSchemaDefinition } from './scoutGameUserProfileSchema';
import type { EASSchema } from './types';

export * from './constants';
export * from './contributionReceiptSchema';
export * from './scoutGameUserProfileSchema';
export * from './types';

export const allSchemas: EASSchema[] = [contributionSchemaDefinition, scoutGameUserProfileSchemaDefinition];
