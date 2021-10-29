import { Request } from 'express';
import { logger } from '../logger';

const logRequest = (req: Request) => {
  logger.info(`[${req.method}] Request to ${req.originalUrl}`);
  logger.debug(`Request: ${JSON.stringify({headers: req.headers, body: req.body})}`);
}

const logResponse = (headers, body) => {
  logger.debug(`Response: ${JSON.stringify({ headers, body })
  }`);
}

export {logRequest, logResponse}; 