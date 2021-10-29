import { NextFunction, Request, Response } from "express";
import { logger } from "../logger";

/**
 * Middleware for nickname verification
 */
async function verifyNickname(req: Request, res: Response, next: NextFunction) {
  const nickname: string = req.body.nickname;
  logger.debug(JSON.stringify({from: `verifyNickname`, nickname}));
  if (nickname === "" || nickname === undefined || nickname === null || /[\{\}\[\]\(\)\\\'<!?;,@#$%^&*>+=]/.test(nickname)) {
    res.status(400).json({message: "NICKNAME VERIFICATION ERROR"})
    logger.debug(JSON.stringify({from: `verifyNickname`, status: "FAILURE"}));
  } else {
    req.body.nickname = nickname.toLowerCase();
    logger.debug(JSON.stringify({from: `verifyNickname`, status: "SUCCESSFUL"}));
    next();
  }
}

/**
 * Middleware for password verification
 */
async function verifyPassword(req: Request, res: Response, next: NextFunction) {
  const password: String = req.body.password;
  logger.debug(JSON.stringify({from: `verifyPassword`, password}));
  if (password === "" || password === undefined || password === null || password.length < 8) {
    res.status(400).json({message: "PASSWORD VERIFICATION ERROR"});
    logger.debug(JSON.stringify({from: `verifyPassword`, status: "FAILURE"}));
  } else {
    logger.debug(JSON.stringify({from: `verifyPassword`, status: "SUCCESSFUL"}));
    next();
  }
}

/**
 * Middleware for password verification
 */
async function verifyEmail(req: Request, res: Response, next: NextFunction) {
  const email: string = req.body.email;
  logger.debug(JSON.stringify({from: `verifyEmail`, email}));
  if (email === "" || email === undefined || email === null 
  || !(/^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/.test(email))) {
    res.status(400).json({message: "EMAIL VERIFICATION ERROR"});
    logger.debug(JSON.stringify({from: `verifyEmail`, status: "FAILURE"}));
  } else {
    logger.debug(JSON.stringify({from: `verifyEmail`, status: "SUCCESSFUL"}));
    next();
  }
}

export { verifyNickname, verifyPassword, verifyEmail };