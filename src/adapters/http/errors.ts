import { SystemError } from '../../lib/errors';

type HTTPMeta = {
  message?: string;
  method: 'GET' | 'POST' | 'PUT' | 'DELETE';
  requestBody?: any;
  requestUrl: string;
  responseCode: number;
  response: any;
};

export class HTTPFetchError extends SystemError {
  requestBody: HTTPMeta['requestBody'];

  requestUrl: HTTPMeta['requestUrl'];

  responseCode: HTTPMeta['responseCode'];

  response: HTTPMeta['response'];

  constructor(meta: HTTPMeta) {
    const severity = meta.responseCode >= 500 ? 'error' : 'warning';
    const message = meta.message || `HTTP Error ${meta.method} ${meta.responseCode}: ${meta.requestUrl}`;
    super({
      message,
      severity,
      errorType: 'External service'
    });
    this.requestBody = meta.requestBody;
    this.requestUrl = meta.requestUrl;
    this.responseCode = meta.responseCode;
  }
}
