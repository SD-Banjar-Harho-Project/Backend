import { pool } from '../config/database.js';

class Permission {
  static async findAll() {
    const [rows] = await pool.execute(
      'SELECT * FROM permissions ORDER BY module, name'
    );
    return rows;
  }

  static async findById(id) {
    const [rows] = await pool.execute(
      'SELECT * FROM permissions WHERE id = ?',
      [id]
    );
    return rows[0];
  }

  static async findByName(name) {
    const [rows] = await pool.execute(
      'SELECT * FROM permissions WHERE name = ?',
      [name]
    );
    return rows[0];
  }

  static async findByModule(module) {
    const [rows] = await pool.execute(
      'SELECT * FROM permissions WHERE module = ? ORDER BY name',
      [module]
    );
    return rows;
  }

  static async create(permissionData) {
    const { name, display_name, description, module } = permissionData;

    const [result] = await pool.execute(
      'INSERT INTO permissions (name, display_name, description, module, created_at) VALUES (?, ?, ?, ?, NOW())',
      [name, display_name, description, module]
    );

    return this.findById(result.insertId);
  }

  static async update(id, permissionData) {
    const { name, display_name, description, module } = permissionData;

    await pool.execute(
      'UPDATE permissions SET name = ?, display_name = ?, description = ?, module = ? WHERE id = ?',
      [name, display_name, description, module, id]
    );

    return this.findById(id);
  }

  static async delete(id) {
    await pool.execute('DELETE FROM permissions WHERE id = ?', [id]);
  }

  static async getGroupedByModule() {
    const [rows] = await pool.execute(
      'SELECT * FROM permissions ORDER BY module, name'
    );

    const grouped = {};
    rows.forEach(permission => {
      const module = permission.module || 'general';
      if (!grouped[module]) {
        grouped[module] = [];
      }
      grouped[module].push(permission);
    });

    return grouped;
  }
}

export default Permission;
