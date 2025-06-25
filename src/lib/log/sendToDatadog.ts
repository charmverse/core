/* eslint-disable no-console */
import { createConfiguration } from '@datadog/datadog-api-client';
import { LogsApiV2 } from '@datadog/datadog-api-client-logs';

type DatadogLogPayload = {
  message: string;
  level: string;
  timestamp: number;
  context?: string;
  data?: any;
  service: string;
  ddsource: string;
  ddtags: string;
};

const configuration = createConfiguration();
const apiInstance = new LogsApiV2(configuration);

const env = process.env.REACT_APP_APP_ENV || process.env.NODE_ENV || 'unknown';

export function sendToDatadog(level: string, log: string, context?: any) {
  const logItem: DatadogLogPayload = {
    service: process.env.DD_SERVICE || 'unknown',
    ddsource: 'nodejs',
    ddtags: `env:${env}`,
    message: log,
    context,
    level,
    timestamp: Date.now()
  };

  return (
    apiInstance
      .submitLog({
        body: [logItem],
        ddtags: `env:${env}`
      })
      // .then((data) => {
      //   console.log(`API called successfully. Returned data: ${JSON.stringify(data)}`);
      // })
      .catch((error) => {
        console.error(`Error calling Datadog Logs API: ${error}`);
      })
  );
}
