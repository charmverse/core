import { SchemaEncoder } from '@ethereum-attestation-service/eas-sdk';
import type { EASSchema } from 'protocol';

const builderEventEASSchema = 'bytes32 userRefUID,string description,string type';

const builderEventSchemaName = 'Scout Game Builder Event';

export const builderEventSchemaDefinition: EASSchema = {
  schema: builderEventEASSchema,
  name: builderEventSchemaName
};

type BuilderEventType = 'registered' | 'banned' | 'unbanned';

export type builderEventAttestation = {
  userRefUID: `0x${string}`;
  description: string;
  type: BuilderEventType;
};

const encoder = new SchemaEncoder(builderEventEASSchema);

export function encodeBuilderEventAttestation(attestation: builderEventAttestation): `0x${string}` {
  const encodedData = encoder.encodeData([
    { name: 'userRefUID', type: 'bytes32', value: attestation.userRefUID },
    { name: 'description', type: 'string', value: attestation.description },
    { name: 'type', type: 'string', value: attestation.type }
  ]);

  return encodedData as `0x${string}`;
}

export function decodebuilderEventAttestation(rawData: string): builderEventAttestation {
  const parsed = encoder.decodeData(rawData);
  const values = parsed.reduce((acc, item) => {
    const key = item.name as keyof builderEventAttestation;

    if (key === 'userRefUID') {
      acc[key] = item.value.value as `0x${string}`;
    } else if (key === 'type') {
      acc[key] = item.value.value as BuilderEventType;
    } else {
      acc[key] = item.value.value as string;
    }
    return acc;
  }, {} as builderEventAttestation);

  return values as builderEventAttestation;
}
