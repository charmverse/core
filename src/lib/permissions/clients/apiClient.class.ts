import type { PermissionsApiClientConstructor } from './interfaces';

export abstract class AbstractPermissionsApiClient {
  readonly baseUrl: string;

  readonly authKey: string;

  constructor({ baseUrl, authKey }: PermissionsApiClientConstructor) {
    this.baseUrl = baseUrl;
    this.authKey = authKey;
  }
}
