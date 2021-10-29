import { Router, Request, Response } from "express";
import jwt from "jsonwebtoken";
import config from "../config";
import { UsersController } from "../controllers/users.controller";
import bcrypt from "bcrypt";
import { checkAuth } from "../middlewares/checkAuth.middleware";
import { verifyEmail, verifyNickname, verifyPassword } from "../middlewares/verification.middleware";
import { logRequest, logResponse } from "../utils/logRoures";
import { Status } from "../utils/statuses";
import { verifyToken } from "../utils/verifyToken";
import { sendResponse } from "../utils/sendResponse";
import { Message } from "../utils/messages";
const router = Router();

/*
* /api/users/
*/
router.get("/search", async (req, res)=> {
  logRequest(req);
  // check nickname or email in query parameters
  const {nickname, email} = req.query;
  const isVerifiedToken = verifyToken(req);    
  
  if (nickname != null && nickname != "") {
    const queryResult = await UsersController.searchByNickname(nickname as string);    
      if (isVerifiedToken) {
        if (queryResult.rows.length > 0) {
          const findUsers = queryResult.rows;
          const users = [];
          findUsers.forEach((user) => {
            const { id, name, nickname, email, image } = user;
            users.push({
              id,
              name,
              nickname,
              email,
              image
            })
          });
          sendResponse(res, null, {
            status: Status.SUCCESS,
            users
          });
        } else {
          sendResponse(res, null, {
            status: Status.FAILURE,
            message: Message.NOT_EXISTS
          });
        }
      } else {
        if (queryResult.rows.length > 0) {
          sendResponse(res, null, {
            status: Status.SUCCESS,
            message: Message.EXISTS
          });
        } else {
          sendResponse(res, null, {
            status: Status.FAILURE,
            message: Message.NOT_EXISTS
          });
        }
      }
  } else if (email != null && email != "") {
    const queryResult = await UsersController.getByEmail(email as string);    
      if (isVerifiedToken) {
        if (queryResult.rows.length > 0) {
          const user = queryResult.rows[0];
          sendResponse(res, null, {
            status: Status.SUCCESS,
            name: user['name'],
            nickname: user['nickname'],
            email: user['email'],
            image: user['image']
          });
        } else {
          sendResponse(res, null, {
            status: Status.FAILURE,
            message: Message.NOT_EXISTS
          });
        }
      } else {
        if (queryResult.rows.length > 0) {
          sendResponse(res, null, {
            status: Status.SUCCESS,
            message: Message.EXISTS
          });
        } else {
          sendResponse(res, null, {
            status: Status.FAILURE,
            message: Message.NOT_EXISTS
          });
        }
      }
  } else {
    sendResponse(res, null, {
      status: Status.FAILURE, 
      message: Message.REQUEST_PARAMETERS_NOT_PASSED
    });
  } 
});

router.post("/register", [verifyNickname, verifyPassword, verifyEmail], async (req, res) => {
  logRequest(req);
  const {name, nickname, email, password} = req.body;
  let responseBody = {};
  if (!(await UsersController.nicknameIsExists(nickname)) && !(await UsersController.emailIsExists(email))) {
    await UsersController.add(name, nickname, email, await bcrypt.hash(password, 7));
    const id = (await UsersController.getByNickname(nickname)).rows[0]['id'];
    sendResponse(res, null, {
      status: Status.SUCCESS,
      id,
      name,
      nickname,
      email,
      token: jwt.sign({id, name, nickname, email}, config.SECRET)
    });
  } else {
    sendResponse(res, 400, {
      status: Status.FAILURE, 
      message: 'USER WITH THIS NICKNAME OR EMAIL ALREADY EXISTS'
    });
  }
});

router.post("/login", [verifyPassword], async (req: Request, res: Response)=>  {
  logRequest(req);
  const {nickname, email, password} = req.body;
  let queryResult;
  if (nickname) {
    queryResult = await UsersController.getByNickname(nickname);
  } else if (email) {
    queryResult = await UsersController.getByEmail(email);
  }
  
  if (queryResult != null && queryResult.rowCount !== 0) {
    if (bcrypt.compare(password, queryResult.rows[0]['password'])) {
      sendResponse(res, 202, {
        status: Status.SUCCESS,
        id: queryResult.rows[0]['id'],
        name: queryResult.rows[0]['name'],
        email: queryResult.rows[0]['email'],
        nickname,
        token: jwt.sign({id: queryResult.rows[0]['id'], name: queryResult.rows[0]['name'], nickname, email: queryResult.rows[0]['email']}, config.SECRET)
      });
    } else {
      sendResponse(res, 403, {
        status: Status.FAILURE, 
        message: Message.AUTHORIZATION_IS_FAILED
      });
    }
  } else {
    sendResponse(res, 404, {status: Status.FAILURE, message: Message.NOT_EXISTS});
  }
});

// FIXME: id = token.id
router.delete("/:id", [checkAuth], async (req: Request, res: Response) => {
  const id = Number(req.params.id);
  await UsersController.delete(id);
  res.json({status: Status.SUCCESS});
});

/*
* /api/users/:user_id/projects/:project_id
*
* Response deliveos: 
* {
*   id: a6a2729cbf6bcadce577a31f7f76201d5ce63c57d6c53318000d67714bb354ef,
*   user_id: a6a2729cbf6bcadce577a31f7f76201d5ce63c57d6c53318000d67714bb354ea,
*   name: Test project,
*   description: Just test project,
*   start: 2021.11.01 00:00:00,
*   end: 2022.02.01 00:00:00
*   tasks: [
*     {
*       id: a6a2729cbf6bcadce577a31f7f76201d5ce63c57d6c5331asdasdd67714bbasbg5,
*       name: Task1,
*       description: null,
*       start: 2021.11.01 00:00:00,
*       end: 2021.11.03 00:00:00,
*       tasks: [
*         {
*           id: a6a272b59ce577a31f3c57d6c5331a7f76201d5ce6sdasdd67basbg714cbf6bcad,
*           name: Subtask into Task1,
*           description: null,
*           start: 2021.11.01 00:00:00,
*           end: 2021.11.02 00:00:00,
*           responsible: {
*             id: a6a2729cbf6bcadce577a31f7f76201d5ce63c57d6c53318000d67714bb354ef,
*             name: John Doe,
*             nickname: JoNNy
*           },
*           isDone: false
*         },
*         {
*           id: a6a272b59ce577a31f3c57d6c5331a7f76201d5ce6sdasdd67basbg714cbf6bcad,
*           name: Subtask2 into Task1,
*           description: null,
*           startWhenFinished: a6a272b59ce577a31f3c57d6c5331a7f76201d5ce6sdasdd67basbg714cbf6bcad,
*           end: 2021.11.03 00:00:00,
*           responsible: {
*             id: a6a2729cbf6bcadce577a31f7f76201d5ce63c57d6c53318000d67714bb354ef,
*             name: John Doe,
*             nickname: JoNNy
*           },
*           isDone: false
*         }
*       ],
*       isDone: false
*     }
*   ],
*   responsible: {
*     id: a6a2729cbf6bcadce577a31f7f76201d5ce63c57d6c53318000d67714bb354ef,
*     name: John Doe,
*     nickname: JoNNy
*   }
* }
*/
router.get('/:user_id/projects/:project_id', async (req: Request, res: Response) => {
  const userId = req.params.user_id;
  const projectId = req.params.project_id;
});

/* Create new task
* /api/user/:user_id/projects/:project_id/tasks/
*/

router.post('/:user_id/projects/:project_id/tasks/', async (req: Request, res: Response) => {
  const userId = req.params.user_id;
  const projectId = req.params.project_id;
});

export default router;