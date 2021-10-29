import { pool } from "../database";

class UsersController {
  static async add(name: String, nickname: String, email: String, password: String) {
    return await pool.query(
      "INSERT INTO users(name, nickname, email, password) VALUES($1, $2, $3, $4)", 
      [name, nickname, email, password]
    );
  }

  static async delete(id: Number) {
  return await pool.query(
      "DELETE FROM users WHERE id=$1", 
      [id]
    );
  }

  static async update(name: String, image: String, password: String, id: Number) {
    return await pool.query(
      "UPDATE users SET name=$1, image=$2, password=$3 WHERE id=$4", 
      [name, image, password, id]
    );
  }

  static async getById(id: Number) {
    return await pool.query(
      "SELECT * FROM users WHERE id=$1", 
      [id]
    );
  }

  static async getByNickname(nickname: string) {
    return await pool.query(
      "SELECT * FROM users WHERE nickname=$1", 
      [nickname]
    );
  }

  static async searchByNickname(nickname: string) {
    return await pool.query(
      "SELECT * FROM users WHERE nickname LIKE $1", 
      [nickname+'%']
    );
  }

  static async getByEmail(email: string) {
    return await pool.query(
      "SELECT * FROM users WHERE email=$1", 
      [email]
    );
  }

  static async nicknameIsExists(nickname: string): Promise<Boolean> {
    const queryResult = await pool.query(
      "SELECT id FROM users WHERE nickname=$1", 
      [nickname]
    );
    if (queryResult.rowCount === 0) return false;
    else return true;
  }

  static async emailIsExists(email: string): Promise<Boolean> {
    const queryResult = await pool.query(
      "SELECT id FROM users WHERE email=$1", 
      [email]
    );
    if (queryResult.rowCount === 0) return false;
    else return true;
  }
}

export { UsersController };