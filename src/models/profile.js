import pool from "../config/database.js";

class Profile {
  static async get() {
    const [rows] = await pool.execute(
      "SELECT * FROM profiles ORDER BY id DESC LIMIT 1"
    );
    return rows[0];
  }

  static async createOrUpdate(data) {
    const {
      school_name,
      npsn,
      address,
      phone,
      email,
      website,
      logo,
      accreditation,
      principal_name,
      principal_photo,
    } = data;

    const existing = await this.get();

    if (existing) {
      await pool.execute(
        `UPDATE profiles 
         SET school_name = ?, npsn = ?, address = ?, phone = ?, 
             email = ?, website = ?, logo = ?, accreditation = ?, 
             principal_name = ?, principal_photo = ?
         WHERE id = ?`,
        [
          school_name,
          npsn,
          address,
          phone,
          email,
          website,
          logo,
          accreditation,
          principal_name,
          principal_photo,
          existing.id,
        ]
      );
    } else {
      await pool.execute(
        `INSERT INTO profiles 
         (school_name, npsn, address, phone, email, website, logo, 
          accreditation, principal_name, principal_photo) 
         VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`,
        [
          school_name,
          npsn,
          address,
          phone,
          email,
          website,
          logo,
          accreditation,
          principal_name,
          principal_photo,
        ]
      );
    }

    return this.get();
  }
}

export default Profile;
