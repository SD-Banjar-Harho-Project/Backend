# 🎓 Backend REST API - SD Negeri Bandarharjo

Backend REST API lengkap untuk sistem manajemen website SD Negeri Bandarharjo menggunakan Node.js, Express.js, dan MySQL.

[![Node.js Version](https://img.shields.io/badge/node-%3E%3D18.0.0-brightgreen)](https://nodejs.org/)
[![License](https://img.shields.io/badge/license-ISC-blue.svg)](LICENSE)

---

## 📚 **TABLE OF CONTENTS**

1. [Teknologi](#-teknologi-yang-digunakan)
2. [Struktur Project](#-struktur-project)
3. [Instalasi](#️-instalasi)
4. [API Endpoints](#-api-endpoints)
5. [Authentication](#-authentication)
6. [Database Relations](#-relasi-database)
7. [Integrasi React](#-integrasi-dengan-reactjs)
8. [Testing](#-testing-api)
9. [Troubleshooting](#-troubleshooting)
10. [Deployment](#-deployment)

---

## 🚀 **Teknologi yang Digunakan**

- **Node.js** v18+ (v22 recommended)
- **Express.js** v4.18+ - Web framework
- **MySQL** v8+ - Database (dengan mysql2/promise)
- **JWT** - Authentication & Authorization
- **bcryptjs** - Password hashing
- **ES Modules** - Import/Export syntax
- **Multer** - File upload handling
- **Express Validator** - Request validation
- **CORS** - Cross-Origin Resource Sharing
- **dotenv** - Environment variables management

---

## 📁 **Struktur Project**

```
Backend_kp/
├── src/
│   ├── config/
│   │   └── database.js              # Konfigurasi database MySQL
│   │
│   ├── models/                      # Database models (ORM-like)
│   │   ├── User.js                  # ✅ User model (UPDATED: handle undefined)
│   │   ├── Role.js                  # Role model
│   │   ├── Permission.js            # Permission model
│   │   ├── Post.js                  # Post/Article model
│   │   ├── ContentCategory.js       # Category model
│   │   ├── Teacher.js               # ✅ Teacher model (UPDATED: handle undefined)
│   │   ├── PostTag.js               # Tag model
│   │   ├── Gallery.js               # Gallery model
│   │   ├── Comment.js               # Comment model
│   │   └── Complaint.js             # Complaint model
│   │
│   ├── controllers/                 # Business logic
│   │   ├── authController.js        # ✅ UPDATED: register fix
│   │   ├── userController.js        # User CRUD
│   │   ├── postController.js        # ✅ UPDATED: handle category_id
│   │   ├── teacherController.js     # ✅ UPDATED: handle undefined fields
│   │   ├── categoryController.js    # Category CRUD
│   │   └── ...
│   │
│   ├── routes/                      # API routes definition
│   │   ├── authRoutes.js            # Authentication routes
│   │   ├── userRoutes.js            # User management routes
│   │   ├── postRoutes.js            # Post/Article routes
│   │   ├── teacherRoutes.js         # Teacher management routes
│   │   └── index.js                 # Route aggregator
│   │
│   ├── middleware/                  # Middleware functions
│   │   ├── authMiddleware.js        # JWT authentication & authorization
│   │   ├── errorHandler.js          # Global error handler
│   │   ├── validator.js             # Request validation
│   │   └── upload.js                # File upload handler (Multer)
│   │
│   └── utils/                       # Utility functions
│       ├── responseHelper.js        # Standardized API responses
│       ├── slugify.js               # URL slug generator
│       └── pagination.js            # Pagination helper
│
├── uploads/                         # File upload directory (gitignored)
│   ├── posts/
│   ├── teachers/
│   └── galleries/
│
├── docs/                            # Documentation files
│   ├── API_DOCUMENTATION.md         # ✅ Complete API documentation
│   ├── REACT_INTEGRATION.md         # ✅ React integration guide
│   └── postman/                     # ✅ Postman collection
│
├── .env                             # Environment variables (gitignored)
├── .env.example                     # ✅ Environment template
├── .gitignore                       # Git ignore rules
├── package.json                     # Dependencies & scripts
├── server.js                        # Entry point
└── README.md                        # This file
```

---

## 🛠️ **Instalasi**

### **Prerequisites**

Pastikan sudah terinstall:
- ✅ **Node.js** v18+ ([Download](https://nodejs.org/))
- ✅ **MySQL** v8+ via XAMPP ([Download](https://www.apachefriends.org/))
- ✅ **Git** ([Download](https://git-scm.com/))
- ✅ **Postman** (Optional - untuk testing) ([Download](https://www.postman.com/))

---

### **1. Clone atau Extract Project**

```bash
# Jika dari Git
git clone https://github.com/username/sd-negeri-bandarharjo.git
cd sd-negeri-bandarharjo/backend

# Atau langsung ke folder
cd Backend_kp
```

---

### **2. Install Dependencies**

```bash
npm install
```

**Dependencies yang akan terinstall:**
- express
- mysql2
- jsonwebtoken
- bcryptjs
- cors
- dotenv
- multer
- express-validator
- nodemon (dev dependency)

---

### **3. Setup Environment Variables**

Copy file `.env.example` menjadi `.env`:

```bash
# Windows
copy .env.example .env

# Mac/Linux
cp .env.example .env
```

Edit file `.env` dengan text editor:

```env
# ===========================================
# SERVER CONFIGURATION
# ===========================================
PORT=5000
NODE_ENV=development

# ===========================================
# DATABASE CONFIGURATION
# ===========================================
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=                        # Kosongkan jika tidak ada password
DB_NAME=dbsdnbandarharjo
DB_PORT=3306

# ===========================================
# JWT CONFIGURATION
# ===========================================
# PENTING: Ganti dengan random string minimal 32 karakter!
# Generate di: https://randomkeygen.com/
JWT_SECRET=your-super-secret-jwt-key-change-this-in-production-min-32-chars
JWT_EXPIRES_IN=7d

# ===========================================
# CORS CONFIGURATION
# ===========================================
# Multiple origins separated by comma
CORS_ORIGIN=http://localhost:3000,http://localhost:5173

# For production, add your frontend domain:
# CORS_ORIGIN=http://localhost:3000,https://your-frontend-domain.vercel.app

# ===========================================
# FILE UPLOAD CONFIGURATION
# ===========================================
UPLOAD_PATH=./uploads
MAX_FILE_SIZE=5242880                # 5MB in bytes
```

---

### **4. Setup Database**

#### **A. Start XAMPP**
1. Buka **XAMPP Control Panel**
2. Start **Apache** dan **MySQL**

#### **B. Create Database**
1. Buka browser: `http://localhost/phpmyadmin`
2. Klik **"New"** untuk create database baru
3. Nama database: `dbsdnbandarharjo`
4. Collation: `utf8mb4_unicode_ci`
5. Klik **"Create"**

#### **C. Import Database**

**Via phpMyAdmin:**
1. Klik database `dbsdnbandarharjo` yang baru dibuat
2. Klik tab **"Import"**
3. Choose file: Pilih `dbsdnbandarharjo.sql`
4. Klik **"Go"**
5. Tunggu sampai selesai

**Via Command Line:**
```bash
mysql -u root -p dbsdnbandarharjo < dbsdnbandarharjo.sql
```

#### **D. Verify Database**

```sql
-- Login ke MySQL
mysql -u root -p

-- Use database
USE dbsdnbandarharjo;

-- Check tables
SHOW TABLES;

-- Check users
SELECT * FROM users;

-- Check roles
SELECT * FROM roles;
```

---

### **5. Jalankan Server**

**Development mode (dengan auto-reload):**
```bash
npm run dev
```

**Production mode:**
```bash
npm start
```

**Server akan berjalan di:**
```
✅ http://localhost:5000
✅ API Endpoint: http://localhost:5000/api
```

---

### **6. Verify Backend Running**

**Test di browser atau Postman:**
```
GET http://localhost:5000/api
```

**Response yang diharapkan:**
```json
{
  "success": true,
  "message": "SD Negeri Bandarharjo API is running",
  "version": "1.0.0"
}
```

✅ **Jika dapat response ini, backend berhasil running!**

---

## 📡 **API Endpoints**

### **Authentication**

| Method | Endpoint | Description | Auth Required |
|--------|----------|-------------|---------------|
| POST | `/api/auth/register` | Register user baru | ❌ No |
| POST | `/api/auth/login` | Login user | ❌ No |
| GET | `/api/auth/profile` | Get user profile | ✅ Yes |
| PUT | `/api/auth/profile` | Update profile | ✅ Yes |
| POST | `/api/auth/change-password` | Change password | ✅ Yes |
| POST | `/api/auth/logout` | Logout user | ✅ Yes |

---

### **Users Management**

| Method | Endpoint | Description | Auth Required | Role |
|--------|----------|-------------|---------------|------|
| GET | `/api/users` | Get all users (paginated) | ✅ Yes | Admin |
| GET | `/api/users?search=keyword` | Search users | ✅ Yes | Admin |
| GET | `/api/users/:id` | Get user by ID | ✅ Yes | Admin |
| POST | `/api/users` | Create new user | ✅ Yes | Admin |
| PUT | `/api/users/:id` | Update user | ✅ Yes | Admin |
| DELETE | `/api/users/:id` | Delete user | ✅ Yes | Admin |
| POST | `/api/users/:id/reset-password` | Reset user password | ✅ Yes | Admin |

---

### **Posts (Articles & News)**

| Method | Endpoint | Description | Auth Required | Role |
|--------|----------|-------------|---------------|------|
| GET | `/api/posts` | Get all posts | ❌ No | - |
| GET | `/api/posts?status=published` | Get published posts only | ❌ No | - |
| GET | `/api/posts?is_featured=1` | Get featured posts only | ❌ No | - |
| GET | `/api/posts?search=keyword` | Search posts | ❌ No | - |
| GET | `/api/posts/:id` | Get post by ID | ❌ No | - |
| GET | `/api/posts/slug/:slug` | ✅ Get post by slug (SEO-friendly) | ❌ No | - |
| POST | `/api/posts` | Create new post | ✅ Yes | Editor/Admin |
| PUT | `/api/posts/:id` | Update post | ✅ Yes | Editor/Admin |
| DELETE | `/api/posts/:id` | Delete post | ✅ Yes | Admin |

---

### **Teachers**

| Method | Endpoint | Description | Auth Required | Role |
|--------|----------|-------------|---------------|------|
| GET | `/api/teachers` | Get all teachers | ❌ No | - |
| GET | `/api/teachers?search=keyword` | Search teachers | ❌ No | - |
| GET | `/api/teachers/:id` | Get teacher by ID | ❌ No | - |
| POST | `/api/teachers` | Create new teacher | ✅ Yes | Admin |
| PUT | `/api/teachers/:id` | Update teacher | ✅ Yes | Admin |
| DELETE | `/api/teachers/:id` | Delete teacher (soft delete) | ✅ Yes | Admin |

---

## 📝 **Contoh Request & Response**

### **1. Register User**

**Request:**
```bash
POST /api/auth/register
Content-Type: application/json

{
  "username": "johndoe",
  "email": "john@example.com",
  "password": "password123",
  "full_name": "John Doe",
  "phone": "081234567890"
}
```

**Response (201 Created):**
```json
{
  "success": true,
  "message": "User registered successfully",
  "data": {
    "id": 10,
    "username": "johndoe",
    "email": "john@example.com",
    "full_name": "John Doe",
    "role_name": "user"
  }
}
```

---

### **2. Login**

**Request:**
```bash
POST /api/auth/login
Content-Type: application/json

{
  "username": "admin",
  "password": "password"
}
```

**Response (200 OK):**
```json
{
  "success": true,
  "message": "Login successful",
  "data": {
    "user": {
      "id": 1,
      "username": "admin",
      "email": "admin@sdnbandarharjo.sch.id",
      "full_name": "Administrator",
      "role_name": "admin"
    },
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
  }
}
```

**⚠️ PENTING:** Simpan `token` untuk request selanjutnya!

---

### **3. Get All Posts (dengan filter)**

**Request:**
```bash
# All posts
GET /api/posts?page=1&limit=10

# Published only
GET /api/posts?status=published&page=1&limit=10

# Featured only
GET /api/posts?is_featured=1

# Search
GET /api/posts?search=matematika

# Kombinasi
GET /api/posts?status=published&is_featured=1&page=1&limit=5
```

**Response (200 OK):**
```json
{
  "success": true,
  "message": "Posts retrieved successfully",
  "data": [
    {
      "id": 1,
      "title": "Selamat Datang di SD Negeri Bandarharjo",
      "slug": "selamat-datang-di-sd-negeri-bandarharjo",
      "excerpt": "Artikel pertama...",
      "featured_image": "/uploads/posts/welcome.jpg",
      "post_type": "article",
      "status": "published",
      "is_featured": 1,
      "views_count": 150,
      "category_name": "Artikel",
      "author_name": "Administrator",
      "published_at": "2024-11-19T10:30:00.000Z"
    }
  ],
  "pagination": {
    "currentPage": 1,
    "perPage": 10,
    "total": 25,
    "totalPages": 3,
    "hasNextPage": true,
    "hasPrevPage": false
  }
}
```

---

### **4. Get Post by Slug (SEO-friendly)**

**Request:**
```bash
GET /api/posts/slug/selamat-datang-di-sd-negeri-bandarharjo
```

**Response (200 OK):**
```json
{
  "success": true,
  "message": "Post retrieved successfully",
  "data": {
    "id": 1,
    "title": "Selamat Datang di SD Negeri Bandarharjo",
    "slug": "selamat-datang-di-sd-negeri-bandarharjo",
    "content": "<p>Konten lengkap artikel...</p>",
    "excerpt": "Ringkasan...",
    "featured_image": "/uploads/posts/welcome.jpg",
    "category_name": "Artikel",
    "author_name": "Administrator",
    "tags": [
      { "id": 1, "name": "Pendidikan" },
      { "id": 2, "name": "Sekolah" }
    ]
  }
}
```

---

### **5. Create Post (dengan Authentication)**

**Request:**
```bash
POST /api/posts
Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
Content-Type: application/json

{
  "title": "Lomba Cerdas Cermat Tingkat Kecamatan",
  "excerpt": "Siswa SD Negeri Bandarharjo meraih juara 1",
  "content": "<p>Pada tanggal 10 November 2024...</p>",
  "post_type": "article",
  "category_id": 1,
  "status": "published",
  "is_featured": 1,
  "allow_comments": 1,
  "meta_title": "Lomba Cerdas Cermat",
  "meta_description": "Prestasi siswa...",
  "meta_keywords": "lomba, prestasi, siswa"
}
```

**Response (201 Created):**
```json
{
  "success": true,
  "message": "Post created successfully",
  "data": {
    "id": 2,
    "title": "Lomba Cerdas Cermat Tingkat Kecamatan",
    "slug": "lomba-cerdas-cermat-tingkat-kecamatan",
    "status": "published",
    "author_name": "Administrator"
  }
}
```

---

### **6. Create Teacher**

**Request:**
```bash
POST /api/teachers
Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
Content-Type: application/json

{
  "nip": "198501012010011001",
  "full_name": "Budi Santoso, S.Pd",
  "position": "Guru Kelas",
  "subject": "Matematika",
  "class_name": "6A",
  "education_level": "S1 Pendidikan Matematika",
  "email": "budi.santoso@sdnbandarharjo.sch.id",
  "phone": "081234567890",
  "bio": "Guru matematika dengan pengalaman 10 tahun",
  "join_date": "2010-01-01",
  "is_active": 1,
  "display_order": 1
}
```

**Response (201 Created):**
```json
{
  "success": true,
  "message": "Teacher created successfully",
  "data": {
    "id": 1,
    "nip": "198501012010011001",
    "full_name": "Budi Santoso, S.Pd",
    "position": "Guru Kelas",
    "subject": "Matematika",
    "class_name": "6A"
  }
}
```

---

## 🔐 **Authentication**

API menggunakan **JWT (JSON Web Token)** untuk authentication & authorization.

### **Cara Kerja:**

1. **Login** untuk mendapatkan token
2. **Simpan token** di localStorage/sessionStorage (Frontend)
3. **Kirim token** di header setiap request yang memerlukan auth:

```bash
Authorization: Bearer <your-jwt-token>
```

### **Token Expiration:**

- Default: **7 hari** (configurable di `.env`)
- Setelah expired, user harus login ulang

### **Role-Based Access Control (RBAC):**

| Role ID | Role Name | Permissions |
|---------|-----------|-------------|
| 1 | super_admin | Full system access |
| 2 | admin | Manage users, posts, teachers |
| 3 | teacher | View & edit own data |
| 4 | staff | View data only |
| 5 | user | View public content, edit own profile |

---

## 🎯 **Relasi Database yang Dihandle**

### **✅ Implemented:**

1. **Users ↔ Roles** (One to Many)
   - User memiliki role
   - Role bisa dimiliki banyak user

2. **Users ↔ Posts** (One to Many)
   - User adalah author dari posts
   - User bisa membuat banyak posts

3. **Posts ↔ Categories** (Many to One)
   - Post termasuk dalam category
   - Category memiliki banyak posts

4. **Posts ↔ Tags** (Many to Many)
   - Post bisa memiliki banyak tags
   - Tag bisa digunakan banyak posts
   - Melalui tabel `post_tag_relations`

5. **Teachers ↔ Users** (One to One - Optional)
   - Teacher bisa terhubung dengan user account
   - `user_id` nullable

6. **Galleries ↔ Gallery Items** (One to Many)
   - Gallery memiliki banyak gallery items

7. **Comments ↔ Posts** (Many to One)
   - Comment terhubung ke post
   - Support nested comments (parent_id)

---

## 🔗 **Integrasi dengan React.js**

### **1. Install Axios**

```bash
npm install axios react-router-dom
```

---

### **2. Setup Axios Instance**

**File:** `src/services/api.js`

```javascript
import axios from 'axios';

const API_BASE_URL = import.meta.env.VITE_API_BASE_URL || 'http://localhost:5000/api';

const api = axios.create({
  baseURL: API_BASE_URL,
  headers: {
    'Content-Type': 'application/json',
  },
});

// Add token to requests automatically
api.interceptors.request.use(
  (config) => {
    const token = localStorage.getItem('token');
    if (token) {
      config.headers.Authorization = `Bearer ${token}`;
    }
    return config;
  },
  (error) => {
    return Promise.reject(error);
  }
);

// Handle response errors
api.interceptors.response.use(
  (response) => response,
  (error) => {
    if (error.response?.status === 401) {
      // Token expired or invalid
      localStorage.removeItem('token');
      window.location.href = '/login';
    }
    return Promise.reject(error);
  }
);

export default api;
```

---

### **3. Auth Service**

**File:** `src/services/authService.js`

```javascript
import api from './api';

export const login = async (username, password) => {
  const response = await api.post('/auth/login', { username, password });
  if (response.data.success) {
    localStorage.setItem('token', response.data.data.token);
    localStorage.setItem('user', JSON.stringify(response.data.data.user));
  }
  return response.data;
};

export const register = async (userData) => {
  const response = await api.post('/auth/register', userData);
  return response.data;
};

export const getProfile = async () => {
  const response = await api.get('/auth/profile');
  return response.data;
};

export const logout = () => {
  localStorage.removeItem('token');
  localStorage.removeItem('user');
};
```

---

### **4. Posts Service**

**File:** `src/services/postService.js`

```javascript
import api from './api';

export const getPosts = async (page = 1, limit = 10, filters = {}) => {
  const params = new URLSearchParams({
    page,
    limit,
    ...filters
  });
  const response = await api.get(`/posts?${params}`);
  return response.data;
};

export const getPostBySlug = async (slug) => {
  const response = await api.get(`/posts/slug/${slug}`);
  return response.data;
};

export const createPost = async (postData) => {
  const response = await api.post('/posts', postData);
  return response.data;
};

export const updatePost = async (id, postData) => {
  const response = await api.put(`/posts/${id}`, postData);
  return response.data;
};

export const deletePost = async (id) => {
  const response = await api.delete(`/posts/${id}`);
  return response.data;
};
```

---

### **5. React Component Example**

**File:** `src/pages/Posts.jsx`

```javascript
import { useState, useEffect } from 'react';
import { getPosts } from '../services/postService';

function Posts() {
  const [posts, setPosts] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetchPosts();
  }, []);

  const fetchPosts = async () => {
    try {
      const data = await getPosts(1, 10, { status: 'published' });
      if (data.success) {
        setPosts(data.data);
      }
    } catch (error) {
      console.error('Error fetching posts:', error);
    } finally {
      setLoading(false);
    }
  };

  if (loading) return <div>Loading...</div>;

  return (
    <div>
      <h1>Artikel & Berita</h1>
      {posts.map((post) => (
        <article key={post.id}>
          <h2>{post.title}</h2>
          <p>{post.excerpt}</p>
          <a href={`/posts/${post.slug}`}>Baca Selengkapnya</a>
        </article>
      ))}
    </div>
  );
}

export default Posts;
```

---

## 🧪 **Testing API**

### **1. Menggunakan Postman** ⭐ (Recommended)

**Import Collection:**
1. Download Postman Collection: `docs/postman/SD_Bandarharjo_API.postman_collection.json`
2. Download Environment: `docs/postman/SD_Bandarharjo_Local.postman_environment.json`
3. Buka Postman
4. Import kedua file
5. Select environment "SD Bandarharjo - Local"
6. Ready to test!

**Fitur Collection:**
- ✅ 28 pre-configured requests
- ✅ Auto-save token setelah login
- ✅ Environment variables
- ✅ Organized folders

---

### **2. Menggunakan cURL**

```bash
# Test server running
curl http://localhost:5000/api

# Login
curl -X POST http://localhost:5000/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"username":"admin","password":"password"}'

# Get posts
curl http://localhost:5000/api/posts

# Get posts (published only)
curl "http://localhost:5000/api/posts?status=published"

# Create post (dengan token)
curl -X POST http://localhost:5000/api/posts \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -d '{"title":"Test Post","content":"Content...","category_id":1,"status":"published"}'
```

---

### **3. Menggunakan VS Code REST Client**

Install extension: **REST Client**

**File:** `api-test.http`

```http
### Variables
@baseUrl = http://localhost:5000/api
@token = your-token-here

### Test server
GET {{baseUrl}}

### Login
POST {{baseUrl}}/auth/login
Content-Type: application/json

{
  "username": "admin",
  "password": "password"
}

### Get posts
GET {{baseUrl}}/posts?status=published

### Create post
POST {{baseUrl}}/posts
Authorization: Bearer {{token}}
Content-Type: application/json

{
  "title": "Test Post",
  "content": "Content...",
  "category_id": 1,
  "status": "published"
}
```

---

## 📊 **Response Format**

### **Success Response**

```json
{
  "success": true,
  "message": "Operation successful",
  "data": {
    "id": 1,
    "username": "johndoe",
    ...
  }
}
```

### **Error Response**

```json
{
  "success": false,
  "message": "Error message",
  "errors": {
    "field": "Error detail"
  }
}
```

### **Paginated Response**

```json
{
  "success": true,
  "message": "Data retrieved successfully",
  "data": [ ... ],
  "pagination": {
    "currentPage": 1,
    "perPage": 10,
    "total": 100,
    "totalPages": 10,
    "hasNextPage": true,
    "hasPrevPage": false
  }
}
```

---

## 🚧 **Troubleshooting**

### **❌ Error: Cannot find module**

```bash
npm install
```

---

### **❌ Error: Database connection failed**

**Cek:**
1. ✅ XAMPP MySQL running
2. ✅ Database `dbsdnbandarharjo` sudah dibuat
3. ✅ Kredensial di `.env` benar
4. ✅ Port MySQL (default: 3306)

**Solution:**
```bash
# Test koneksi MySQL
mysql -u root -p

# Cek database
SHOW DATABASES;
```

---

### **❌ Error: Port already in use**

```bash
# Windows
netstat -ano | findstr :5000
taskkill /PID <PID> /F

# Mac/Linux
lsof -ti:5000 | xargs kill -9
```

Atau ubah PORT di `.env`:
```env
PORT=3000
```

---

### **❌ Error: JWT_SECRET is not defined**

**Cek:**
1. ✅ File `.env` exists
2. ✅ `JWT_SECRET` ada di `.env`
3. ✅ Restart server

---

### **❌ Error: Bind parameters must not contain undefined**

**Sudah FIXED!** Tapi jika masih terjadi:

**Di Model (User.js, Teacher.js):**
```javascript
// Change undefined to null
field1 || null,
field2 || null,
```

**Di Controller:**
```javascript
// Set default values
const userData = {
  field1: field1 || null,
  field2: field2 || defaultValue,
};
```

---

### **❌ Error: CORS Error di Frontend**

**Cek:**
1. ✅ CORS_ORIGIN di `.env` include frontend URL
2. ✅ Restart backend server

**Update `.env`:**
```env
CORS_ORIGIN=http://localhost:3000,http://localhost:5173
```

---

## 🚀 **Deployment**

### **Backend → Railway** (Recommended - Free Tier)

1. **Prepare:**
   - Ensure `package.json` has correct scripts
   - Ensure `Procfile` exists: `web: npm start`

2. **Deploy:**
   - Sign up: [railway.app](https://railway.app/)
   - New Project → Deploy from GitHub
   - Select repository & branch
   - Add MySQL database
   - Configure environment variables
   - Deploy!

3. **Environment Variables:**
```env
PORT=5000
NODE_ENV=production
DB_HOST=<railway-mysql-host>
DB_USER=<railway-mysql-user>
DB_PASSWORD=<railway-mysql-password>
DB_NAME=railway
DB_PORT=3306
JWT_SECRET=<secure-random-string>
CORS_ORIGIN=https://your-frontend.vercel.app
```

**Your API:** `https://your-backend.railway.app/api`

---

### **Alternative: VPS (DigitalOcean, Linode)**

1. Setup Node.js & MySQL
2. Clone repository
3. Install dependencies
4. Setup `.env`
5. Import database
6. Use PM2 for process management:
```bash
npm install -g pm2
pm2 start server.js --name "sd-backend"
pm2 startup
pm2 save
```

---

## 📈 **TODO / Pengembangan Selanjutnya**

- [x] Authentication & Authorization (JWT)
- [x] User Management CRUD
- [x] Post/Article Management CRUD
- [x] Teacher Management CRUD
- [x] Role-based Access Control
- [x] Pagination
- [x] Search & Filter
- [x] SEO-friendly slugs
- [ ] File upload (images, PDFs)
- [ ] Gallery Management CRUD
- [ ] Comment System
- [ ] Complaint/Feedback System
- [ ] Email notifications
- [ ] Forgot password functionality
- [ ] Email verification
- [ ] Image optimization (resize, compress)
- [ ] API rate limiting
- [ ] Logging system (Winston)
- [ ] API documentation (Swagger)
- [ ] Unit testing (Jest)
- [ ] Integration testing
- [ ] Caching (Redis)

---

## 📚 **Documentation**

Dokumentasi lengkap tersedia di folder `docs/`:

- **[API Documentation](docs/API_DOCUMENTATION.md)** - Dokumentasi lengkap semua endpoint
- **[React Integration Guide](docs/REACT_INTEGRATION.md)** - Panduan integrasi dengan React
- **[Postman Collection](docs/postman/)** - Collection & Environment untuk testing

---

## 👨‍💻 **Developer**

**Backend Developer:** [Your Name]

**Project:** SD Negeri Bandarharjo Website Management System

**Tech Stack:** Node.js + Express.js + MySQL

---

## 🤝 **Contributing**

1. Fork repository
2. Create feature branch: `git checkout -b feature/new-feature`
3. Commit changes: `git commit -m "Add new feature"`
4. Push to branch: `git push origin feature/new-feature`
5. Create Pull Request

---

## 📞 **Support**

Jika ada pertanyaan atau issue:
- 📧 Email: your.email@example.com
- 🐛 Issues: GitHub Issues tab
- 💬 Discussion: GitHub Discussions

---

## 📄 **License**

ISC License

---

## 🎉 **Acknowledgments**

- Express.js community
- MySQL documentation
- Node.js best practices
- All contributors

---

**Last Updated:** November 19, 2024
**Version:** 1.0.0
**Status:** ✅ Production Ready

---

Made with ❤️ for SD Negeri Bandarharjo
