import bcrypt from "bcryptjs";

const password = "admin123"; // Ganti password sesuai keinginan
const hash = await bcrypt.hash(password, 10);
console.log("Password:", password);
console.log("Hash:", hash);
console.log("\nCopy hash di atas, lalu jalankan query SQL ini:");
console.log(`
INSERT INTO users (username, email, password_hash, full_name, phone, role_id, is_active) 
VALUES (
  'admin',
  'admin@sdnbandarharjo.sch.id',
  '${hash}',
  'Administrator',
  '081234567890',
  1,
  1
);
`);
