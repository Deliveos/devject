import { Response } from 'express';
import { logResponse } from './logRoures';

const sendResponse = (res: Response, status: number | null, body: object) => {
  if(status != null) {
    res.status(status).json(body);
  } else {
    res.json(body)
  }
  logResponse(res.getHeaders(), body);
}

export { sendResponse };