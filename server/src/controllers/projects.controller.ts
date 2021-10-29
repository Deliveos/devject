import { pool } from "../database";

class ProjectsController {
  static async add(name: String, description: String, responsible: Array<Number>, startDate, endDate, ownerId: Number) {
    const project = await pool.query(
      "INSERT INTO projects(name, description, start_date, end_date, owner_id) VALUES($1, $2, $3, $4, $5)", 
      [name, description, startDate, endDate, ownerId]
    );
    responsible.forEach(async userId => 
      await pool.query(
        "INSERT INTO responsible(user_id, project_id) VALUES($1, $2)",
        [userId, (await pool.query("SELECT MAX(id) AS id FROM projects WHERE owner_id=$1", [ownerId])).rows[0]['id']]
      )
    );
    return project;
  }

  static async delete(projectId: Number, ownerId: Number) {
  return await pool.query(
      "DELETE FROM projects WHERE projectId=$1 AND ownerId=$2", 
      [projectId, ownerId]
    );
  }

  static async update(name: String, description: String, startDate, endDate, ownerId: Number, progress: Number, id: Number) {
    return await pool.query(
      "UPDATE projects SET name=$1, description=$2, start_date=$3, end_date=$4, owner_id=$5, progress=$6 WHERE id=$6", 
      [name, description, startDate, endDate, ownerId, progress, id]
    );
  }

  static async getAll(ownerId: Number) {
    const projects = await pool.query(
      "SELECT * FROM projects WHERE owner_id=$1", 
      [ownerId]
    );
    for (let i = 0; i < projects.rows.length; i++) {
      const responsible = await pool.query(
        `SELECT id, name, nickname FROM responsible
        INNER JOIN users ON users.id=user_id
        WHERE project_id=$1`, 
        [projects.rows[0]['id']]
      );
      projects.rows[i]['responsible'] = responsible.rows;
    }
    return projects;
  }

  static async get(projectId: Number, ownerId: Number) {
    return await pool.query(
      "SELECT * FROM projects WHERE projectId=$1 AND ownerId=$2", 
      [projectId, ownerId]
    );
  }
}

export { ProjectsController };