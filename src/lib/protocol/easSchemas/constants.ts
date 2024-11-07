import { getSchemaUID } from '@ethereum-attestation-service/eas-sdk';

export const NULL_EAS_REF_UID = '0x0000000000000000000000000000000000000000000000000000000000000000';

export const NULL_EVM_ADDRESS = '0x0000000000000000000000000000000000000000';

// Obtained from https://github.com/ethereum-attestation-service/eas-contracts/blob/558250dae4cb434859b1ac3b6d32833c6448be21/deploy/scripts/000004-name-initial-schemas.ts#L10C1-L11C1
export const NAME_SCHEMA_UID = getSchemaUID('bytes32 schemaId,string name', NULL_EVM_ADDRESS, true);
