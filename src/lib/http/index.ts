import fetch from './fetch';

type Params = { [key: string]: any };

type HttpConfig = { credentials?: RequestCredentials; headers?: any; addBracketsToArrayValues?: boolean };

const httpConfigParams = ['credentials', 'headers', 'addBracketsToArrayValues'];

export function GET<T = Response>(
  _requestUrl: string,
  data: Params | null | undefined | HttpConfig,
  config?: HttpConfig
): Promise<T> {
  const { credentials = 'include', headers = {}, addBracketsToArrayValues = true } = _getHttpConfig(data, config);
  const requestData = !config && _isConfigObject(data) ? null : data;

  const requestUrl = _appendQuery(_requestUrl, requestData || {}, addBracketsToArrayValues);

  return fetch<T>(requestUrl, {
    method: 'GET',
    headers: new Headers({
      Accept: 'application/json',
      ...headers
    }),
    credentials
  });
}

export function DELETE<T>(
  _requestUrl: string,
  data: Params = {},
  { headers = {} }: { headers?: any } = {}
): Promise<T> {
  const requestUrl = _appendQuery(_requestUrl, data || {});
  return fetch<T>(requestUrl, {
    // deprecated: sending DELETE params inside of body
    body: JSON.stringify(data),
    method: 'DELETE',
    headers: new Headers({
      Accept: 'application/json',
      'Content-Type': 'application/json',
      ...headers
    }),
    credentials: 'include'
  });
}

export function POST<T>(
  requestURL: string,
  data: Params | string = {},
  { headers = {}, noHeaders, skipStringifying }: { headers?: any; noHeaders?: boolean; skipStringifying?: boolean } = {}
): Promise<T> {
  return fetch<T>(requestURL, {
    body: !skipStringifying ? JSON.stringify(data) : (data as string),
    method: 'POST',
    headers: noHeaders
      ? undefined
      : new Headers({
          Accept: 'application/json',
          'Content-Type': 'application/json',
          ...headers
        }),
    credentials: 'include'
  });
}

export function PUT<T>(requestURL: string, data: Params = {}, { headers = {} }: { headers?: any } = {}): Promise<T> {
  return fetch<T>(requestURL, {
    body: JSON.stringify(data),
    method: 'PUT',
    headers: new Headers({
      Accept: 'application/json',
      'Content-Type': 'application/json',
      ...headers
    }),
    credentials: 'include'
  });
}

function _getHttpConfig(data: Params | null | undefined | string, config?: HttpConfig): HttpConfig {
  // allow passing config as second or 3rd argument
  const httpConfig = config || _isConfigObject(data) ? (data as HttpConfig) : {};

  return httpConfig;
}

function _appendQuery(path: string, data: Params, addBracketsToArrayValues: boolean = true) {
  const queryString = Object.keys(data)
    .filter((key) => !!data[key])
    .map((key) => {
      const value = data[key];
      return Array.isArray(value)
        ? `${value.map((v: string) => `${key}${addBracketsToArrayValues ? '[]' : ''}=${v}`).join('&')}`
        : `${key}=${encodeURIComponent(value)}`;
    })
    .join('&');
  return `${path}${queryString ? `?${queryString}` : ''}`;
}

function _isConfigObject(obj: Params | null | undefined | string | HttpConfig): obj is HttpConfig {
  if (!obj || typeof obj === 'string') {
    return false;
  }

  return Object.keys(obj).every((key) => httpConfigParams.includes(key));
}
