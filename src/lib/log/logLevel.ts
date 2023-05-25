import type { Logger as DatadogLogger } from '@datadog/browser-logs';
import { datadogLogs } from '@datadog/browser-logs';
import { RateLimit } from 'async-sema';
import type { Logger, LogLevelDesc } from 'loglevel';
import _log from 'loglevel';

import * as http from '../../adapters/http';
import { isNodeEnv, isProdEnv, isStagingEnv } from '../../config/constants';

import { formatLog } from './logUtils';

const ERRORS_WEBHOOK =
  'https://discord.com/api/webhooks/898365255703470182/HqS3KqH_7-_dj0KYR6EzNqWhkH0yX6kvV_P32sZ3gnvB8M4AyMoy7W9bbjIul3Hmyu98';
const originalFactory = _log.methodFactory;
const enableDiscordAlerts = (isStagingEnv || isProdEnv) && isNodeEnv;
const enableDatadogLogs = (isStagingEnv || isProdEnv) && !isNodeEnv;

const datadogLogMethods = ['log', 'debug', 'info', 'warn', 'error'] as const;
type DatadogLogMethod = (typeof datadogLogMethods)[number];
type DatadogLogFunction = DatadogLogger['log'];

// requests per second = 35, timeUnit = 1sec
const discordRateLimiter = RateLimit(30);

/**
 * Enable formatting special logs for Datadog in production
 * Example:
 *    charmverse \[%{date("yyyy-MM-dd HH:mm:ss"):date}\]\s+%{word:level}: (\[%{notSpace:logger}\] )?%{regex("[^{]*"):message}%{data::json}
 * Resources for Datadog logging:
 *    Parsing rules: https://docs.datadoghq.com/logs/log_configuration/parsing/?tab=matchers#examples
 *    Mapping fields to log message and log level: https://docs.datadoghq.com/logs/log_configuration/processors/?tab=ui#log-status-remapper
 *    Best practices: https://docs.datadoghq.com/logs/guide/log-parsing-best-practice/
 */
const formatLogsForDocker = (isProdEnv || isStagingEnv) && isNodeEnv;

export function apply(log: Logger, logPrefix: string = '') {
  const defaultLevel = (process.env.LOG_LEVEL as LogLevelDesc) || log.levels.DEBUG;
  log.setDefaultLevel(defaultLevel);

  // dont apply logger in browser because it changes the stack tracke/line number
  if (isNodeEnv) {
    log.methodFactory = (methodName, logLevel, loggerName) => {
      const originalMethod = originalFactory(methodName, logLevel, loggerName);

      return (message, opt: unknown) => {
        const args = formatLog(message, opt, {
          formatLogsForDocker,
          isNodeEnv,
          logPrefix,
          methodName
        });
        originalMethod.apply(null, args);

        // post errors to Discord
        if (isProdEnv && methodName === 'error' && enableDiscordAlerts) {
          sendErrorToDiscord(ERRORS_WEBHOOK, message, opt).catch((error) => {
            logErrorPlain('Error posting to discord', { originalMessage: message, error });
          });
        }
      };
    };

    log.setLevel(log.getLevel()); // Be sure to call setLevel method in order to apply plugin
  } else if (enableDatadogLogs) {
    log.methodFactory = (methodName, logLevel, loggerName) => {
      const originalMethod = originalFactory(methodName, logLevel, loggerName);
      return (message, ...args) => {
        originalMethod.apply(null, [message, ...args]);
        const firstArg = args[0];
        const error = firstArg instanceof Error ? firstArg : (firstArg as any)?.error || firstArg;
        datadogLogs.logger.log(message, firstArg, methodName as any, error);
      };
    };
    log.setLevel(log.getLevel()); // Be sure to call setLevel method in order to apply plugin
  }

  return log;
}

// log an error without calling Discord
function logErrorPlain(message: string, opts: any) {
  // eslint-disable-next-line no-console
  console.error(
    ...formatLog(message, opts, {
      formatLogsForDocker,
      isNodeEnv,
      methodName: 'error'
    })
  );
}

async function sendErrorToDiscord(webhook: string, message: any, opt: any) {
  let fields: { name: string; value?: string }[] = [];
  if (opt instanceof Error) {
    fields = [
      { name: 'Error', value: opt.message },
      { name: 'Stacktrace', value: opt.stack?.slice(0, 500) }
    ];
  } else if (opt) {
    fields = Object.entries<any>(opt)
      .map(([name, _value]) => {
        const value = typeof _value === 'string' ? _value.slice(0, 500) : JSON.stringify(_value || {});
        return { name, value };
      })
      .slice(0, 5); // add a sane max # of fields just in case
  }
  await discordRateLimiter();
  return http.POST(webhook, {
    embeds: [
      {
        color: 14362664, // #db2828
        description: message,
        fields
      }
    ]
  });
}
