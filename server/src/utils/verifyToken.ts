import { Request } from 'express';
import config from '../config';
import jwt from 'jsonwebtoken';

const verifyToken = (req: Request) : boolean => {
  if (req.headers.authorization != undefined && req.headers.authorization.split(' ')[0] === 'Bearer') {
    const token = req.headers.authorization.split(' ')[1];
    if (jwt.verify(token, config.SECRET)) return true;
    return false;
  }
}

export { verifyToken };