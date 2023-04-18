import type { PostPermissionFlags } from '../interfaces';

import type { PostPolicyInput } from './interfaces';

export async function policyDraftPost({ resource, flags, userId }: PostPolicyInput): Promise<PostPermissionFlags> {
  const newPermissions = {
    edit_post: userId && resource.isDraft ? resource.createdBy === userId : flags.edit_post,
    pin_post: userId && resource.isDraft ? false : flags.pin_post,
    lock_post: userId && resource.isDraft ? false : flags.lock_post,
    delete_comments: resource.isDraft ? false : flags.delete_comments,
    add_comment: resource.isDraft ? false : flags.add_comment,
    upvote: resource.isDraft ? false : flags.upvote,
    downvote: resource.isDraft ? false : flags.downvote,
    delete_post: userId && resource.isDraft ? resource.createdBy === userId : flags.delete_post,
    view_post: userId && resource.isDraft ? resource.createdBy === userId : flags.view_post
  };

  return newPermissions;
}
