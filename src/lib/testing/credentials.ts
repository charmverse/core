import type { CredentialTemplate } from '../../prisma-client';
import { prisma } from '../../prisma-client';

type GenerateCredentialTemplateInput = Pick<CredentialTemplate, 'spaceId'> &
  Partial<Pick<CredentialTemplate, 'name' | 'description' | 'organization' | 'schemaAddress' | 'schemaType'>>;

export async function generateCredentialTemplate({
  spaceId,
  description,
  name,
  organization,
  schemaAddress,
  schemaType
}: GenerateCredentialTemplateInput): Promise<CredentialTemplate> {
  return prisma.credentialTemplate.create({
    data: {
      name: name || 'Test Credential Template',
      organization: organization || 'Test Organization',
      schemaAddress: schemaAddress || '0x20770d8c0a19668aa843240ddf6d57025334b346171c28dfed1a7ddb16928b89',
      schemaType: schemaType || 'proposal',
      description: description || 'Test Description',
      space: { connect: { id: spaceId } }
    }
  });
}
