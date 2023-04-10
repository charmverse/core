import { PermissionCompute } from "lib/permissions/interfaces";
import { HttpClientConstructor } from "../interfaces";
import { ForumPermissionsClient, PostCategoryPermissionFlags, PostPermissionFlags } from "./forumInterfaces";
import fetch from '../../../../adapters/http/fetch.server';

export class ForumPermissionsHttpClient implements ForumPermissionsClient {

    
    private baseUrl: string;
    private authKey: string;


    constructor({baseUrl, authKey}: HttpClientConstructor) {
        this.baseUrl = baseUrl;
        this.authKey = authKey;
    }

    computePostPermissions (request: PermissionCompute): Promise<PostPermissionFlags> {
        return fetch(`${this.baseUrl}/permissions/forum/conpute-post-permissions`, {
            method: 'POST',
            body: JSON.stringify(request),
            headers: {
                'Authorization': `Bearer ${this.authKey}`,
            }
        })
    } ;
    computePostCategoryPermissions (request: PermissionCompute): Promise<PostCategoryPermissionFlags> {
        return fetch(`${this.baseUrl}/permissions/forum/conpute-post-category-permissions`, {
            method: 'POST',
            body: JSON.stringify(request),
            headers: {
                'Authorization': `Bearer ${this.authKey}`,
            }
        })
    };
    
}