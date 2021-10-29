import jwt from 'jsonwebtoken';
import { NextFunction, Request, Response } from "express";
import config from '../config';
import { logger } from '../logger';

/**
 * Middleware for token verification in `Authorization` headers
 */
async function checkAuth(req: Request, res: Response, next: NextFunction) {
  logger.debug(JSON.stringify({from: `checkAuth`, authorization: req.headers.authorization}));
  if (req.headers.authorization != undefined && req.headers.authorization.split(' ')[0] === 'Bearer') {
    const token = req.headers.authorization.split(' ')[1];
    if (jwt.verify(token, config.SECRET)) {
      logger.debug(JSON.stringify({from: `checkAuth`, status: "SUCCESSFUL"}));
      next();
    } else {
      logger.debug(JSON.stringify({from: `checkAuth`, status: "FAILURE"}));
      res.status(403).json({message: "Forbidden"});
    }
  }
}

export { checkAuth };