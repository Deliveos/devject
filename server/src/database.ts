import config from "./config";
import { Pool } from "pg";
import { logger } from "./logger";

const pool = new Pool({
  user: config.PG_USER,
  host: config.PG_HOST,
  port: config.PG_PORT,
  database: config.PG_DATABASE,
  password: config.PG_PASSWORD
});

pool.on('error', (err, client) => {
  console.error('Unexpected error on idle client', err)
  process.exit(-1)
})

async function connectToDatabase () {
  pool.connect((err, client, done) => {
    if (err) throw err;
    client.query(`
    CREATE TABLE IF NOT EXISTS users (
      id INT GENERATED ALWAYS AS IDENTITY,
      name VARCHAR(255),
      nickname VARCHAR(255),
      email VARCHAR(255),
      password VARCHAR(255),
      image TEXT,
      PRIMARY KEY(id)
    );
    
    CREATE TABLE IF NOT EXISTS projects (
      id INT GENERATED ALWAYS AS IDENTITY,
      name VARCHAR(255) NOT NULL,
      description TEXT,
      start_date TIMESTAMP,
      end_date TIMESTAMP,
      owner_id INT,
      progress INT DEFAULT 0,
      CONSTRAINT fk_user
        FOREIGN KEY(owner_id) 
            REFERENCES users(id),
      PRIMARY KEY(id)
    );
    
    CREATE TABLE IF NOT EXISTS tasks (
      id INT GENERATED ALWAYS AS IDENTITY,
      name VARCHAR(255) NOT NULL,
      description TEXT,
      start_date TIMESTAMP,
      start_when_finished_id INT,
      end_date TIMESTAMP,
      time_execution TIMESTAMP,
      project_id INT,
      parent_task_id INT,
      responsible_id INT,
      progress INT DEFAULT 0,
      CONSTRAINT fk_project
        FOREIGN KEY(project_id) 
            REFERENCES projects(id),
      CONSTRAINT fk_parent_task
        FOREIGN KEY(parent_task_id) 
            REFERENCES tasks(id),
      CONSTRAINT fk_task
        FOREIGN KEY(parent_task_id) 
            REFERENCES tasks(id),
      CONSTRAINT fk_start_when_finished
        FOREIGN KEY(start_when_finished_id) 
            REFERENCES tasks(id),
      CONSTRAINT fk_responsible
        FOREIGN KEY(responsible_id)
            REFERENCES users(id),
      PRIMARY KEY(id)
    );
    
    CREATE TABLE IF NOT EXISTS responsible (
      project_id INT,
      user_id INT,
      CONSTRAINT fk_project
        FOREIGN KEY(project_id) 
          REFERENCES projects(id),
      CONSTRAINT fk_user
        FOREIGN KEY(user_id) 
          REFERENCES users(id)
    );
    `, (err, res) => {
      done()
      if (err) {
        console.log(err.stack);
      }
    })
  });
  logger.debug("Database has been connected")
}

export { pool, connectToDatabase};