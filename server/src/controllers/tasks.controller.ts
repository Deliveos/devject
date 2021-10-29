import { pool } from "../database";

class TasksController {
  static async add(name: String, description: String, startDate, endDate, ownerId: Number) {
    return await pool.query(
      "INSERT INTO task(name, description, startDate, endDate, ownerId) VALUES($1, $2, $3, $4, $5)", 
      [name, description, startDate, endDate, ownerId]
    );
  }

  static async delete(projectId: Number, ownerId: Number) {
  return await pool.query(
      "DELETE FROM projects WHERE projectId=$1 AND ownerId=$2", 
      [projectId, ownerId]
    );
  }

  static async update(name: String, description: String, startDate, endDate, ownerId: Number, isDone: Boolean, id: Number) {
    return await pool.query(
      "UPDATE projects SET name=$1, description=$2, startDate=$3, endDate=$4, ownerId=$5, isDone=$6 WHERE id=$6", 
      [name, description, startDate, endDate, ownerId, isDone, id]
    );
  }

  static async getAll(ownerId: Number) {
    return await pool.query(
      "SELECT * FROM projects WHERE ownerId=$1", 
      [ownerId]
    );
  }

  static async get(projectId: Number, ownerId: Number) {
    return await pool.query(
      "SELECT * FROM projects WHERE projectId=$1 AND ownerId=$2", 
      [projectId, ownerId]
    );
  }
}

export { TasksController };