import pool from "../config/database.js";

class Student {
  static async findAll() {
    const [rows] = await pool.execute(
      "SELECT * FROM students ORDER BY class ASC, name ASC"
    );
    return rows;
  }

  static async findById(id) {
    const [rows] = await pool.execute("SELECT * FROM students WHERE id = ?", [
      id,
    ]);
    return rows[0];
  }

  static async findByClass(className) {
    const [rows] = await pool.execute(
      "SELECT * FROM students WHERE class = ? ORDER BY name ASC",
      [className]
    );
    return rows;
  }

  static async create(data) {
    const { name, class: className, gender, score_uts, score_uas } = data;

    const [result] = await pool.execute(
      "INSERT INTO students (name, class, gender, score_uts, score_uas) VALUES (?, ?, ?, ?, ?)",
      [name, className, gender, score_uts, score_uas]
    );

    return this.findById(result.insertId);
  }

  static async update(id, data) {
    const { name, class: className, gender, score_uts, score_uas } = data;

    await pool.execute(
      "UPDATE students SET name = ?, class = ?, gender = ?, score_uts = ?, score_uas = ? WHERE id = ?",
      [name, className, gender, score_uts, score_uas, id]
    );

    return this.findById(id);
  }

  static async delete(id) {
    const [result] = await pool.execute("DELETE FROM students WHERE id = ?", [
      id,
    ]);
    return result.affectedRows > 0;
  }

  static async getStatsByClass() {
    const [rows] = await pool.execute(
      `SELECT 
         class,
         COUNT(*) as total_students,
         AVG(score_uts) as avg_uts,
         AVG(score_uas) as avg_uas,
         COUNT(CASE WHEN gender = 'L' THEN 1 END) as male_count,
         COUNT(CASE WHEN gender = 'P' THEN 1 END) as female_count
       FROM students 
       GROUP BY class 
       ORDER BY class ASC`
    );
    return rows;
  }
}

export default Student;
