import pool from "../config/database.js";

class Subject {
  static async findAll() {
    const [rows] = await pool.execute(
      "SELECT * FROM subjects ORDER BY subject_name ASC"
    );
    return rows;
  }

  static async findById(id) {
    const [rows] = await pool.execute("SELECT * FROM subjects WHERE id = ?", [
      id,
    ]);
    return rows[0];
  }

  static async create(data) {
    const { subject_name } = data;
    const [result] = await pool.execute(
      "INSERT INTO subjects (subject_name) VALUES (?)",
      [subject_name]
    );
    return this.findById(result.insertId);
  }

  static async update(id, data) {
    const { subject_name } = data;
    await pool.execute("UPDATE subjects SET subject_name = ? WHERE id = ?", [
      subject_name,
      id,
    ]);
    return this.findById(id);
  }

  static async delete(id) {
    const [result] = await pool.execute("DELETE FROM subjects WHERE id = ?", [
      id,
    ]);
    return result.affectedRows > 0;
  }
}

export default Subject;
