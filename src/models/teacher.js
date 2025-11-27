import pool from "../config/database.js";

class Teacher {
  // ===============================
  // PAGINATION VERSION
  // ===============================
  static async findAllPaginated(limit, offset) {
    const [rows] = await pool.execute(
      `SELECT t.*, s.subject_name, u.username 
       FROM teachers t 
       LEFT JOIN subjects s ON t.subject_id = s.id 
       LEFT JOIN users u ON t.user_id = u.id 
       WHERE t.deleted_at IS NULL 
       ORDER BY t.created_at DESC
       LIMIT ? OFFSET ?`,
      [limit, offset]
    );
    return rows;
  }

  static async countAll() {
    const [rows] = await pool.execute(
      `SELECT COUNT(*) AS total FROM teachers WHERE deleted_at IS NULL`
    );
    return rows[0].total;
  }

  static async findDeletedPaginated(limit, offset) {
    const [rows] = await pool.execute(
      `SELECT t.*, s.subject_name, u.username 
       FROM teachers t 
       LEFT JOIN subjects s ON t.subject_id = s.id 
       LEFT JOIN users u ON t.user_id = u.id 
       WHERE t.deleted_at IS NOT NULL 
       ORDER BY t.deleted_at DESC
       LIMIT ? OFFSET ?`,
      [limit, offset]
    );
    return rows;
  }

  static async countDeleted() {
    const [rows] = await pool.execute(
      `SELECT COUNT(*) AS total FROM teachers WHERE deleted_at IS NOT NULL`
    );
    return rows[0].total;
  }

  // ===============================
  // ORIGINAL METHODS
  // ===============================
  static async findAll() {
    const [rows] = await pool.execute(
      `SELECT t.*, s.subject_name, u.username 
       FROM teachers t 
       LEFT JOIN subjects s ON t.subject_id = s.id 
       LEFT JOIN users u ON t.user_id = u.id 
       WHERE t.deleted_at IS NULL 
       ORDER BY t.created_at DESC`
    );
    return rows;
  }

  static async findById(id) {
    const [rows] = await pool.execute(
      `SELECT t.*, s.subject_name, u.username 
       FROM teachers t 
       LEFT JOIN subjects s ON t.subject_id = s.id 
       LEFT JOIN users u ON t.user_id = u.id 
       WHERE t.id = ? AND t.deleted_at IS NULL`,
      [id]
    );
    return rows[0];
  }

  static async findByUserId(userId) {
    const [rows] = await pool.execute(
      `SELECT t.*, s.subject_name 
       FROM teachers t 
       LEFT JOIN subjects s ON t.subject_id = s.id 
       WHERE t.user_id = ? AND t.deleted_at IS NULL`,
      [userId]
    );
    return rows[0];
  }

  // ===============================
  // FIND DELETED METHODS
  // ===============================
  static async findDeleted() {
    const [rows] = await pool.execute(
      `SELECT t.*, s.subject_name, u.username 
       FROM teachers t 
       LEFT JOIN subjects s ON t.subject_id = s.id 
       LEFT JOIN users u ON t.user_id = u.id 
       WHERE t.deleted_at IS NOT NULL 
       ORDER BY t.deleted_at DESC`
    );
    return rows;
  }

  static async findDeletedById(id) {
    const [rows] = await pool.execute(
      `SELECT t.*, s.subject_name, u.username 
       FROM teachers t 
       LEFT JOIN subjects s ON t.subject_id = s.id 
       LEFT JOIN users u ON t.user_id = u.id 
       WHERE t.id = ? AND t.deleted_at IS NOT NULL`,
      [id]
    );
    return rows[0];
  }

  // ===============================
  // CREATE & UPDATE
  // ===============================
  static async create(data) {
    const {
      user_id,
      nip,
      name,
      photo,
      subject_id,
      class_name,
      email,
      phone,
      bio,
      join_date,
    } = data;

    const [result] = await pool.execute(
      `INSERT INTO teachers 
       (user_id, nip, name, photo, subject_id, class_name, email, phone, bio, join_date) 
       VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`,
      [
        user_id,
        nip,
        name,
        photo,
        subject_id,
        class_name,
        email,
        phone,
        bio,
        join_date,
      ]
    );

    return this.findById(result.insertId);
  }

  static async update(id, data) {
    const {
      user_id,
      nip,
      name,
      photo,
      subject_id,
      class_name,
      email,
      phone,
      bio,
      join_date,
      is_active,
    } = data;

    await pool.execute(
      `UPDATE teachers 
       SET user_id = ?, nip = ?, name = ?, photo = ?, subject_id = ?, 
           class_name = ?, email = ?, phone = ?, bio = ?, join_date = ?, is_active = ?
       WHERE id = ?`,
      [
        user_id,
        nip,
        name,
        photo,
        subject_id,
        class_name,
        email,
        phone,
        bio,
        join_date,
        is_active,
        id,
      ]
    );

    return this.findById(id);
  }

  // ===============================
  // DELETE & RESTORE
  // ===============================
  static async softDelete(id) {
    await pool.execute("UPDATE teachers SET deleted_at = NOW() WHERE id = ?", [
      id,
    ]);
    return true;
  }

  static async restore(id) {
    await pool.execute("UPDATE teachers SET deleted_at = NULL WHERE id = ?", [
      id,
    ]);
    return this.findById(id);
  }

  // ===============================
  // UTILITY METHODS
  // ===============================
  static async findActive() {
    const [rows] = await pool.execute(
      `SELECT t.*, s.subject_name 
       FROM teachers t 
       LEFT JOIN subjects s ON t.subject_id = s.id 
       WHERE t.is_active = 1 AND t.deleted_at IS NULL 
       ORDER BY t.name ASC`
    );
    return rows;
  }
}

export default Teacher;
