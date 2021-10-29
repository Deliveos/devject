import { Request, Response, Router } from "express";
import { checkAuth } from "../middlewares/checkAuth.middleware";
import { ProjectsController } from "../controllers/projects.controller";
import jwt from "jsonwebtoken";
import config from "../config";
import { logRequest } from "../utils/logRoures";
import { sendResponse } from "../utils/sendResponse";
import { Status } from "../utils/statuses";

const router = Router();

router.post('/', [checkAuth], async (req: Request, res: Response) => {
  logRequest(req);
  const {name, description, responsible, startDate, endDate} = req.body;
  const jwtPayload = jwt.verify(req.headers.authorization.split(' ')[1], config.SECRET) as string;
  const ownerId = jwtPayload['id'];
  const queryResult = await ProjectsController.add(name, description, responsible, startDate, endDate, ownerId);
  if (queryResult.rowCount == 1) {
    sendResponse(res, 201, {status: "SUCCESS"});
  }
  else {
    sendResponse(res, 400, {status: "FAILURE"});
  }
});

router.get('/', [checkAuth], async (req: Request, res: Response) => {
  logRequest(req);
  const jwtPayload = jwt.verify(req.headers.authorization.split(' ')[1], config.SECRET) as string;
  const ownerId = jwtPayload['id'];
  const queryResult = await ProjectsController.getAll(ownerId);
  sendResponse(res, null, {
    status: Status.SUCCESS,
    projects: queryResult.rows
  });
});

export default router;