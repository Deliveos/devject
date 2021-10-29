require('dotenv').config()
import express from 'express';
import mountRoutes from "./routes/index";
import {connectToDatabase} from './database';
import { logger } from './logger';


const app = express();
const port = 5000;

app.use(express.urlencoded({extended: true}));
app.use(express.json());
mountRoutes(app);
connectToDatabase();


app.listen(port, () => {
  logger.info(`Server listening at http://localhost:${port}`);
});