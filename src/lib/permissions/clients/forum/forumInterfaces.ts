import type {PostOperation} from '@prisma/client';
import { PermissionCompute, UserPermissionFlags } from "../../interfaces";


export type PostPermissionFlags = UserPermissionFlags<PostOperation>;
export type PostCategoryPermissionFlags = UserPermissionFlags<PostOperation>;


export type ForumPermissionsClient = {
    conputePostPermissions: (request: PermissionCompute) => Promise<PostPermissionFlags>;
    conputePostCategoryPermissions: (request: PermissionCompute) => Promise<PostCategoryPermissionFlags>;
}