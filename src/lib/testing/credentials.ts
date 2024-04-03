import { v4 as uuid } from 'uuid';

import type { CredentialEventType, CredentialTemplate, IssuedCredential } from '../../prisma-client';
import { prisma } from '../../prisma-client';

type GenerateCredentialTemplateInput = Pick<CredentialTemplate, 'spaceId'> &
  Partial<
    Pick<
      CredentialTemplate,
      'name' | 'description' | 'organization' | 'schemaAddress' | 'schemaType' | 'credentialEvents'
    >
  >;

export async function generateCredentialTemplate({
  spaceId,
  description,
  name,
  organization,
  schemaAddress,
  schemaType,
  credentialEvents
}: GenerateCredentialTemplateInput): Promise<CredentialTemplate> {
  return prisma.credentialTemplate.create({
    data: {
      name: name || 'Test Credential Template',
      organization: organization || 'Test Organization',
      schemaAddress: schemaAddress || '0x20770d8c0a19668aa843240ddf6d57025334b346171c28dfed1a7ddb16928b89',
      schemaType: schemaType || 'proposal',
      description: description || 'Test Description',
      space: { connect: { id: spaceId } },
      credentialEvents
    }
  });
}

type GenerateIssuedCredentialInput = {
  userId: string;
  proposalId?: string;
  rewardApplicationId?: string;
  credentialTemplateId: string;
  ceramicId?: string;
  credentialEvent: CredentialEventType;
};

export async function generateIssuedCredential({
  userId,
  proposalId,
  rewardApplicationId,
  ceramicId,
  credentialEvent,
  credentialTemplateId
}: GenerateIssuedCredentialInput): Promise<IssuedCredential> {
  const proposal = await prisma.proposal.findUniqueOrThrow({
    where: {
      id: proposalId
    },
    select: {
      id: true,
      spaceId: true
    }
  });
  return prisma.issuedCredential.create({
    data: {
      credentialEvent,
      ceramicId: ceramicId || uuid(),
      credentialTemplate: { connect: { id: credentialTemplateId } },
      proposal: proposalId ? { connect: { id: proposal.id } } : undefined,
      rewardApplication: rewardApplicationId ? { connect: { id: rewardApplicationId } } : undefined,
      user: { connect: { id: userId } }
    }
  });
}
