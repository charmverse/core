import type {
  User,
  SpaceRole,
  UserWallet,
  UnstoppableDomain,
  GoogleAccount,
  VerifiedEmail,
  DiscordUser,
  TelegramUser,
  UserNotificationState,
  SpaceRoleToRole,
  Role
} from '@prisma/client';

interface NestedMemberships {
  spaceRoleToRole: (SpaceRoleToRole & { role: Role })[];
}

export interface LoggedInUser extends User {
  favorites: { pageId: string; index?: number }[];
  spaceRoles: (SpaceRole & NestedMemberships)[];
  wallets: Pick<UserWallet, 'address' | 'ensname'>[];
  unstoppableDomains: Pick<UnstoppableDomain, 'domain'>[];
  googleAccounts: Pick<GoogleAccount, 'email' | 'name'>[];
  verifiedEmails: Pick<VerifiedEmail, 'email' | 'name'>[];
  ensName?: string;
  discordUser?: DiscordUser | null;
  telegramUser?: TelegramUser | null;
  notificationState?: UserNotificationState | null;
  isNew?: boolean;
  profile?: {
    timezone?: string | null;
    locale?: string | null;
  } | null;
}
