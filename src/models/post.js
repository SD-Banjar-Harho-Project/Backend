import pool from "../config/database.js";

class Post {
  static async getAllPost() {
    const [rows] = await pool.execute(
      `SELECT p.*, u.full_name as author_name 
       FROM posts p 
       LEFT JOIN users u ON p.author_id = u.id 
       WHERE p.deleted_at IS NULL 
       ORDER BY p.created_at DESC`
    );
    return rows;
  }

  static async findPublished() {
    const [rows] = await pool.execute(
      `SELECT p.*, u.full_name as author_name 
       FROM posts p 
       LEFT JOIN users u ON p.author_id = u.id 
       WHERE p.status = 'published' AND p.deleted_at IS NULL 
       ORDER BY p.created_at DESC`
    );
    return rows;
  }

  static async findById(id) {
    const [rows] = await pool.execute(
      `SELECT p.*, u.full_name as author_name 
       FROM posts p 
       LEFT JOIN users u ON p.author_id = u.id 
       WHERE p.id = ? AND p.deleted_at IS NULL`,
      [id]
    );
    return rows[0];
  }

  static async findBySlug(slug) {
    const [rows] = await pool.execute(
      `SELECT p.*, u.full_name as author_name 
       FROM posts p 
       LEFT JOIN users u ON p.author_id = u.id 
       WHERE p.slug = ? AND p.deleted_at IS NULL`,
      [slug]
    );
    return rows[0];
  }

  static async findByAuthor(authorId) {
    const [rows] = await pool.execute(
      `SELECT p.*, u.full_name as author_name 
       FROM posts p 
       LEFT JOIN users u ON p.author_id = u.id 
       WHERE p.author_id = ? AND p.deleted_at IS NULL 
       ORDER BY p.created_at DESC`,
      [authorId]
    );
    return rows;
  }

  static async create(data) {
    const { author_id, title, slug, content, status } = data;

    const [result] = await pool.execute(
      "INSERT INTO posts (author_id, title, slug, content, status) VALUES (?, ?, ?, ?, ?)",
      [author_id, title, slug, content, status || "draft"]
    );

    return this.findById(result.insertId);
  }

  static async update(id, data) {
    const { title, slug, content, status } = data;

    await pool.execute(
      "UPDATE posts SET title = ?, slug = ?, content = ?, status = ? WHERE id = ?",
      [title, slug, content, status, id]
    );

    return this.findById(id);
  }

  static async softDelete(id) {
    await pool.execute("UPDATE posts SET deleted_at = NOW() WHERE id = ?", [
      id,
    ]);
    return true;
  }

  static async updateStatus(id, status) {
    await pool.execute("UPDATE posts SET status = ? WHERE id = ?", [
      status,
      id,
    ]);
    return this.findById(id);
  }
}

export default Post;
