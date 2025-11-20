import bcrypt from "bcryptjs";

const password = "superadmin123"; // Ganti password sesuai keinginan
const hash = await bcrypt.hash(password, 10);
console.log("Password:", password);
console.log("Hash:", hash);
console.log("\nCopy hash di atas, lalu jalankan query SQL ini:");
console.log(`
INSERT INTO users (username, email, password_hash, full_name, phone, role_id, is_active) 
VALUES (
  'superadmin',
  'superadmin@sdnbandarharjo.sch.id',
  '${hash}',
  'Super Administrator',
  '081234567890',
  1,
  1
);
`);
