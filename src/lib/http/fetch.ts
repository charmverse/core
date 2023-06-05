import type { RequestInitWithRetry } from 'fetch-retry';
import fetchRetry from 'fetch-retry';
import { fetch as nativeFetch } from 'undici';

const delayMultiplier = process.env.NODE_ENV === 'test' ? 1 : 1000;

const fetchAndRetry = fetchRetry(nativeFetch as any, {
  retries: 5,
  retryOn: [500, 501, 502, 503],
  retryDelay(attempt: number) {
    return 2 ** attempt * delayMultiplier; // 1000, 2000, 4000
  }
});

export function transformResponse(response: Response) {
  if (response.status >= 400) {
    const contentType = response.headers.get('content-type') as string;
    // necessary to capture the regular response for embedded blocks
    if (contentType?.includes('application/json')) {
      return response.json().then((json: any) => Promise.reject({ status: response.status, ...json }));
    }
    // Note: 401 if user is logged out
    return response.text().then((text) => Promise.reject({ status: response.status, message: text }));
  }
  const contentType = response.headers.get('content-type');

  if (contentType?.includes('application/json')) {
    return response.json();
  }
  return response.text().then((_response) => {
    // since we expect JSON, dont return the true value for 200 response
    return _response === 'OK' ? null : _response;
  });
}

export default function fetchWrapper<T>(url: RequestInfo, init?: RequestInitWithRetry): Promise<T> {
  return fetchAndRetry(url, init)
    .then((r) => transformResponse(r as unknown as Response)) //  as Promise<T>
    .catch((e) => {
      //  console.error('fetch error', e);
      throw e;
    });
}
