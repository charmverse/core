import { SchemaEncoder } from '@ethereum-attestation-service/eas-sdk';

export const githubContributionReceiptEASSchema =
  'bytes32 userRefUID,string description,string url,string metadataUrl,uint256 value,string type';

export const githubContributionReceiptSchemaName = 'Github Contribution Receipt';

export type GithubContributionReceiptAttestation = {
  userRefUID: string;
  description: string;
  url: string;
  metadataUrl: string;
  value: number;
  type: string;
};

const encoder = new SchemaEncoder(githubContributionReceiptEASSchema);

export function encodeGithubContributionReceiptAttestation(
  attestation: GithubContributionReceiptAttestation
): `0x${string}` {
  const encodedData = encoder.encodeData([
    { name: 'userRefUID', type: 'bytes32', value: attestation.userRefUID },
    { name: 'description', type: 'string', value: attestation.description },
    {
      name: 'url',
      type: 'string',
      value: attestation.url
    },
    {
      name: 'metadataUrl',
      type: 'string',
      value: attestation.metadataUrl
    },
    { name: 'value', type: 'uint256', value: attestation.value },
    { name: 'type', type: 'string', value: attestation.type }
  ]);

  return encodedData as `0x${string}`;
}

export function decodeGithubContributionReceiptAttestation(rawData: string): GithubContributionReceiptAttestation {
  const parsed = encoder.decodeData(rawData);
  const values = parsed.reduce((acc, item) => {
    const key = item.name as keyof GithubContributionReceiptAttestation;

    if (key === 'value') {
      acc[key] = parseInt(item.value.value as string);
    } else {
      acc[key] = item.value.value as string;
    }
    return acc;
  }, {} as GithubContributionReceiptAttestation);

  return values as GithubContributionReceiptAttestation;
}
