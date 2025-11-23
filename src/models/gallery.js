import pool from "../config/database.js";

class Gallery {
  static async findAll() {
    const [rows] = await pool.execute(
      "SELECT * FROM galleries WHERE deleted_at IS NULL ORDER BY created_at DESC"
    );
    return rows;
  }

  static async findPublished() {
    const [rows] = await pool.execute(
      `SELECT * FROM galleries 
       WHERE status = 'published' AND deleted_at IS NULL 
       ORDER BY created_at DESC`
    );
    return rows;
  }

  static async findById(id) {
    const [rows] = await pool.execute(
      "SELECT * FROM galleries WHERE id = ? AND deleted_at IS NULL",
      [id]
    );
    return rows[0];
  }

  static async findBySlug(slug) {
    const [rows] = await pool.execute(
      "SELECT * FROM galleries WHERE slug = ? AND deleted_at IS NULL",
      [slug]
    );
    return rows[0];
  }

  static async create(data) {
    const { title, slug, descr, img, video, status } = data;

    const [result] = await pool.execute(
      "INSERT INTO galleries (title, slug, descr, img, video, status) VALUES (?, ?, ?, ?, ?, ?)",
      [title, slug, descr, img, video, status || "draft"]
    );

    return this.findById(result.insertId);
  }

  static async update(id, data) {
    const { title, slug, descr, img, video, status } = data;

    await pool.execute(
      `UPDATE galleries 
       SET title = ?, slug = ?, descr = ?, img = ?, video = ?, status = ?
       WHERE id = ?`,
      [title, slug, descr, img, video, status, id]
    );

    return this.findById(id);
  }

  static async softDelete(id) {
    await pool.execute("UPDATE galleries SET deleted_at = NOW() WHERE id = ?", [
      id,
    ]);
    return true;
  }

  static async updateStatus(id, status) {
    await pool.execute("UPDATE galleries SET status = ? WHERE id = ?", [
      status,
      id,
    ]);
    return this.findById(id);
  }
}

export default Gallery;
