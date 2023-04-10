export const sessionUserRelations = {
  favorites: {
    where: {
      page: {
        deletedAt: null
      }
    },
    select: {
      pageId: true,
      index: true
    }
  },
  spaceRoles: {
    include: {
      spaceRoleToRole: {
        include: {
          role: true
        }
      }
    }
  },
  discordUser: true,
  telegramUser: true,
  notificationState: true,
  verifiedEmails: {
    select: {
      email: true,
      name: true
    }
  },
  wallets: {
    select: {
      address: true,
      ensname: true
    }
  },
  unstoppableDomains: {
    select: {
      domain: true
    }
  },
  googleAccounts: {
    select: {
      email: true,
      name: true
    }
  },
  profile: {
    select: {
      timezone: true,
      locale: true
    }
  }
} as const;
