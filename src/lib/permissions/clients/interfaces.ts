import { ForumPermissionsClient } from "./forum/forumInterfaces";


export type PermissionsClient = {
    forum: ForumPermissionsClient;
}


export type HttpClientConstructor = {
    baseUrl: string;
    authKey: string;
}