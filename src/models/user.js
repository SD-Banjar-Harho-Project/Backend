import pool from "../config/database.js";
import bcrypt from "bcryptjs";

class User {
  static async findAll(limit = null, offset = null) {
    let query = `
      SELECT u.*, r.display_name as role 
      FROM users u 
      LEFT JOIN roles r ON u.role_id = r.id 
      WHERE u.deleted_at IS NULL 
      ORDER BY u.created_at DESC
    `;

    if (limit !== null && offset !== null) {
      query += ` LIMIT ? OFFSET ?`;
      const [rows] = await pool.execute(query, [limit, offset]);
      return rows;
    }

    const [rows] = await pool.execute(query);
    return rows;
  }

  static async findById(id) {
    const [rows] = await pool.execute(
      `SELECT u.*, r.display_name as role 
       FROM users u 
       LEFT JOIN roles r ON u.role_id = r.id 
       WHERE u.id = ? AND u.deleted_at IS NULL`,
      [id]
    );
    return rows[0];
  }

  static async findByUsername(username) {
    const [rows] = await pool.execute(
      `SELECT * FROM users WHERE username = ? AND deleted_at IS NULL`,
      [username]
    );
    return rows[0];
  }

  static async findByEmail(email) {
    const [rows] = await pool.execute(
      `SELECT * FROM users WHERE email = ? AND deleted_at IS NULL`,
      [email]
    );
    return rows[0];
  }

  static async create(data) {
    const {
      username,
      email,
      password_hash,
      full_name,
      phone,
      role_id,
      is_active,
    } = data;

    const [result] = await pool.execute(
      `INSERT INTO users (username, email, password_hash, full_name, phone, role_id, is_active) 
       VALUES (?, ?, ?, ?, ?, ?, ?)`,
      [
        username,
        email || null,
        password_hash,
        full_name,
        phone || null,
        role_id || 3,
        is_active !== undefined ? is_active : 1,
      ]
    );

    return this.findById(result.insertId);
  }

  static async update(id, data) {
    const { email, full_name, phone, role_id, is_active } = data;

    await pool.execute(
      `UPDATE users 
       SET email = ?, full_name = ?, phone = ?, role_id = ?, is_active = ?
       WHERE id = ?`,
      [email, full_name, phone, role_id, is_active, id]
    );

    return this.findById(id);
  }

  static async updatePassword(id, password_hash) {
    await pool.execute("UPDATE users SET password_hash = ? WHERE id = ?", [
      password_hash,
      id,
    ]);
    return true;
  }

  static async updateLastLogin(id) {
    try {
      await pool.execute("UPDATE users SET last_login = NOW() WHERE id = ?", [
        id,
      ]);
    } catch (error) {
      // Silently fail if last_login column doesn't exist
      // This allows the login to continue even if the column is missing
      console.warn("last_login column not found, skipping update");
    }
  }

  static async softDelete(id) {
    await pool.execute("UPDATE users SET deleted_at = NOW() WHERE id = ?", [
      id,
    ]);
    return true;
  }

  static async delete(id) {
    return this.softDelete(id);
  }

  static async verifyPassword(plainPassword, hashedPassword) {
    return bcrypt.compare(plainPassword, hashedPassword);
  }

  static async findDeleted(limit = null, offset = null) {
    let query = `
      SELECT u.*, r.display_name as role 
      FROM users u 
      LEFT JOIN roles r ON u.role_id = r.id 
      WHERE u.deleted_at IS NOT NULL 
      ORDER BY u.deleted_at DESC
    `;

    if (limit !== null && offset !== null) {
      query += ` LIMIT ? OFFSET ?`;
      const [rows] = await pool.execute(query, [limit, offset]);
      return rows;
    }

    const [rows] = await pool.execute(query);
    return rows;
  }

  static async restore(id) {
    await pool.execute("UPDATE users SET deleted_at = NULL WHERE id = ?", [id]);
    return this.findById(id);
  }

  static async count() {
    const [rows] = await pool.execute(
      `SELECT COUNT(*) as total FROM users WHERE deleted_at IS NULL`
    );
    return rows[0].total;
  }

  static async countDeleted() {
    const [rows] = await pool.execute(
      `SELECT COUNT(*) as total FROM users WHERE deleted_at IS NOT NULL`
    );
    return rows[0].total;
  }

  static async search(searchTerm, limit = null, offset = null) {
    const searchPattern = `%${searchTerm}%`;

    let query = `
      SELECT u.*, r.display_name as role 
      FROM users u 
      LEFT JOIN roles r ON u.role_id = r.id 
      WHERE u.deleted_at IS NULL
      AND (u.username LIKE ? OR u.email LIKE ? OR u.full_name LIKE ?)
      ORDER BY u.created_at DESC
    `;

    if (limit !== null && offset !== null) {
      query += ` LIMIT ? OFFSET ?`;
      const [rows] = await pool.execute(query, [
        searchPattern,
        searchPattern,
        searchPattern,
        limit,
        offset,
      ]);
      return rows;
    }

    const [rows] = await pool.execute(query, [
      searchPattern,
      searchPattern,
      searchPattern,
    ]);
    return rows;
  }

  static async countSearch(searchTerm) {
    const pattern = `%${searchTerm}%`;
    const [rows] = await pool.execute(
      `SELECT COUNT(*) as total 
       FROM users 
       WHERE deleted_at IS NULL
       AND (username LIKE ? OR email LIKE ? OR full_name LIKE ?)`,
      [pattern, pattern, pattern]
    );
    return rows[0].total;
  }
}

export default User;
