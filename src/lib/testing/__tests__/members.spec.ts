import { generateInviteLink, generateRole } from '../members';
import { generateUserAndSpace } from '../user';

describe('generateInviteLink', () => {
  it('should generate an invite link with specified roles', async () => {
    const { user, space } = await generateUserAndSpace({});

    const role = await generateRole({ createdBy: user.id, spaceId: space.id });

    const inviteLink = await generateInviteLink({
      createdBy: user.id,
      spaceId: space.id,
      maxAgeMinutes: 90,
      maxUses: 100,
      publicContext: 'proposals',
      assignedRoleIds: [role.id]
    });

    expect(inviteLink).toMatchObject({
      createdBy: user.id,
      spaceId: space.id,
      maxAgeMinutes: 90,
      maxUses: 100,
      publicContext: 'proposals'
    });

    expect(inviteLink.inviteLinkToRoles.length).toBe(1);
    expect(inviteLink.inviteLinkToRoles[0].roleId).toBe(role.id);
  });
});
