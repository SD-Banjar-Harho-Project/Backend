import pool from "../config/database.js";

class Role {
  static async findAll() {
    const [rows] = await pool.execute("SELECT * FROM roles ORDER BY id ASC");
    return rows;
  }

  static async findById(id) {
    const [rows] = await pool.execute("SELECT * FROM roles WHERE id = ?", [id]);
    return rows[0];
  }

  static async findByName(displayName) {
    const [rows] = await pool.execute(
      "SELECT * FROM roles WHERE display_name = ?",
      [displayName]
    );
    return rows[0];
  }

  static async create(data) {
    const { display_name, descrip } = data;
    const [result] = await pool.execute(
      "INSERT INTO roles (display_name, descrip) VALUES (?, ?)",
      [display_name, descrip]
    );
    return this.findById(result.insertId);
  }

  static async update(id, data) {
    const { display_name, descrip } = data;
    await pool.execute(
      "UPDATE roles SET display_name = ?, descrip = ? WHERE id = ?",
      [display_name, descrip, id]
    );
    return this.findById(id);
  }

  static async delete(id) {
    const [result] = await pool.execute("DELETE FROM roles WHERE id = ?", [id]);
    return result.affectedRows > 0;
  }
}

export default Role;
