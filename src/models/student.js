import pool from "../config/database.js";

class Student {
  // ===========================
  // PAGINATION VERSION
  // ===========================
  static async findAllPaginated(limit, offset) {
    const [rows] = await pool.execute(
      "SELECT * FROM students ORDER BY class ASC, name ASC LIMIT ? OFFSET ?",
      [limit, offset]
    );
    return rows;
  }

  static async countAll() {
    const [rows] = await pool.execute("SELECT COUNT(*) AS total FROM students");
    return rows[0].total;
  }

  static async findByClassPaginated(className, limit, offset) {
    const [rows] = await pool.execute(
      "SELECT * FROM students WHERE class = ? ORDER BY name ASC LIMIT ? OFFSET ?",
      [className, limit, offset]
    );
    return rows;
  }

  static async countByClass(className) {
    const [rows] = await pool.execute(
      "SELECT COUNT(*) AS total FROM students WHERE class = ?",
      [className]
    );
    return rows[0].total;
  }

  // ===========================
  // ORIGINAL METHODS (DIPERBAIKI)
  // ===========================

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

  static async findByNisn(nisn) {
    const [rows] = await pool.execute("SELECT * FROM students WHERE nisn = ?", [
      nisn,
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
    const { nisn, name, class: className, gender, score_uts, score_uas } = data;

    const [result] = await pool.execute(
      "INSERT INTO students (nisn, name, class, gender, score_uts, score_uas) VALUES (?, ?, ?, ?, ?, ?)",
      [nisn, name, className, gender, score_uts, score_uas]
    );

    return this.findById(result.insertId);
  }

  static async update(id, data) {
    const { nisn, name, class: className, gender, score_uts, score_uas } = data;

    await pool.execute(
      "UPDATE students SET nisn = ?, name = ?, class = ?, gender = ?, score_uts = ?, score_uas = ? WHERE id = ?",
      [nisn, name, className, gender, score_uts, score_uas, id]
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
