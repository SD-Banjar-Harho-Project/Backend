# 🎓 Backend REST API - SD Negeri Bandarharjo

Backend REST API lengkap untuk sistem manajemen website SD Negeri Bandarharjo menggunakan Node.js, Express.js, dan MySQL.

[![Node.js Version](https://img.shields.io/badge/node-%3E%3D18.0.0-brightgreen)](https://nodejs.org/)
[![MySQL Version](https://img.shields.io/badge/mysql-8.0%2B-blue)](https://www.mysql.com/)
[![License](https://img.shields.io/badge/license-ISC-blue.svg)](LICENSE)

---

## 📚 TABLE OF CONTENTS

1. [Fitur Utama](#-fitur-utama)
2. [Teknologi](#-teknologi-yang-digunakan)
3. [Struktur Project](#-struktur-project)
4. [Prerequisites](#-prerequisites)
5. [Instalasi](#️-instalasi)
6. [Konfigurasi](#-konfigurasi)
7. [Menjalankan Server](#-menjalankan-server)
8. [Integrasi dengan Frontend](#-integrasi-dengan-frontend-react)
9. [API Endpoints](#-api-endpoints)
10. [Testing](#-testing-api)
11. [Deployment](#-deployment)
12. [Troubleshooting](#-troubleshooting)

---

## ✨ Fitur Utama

### 🔐 Authentication & Authorization
- ✅ JWT-based authentication
- ✅ Role-based access control (RBAC)
- ✅ Password hashing (bcrypt)
- ✅ Token expiration & refresh

### 👥 User Management
- ✅ CRUD operations untuk users
- ✅ Multiple roles (admin, teacher, staff)
- ✅ Profile management
- ✅ Password change

### 👨‍🏫 Teacher Management
- ✅ CRUD operations untuk data guru
- ✅ Teacher profiles
- ✅ Subject & class assignment

### 📷 Gallery Management
- ✅ Album galeri dengan items
- ✅ Photo & video support

---

## 🚀 Teknologi yang Digunakan

### Core
- **Node.js** v18+ - Runtime environment
- **Express.js** v4.21+ - Web framework
- **MySQL** v8+ - Database
- **mysql2** - MySQL client with promise support

### Security
- **jsonwebtoken** - JWT authentication
- **bcryptjs** - Password hashing
- **cors** - Cross-Origin Resource Sharing

### Utilities
- **dotenv** - Environment variables
- **express-validator** - Request validation
- **multer** - File upload handling

### Development
- **nodemon** - Auto-reload during development

---

## 📁 Struktur Project

```
Backend_kp/
├── src/
│   ├── config/
│   │   └── database.js              # Database configuration
│   │
│   ├── models/                      # Database models
│   │   ├── User.js                  # User model
│   │   ├── Post.js                  # Post model
│   │   ├── Teacher.js               # Teacher model
│   │   ├── Gallery.js               # Gallery model
│   │   ├── ...                      # Other models
│   │ 
│   ├── controllers/                 # Business logic
│   │   ├── authController.js        # Authentication
│   │   ├── userController.js        # User CRUD
│   │   ├── postController.js        # Post CRUD
│   │   ├── teacherController.js     # Teacher CRUD
│   │   └── ...                      # Other controllers
│   │
│   ├── routes/                      # API routes
│   │   ├── authRoutes.js           
│   │   ├── userRoutes.js           
│   │   ├── postRoutes.js           
│   │   ├── teacherRoutes.js        
│   │   └── index.js                 # Route aggregator
│   │   └── ...                      # other routes            
│   │
│   ├── middleware/                  # Middleware functions
│   │   ├── authMiddleware.js        # JWT auth & authorization
│   │   ├── errorHandler.js          # Global error handler
│   │   └── validator.js             # Request validation
│   │
│   └── utils/                       # Utility functions
│       ├── responseHelper.js        # Standardized responses
│       ├── slugify.js               # URL slug generator
│       └── pagination.js            # Pagination helper
│
├── uploads/                         # File upload directory
│
├── docs/                            # Documentation
│   ├── API_DOCUMENTATION.md         # ✅ API endpoints
│   └── REACT_INTEGRATION.md         # ✅ React integration guide
│
├── .env.example                     # Environment template
├── .gitignore                      
├── package.json                     # Dependencies
├── server.js                        # Entry point
└── README.md                        # This file
```

---

## 📋 Prerequisites

Pastikan sudah terinstall:

### 1. **Node.js** v18 atau lebih tinggi
Download: https://nodejs.org/

Cek versi:
```bash
node --version
npm --version
```

### 2. **MySQL** v8 atau lebih tinggi
Download XAMPP: https://www.apachefriends.org/

### 3. **Git** (Optional)
Download: https://git-scm.com/

### 4. **Postman** (Untuk testing API)
Download: https://www.postman.com/

---

## 🛠️ Instalasi

### Step 1: Clone atau Download Project

```bash
# Via Git
git clone <repository-url>
cd Backend_kp

# Atau extract ZIP dan masuk ke folder
cd Backend_kp
```

### Step 2: Install Dependencies

```bash
npm install
```

Dependencies yang akan terinstall:
- express
- mysql2
- jsonwebtoken
- bcryptjs
- cors
- dotenv
- express-validator
- nodemon (dev)

### Step 3: Setup Database

#### A. Start XAMPP
1. Buka **XAMPP Control Panel**
2. Start **Apache** dan **MySQL**
3. Pastikan MySQL berjalan di port **3306**

#### B. Create Database
1. Buka browser: `http://localhost/phpmyadmin`
2. Klik **"New"** untuk create database
3. Nama database: `kp_diskominfo`
4. Collation: `utf8mb4_unicode_ci`
5. Klik **"Create"**

#### C. Import Database Schema
1. Klik database `kp_sidkominfo`
2. Klik tab **"Import"**
3. Choose file: `kp_diskominfo.sql`
4. Klik **"Go"**
5. Tunggu sampai selesai import

**Via Command Line:**
```bash
mysql -u root -p dbsdnbandarharjo < dbsdnbandarharjo.sql
```

#### D. Verify Database
```sql
-- Login MySQL
mysql -u root -p

-- Gunakan database
USE dbsdnbandarharjo;

-- Lihat semua tabel
SHOW TABLES;

-- Cek data users
SELECT * FROM users;

-- Cek data roles
SELECT * FROM roles;
```

---

## ⚙️ Konfigurasi

### Step 1: Copy Environment File

```bash
# Windows
copy .env.example .env

# Mac/Linux
cp .env.example .env
```

### Step 2: Edit .env File

Buka `.env` dengan text editor dan sesuaikan:

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
DB_PASSWORD=
DB_NAME=kp_diskominfo
DB_PORT=3306

# ===========================================
# JWT CONFIGURATION
# ===========================================
JWT_SECRET=your-super-secret-jwt-key-change-this-min-32-chars-long-for-security
JWT_EXPIRES_IN=7d

# ===========================================
# CORS CONFIGURATION
# ===========================================
CORS_ORIGIN=http://localhost:5173

# ===========================================
# FILE UPLOAD CONFIGURATION
# ===========================================
UPLOAD_PATH=./uploads
MAX_FILE_SIZE=5242880
```

**⚠️ PENTING:**
- `JWT_SECRET` harus di-generate dengan random string yang kuat
- Jangan commit file `.env` ke Git
- Untuk production, gunakan nilai yang berbeda

---

## 🚀 Menjalankan Server

### Development Mode (dengan auto-reload)

```bash
npm run dev
```

### Production Mode

```bash
npm start
```

### Output yang diharapkan:

```
==================================================
🚀 Server Information
==================================================
Environment: development
Server running on port: 5000
API endpoint: http://localhost:5000/api
==================================================
✅ Database connected successfully
```

### Test Backend Running

Buka browser atau Postman:
```
GET http://localhost:5000/api
```

Response yang diharapkan:
```json
{
  "success": true,
  "message": "SD Negeri Bandarharjo API is running",
  "version": "1.0.0"
}
```

✅ **Jika dapat response ini, backend berhasil running!**

---

## 🔗 Integrasi dengan Frontend (React)

### Overview

Backend ini dirancang untuk diintegrasikan dengan frontend React.js. Berikut adalah langkah-langkah detail untuk menghubungkan backend dengan frontend.

### 📦 Setup Frontend React

#### 1. Create React App

```bash
# Menggunakan Vite (Recommended)
npm create vite@latest sd-bandarharjo-frontend -- --template react
cd sd-bandarharjo-frontend
npm install

# Atau menggunakan Create React App
npx create-react-app sd-bandarharjo-frontend
cd sd-bandarharjo-frontend
```

#### 2. Install Dependencies

```bash
# Core dependencies
npm install axios react-router-dom

# State management (optional)
npm install zustand

# UI Toast notifications
npm install react-toastify

# Form handling
npm install react-hook-form

# Date formatting
npm install date-fns
```

#### 3. Setup Environment Variables

Buat file `.env` di root project frontend:

```env
# Development
VITE_API_BASE_URL=http://localhost:5000/api

# Production (ganti dengan URL backend production)
# VITE_API_BASE_URL=https://your-backend.railway.app/api
```

### 🌐 Setup Axios Instance

Buat file `src/services/api.js`:

```javascript
import axios from 'axios';

const API_BASE_URL = import.meta.env.VITE_API_BASE_URL || 'http://localhost:5000/api';

// Create axios instance
const api = axios.create({
  baseURL: API_BASE_URL,
  headers: {
    'Content-Type': 'application/json',
  },
  timeout: 10000,
});

// Request interceptor - Add token to requests
api.interceptors.request.use(
  (config) => {
    const token = localStorage.getItem('token');
    if (token) {
      config.headers.Authorization = `Bearer ${token}`;
    }
    return config;
  },
  (error) => Promise.reject(error)
);

// Response interceptor - Handle errors
api.interceptors.response.use(
  (response) => response.data,
  (error) => {
    if (error.response?.status === 401) {
      // Token expired - redirect to login
      localStorage.removeItem('token');
      window.location.href = '/login';
    }
    return Promise.reject(error);
  }
);

export default api;
```

### 🔐 Authentication Service

Buat file `src/services/authService.js`:

```javascript
import api from './api';

export const login = async (username, password) => {
  const response = await api.post('/auth/login', { username, password });
  if (response.success) {
    localStorage.setItem('token', response.data.token);
    localStorage.setItem('user', JSON.stringify(response.data.user));
  }
  return response;
};

export const logout = () => {
  localStorage.removeItem('token');
  localStorage.removeItem('user');
  window.location.href = '/login';
};

export const isAuthenticated = () => {
  return !!localStorage.getItem('token');
};

export const getCurrentUser = () => {
  const userStr = localStorage.getItem('user');
  return userStr ? JSON.parse(userStr) : null;
};
```

### 📡 Example API Service (Posts)

Buat file `src/services/postService.js`:

```javascript
import api from './api';

export const getPosts = async (page = 1, limit = 10, filters = {}) => {
  const params = new URLSearchParams({ page, limit, ...filters });
  return await api.get(`/posts?${params}`);
};

export const getPostBySlug = async (slug) => {
  return await api.get(`/posts/slug/${slug}`);
};

export const createPost = async (postData) => {
  return await api.post('/posts', postData);
};

export const updatePost = async (id, postData) => {
  return await api.put(`/posts/${id}`, postData);
};

export const deletePost = async (id) => {
  return await api.delete(`/posts/${id}`);
};
```

## 📡 API Endpoints

### Base URL
```
http://localhost:5000/api
```

### Authentication
```
POST   /auth/register      - Register user baru
POST   /auth/login         - Login
GET    /auth/profile       - Get profile
PUT    /auth/profile       - Update profile
POST   /auth/change-password - Change password
```

### Users
```
GET    /users              - Get all users (Admin)
GET    /users/:id          - Get user by ID (Admin)
POST   /users              - Create user (Admin)
PUT    /users/:id          - Update user (Admin)
DELETE /users/:id          - Delete user (Admin)
```

### Posts
```
GET    /posts              - Get all posts
GET    /posts/:id          - Get post by ID
GET    /posts/slug/:slug   - Get post by slug
POST   /posts              - Create post (Editor/Admin)
PUT    /posts/:id          - Update post (Editor/Admin)
DELETE /posts/:id          - Delete post (Admin)
```

### Teachers
```
GET    /teachers           - Get all teachers
GET    /teachers/:id       - Get teacher by ID
POST   /teachers           - Create teacher (Admin)
PUT    /teachers/:id       - Update teacher (Admin)
DELETE /teachers/:id       - Delete teacher (Admin)
```

### Galleries
```
GET    /galleries          - Get all galleries
GET    /galleries/:id      - Get gallery by ID
POST   /galleries          - Create gallery (Admin)
PUT    /galleries/:id      - Update gallery (Admin)
DELETE /galleries/:id      - Delete gallery (Admin)
```

```

Dan masih banyak lagi...

**Dokumentasi lengkap API:** [📖 API_DOCUMENTATION.md](docs/API_DOCUMENTATION.md)

---

## 🧪 Testing API

### 1. Menggunakan Postman (Recommended)

**Import Collection:**
1. Download Postman Collection dari folder `docs/postman/`
2. Import ke Postman
3. Set environment "SD Bandarharjo - Local"
4. Ready to test!

**Quick Test:**
```
GET http://localhost:5000/api
```

### 2. Menggunakan cURL

```bash
# Test server
curl http://localhost:5000/api

# Login
curl -X POST http://localhost:5000/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"username":"admin","password":"password"}'

# Get posts
curl http://localhost:5000/api/posts
```

### 3. Menggunakan Browser

Buka browser dan akses:
- http://localhost:5000/api
- http://localhost:5000/api/posts
- http://localhost:5000/api/teachers

---

## 🚀 Deployment

### Backend → Railway (Free Tier)

1. **Signup:** https://railway.app/
2. **New Project** → Deploy from GitHub
3. **Add MySQL Database**
4. **Configure Environment Variables:**
   ```env
   PORT=5000
   NODE_ENV=production
   DB_HOST=<railway-mysql-host>
   DB_USER=<railway-mysql-user>
   DB_PASSWORD=<railway-mysql-password>
   DB_NAME=railway
   JWT_SECRET=<your-secure-secret>
   CORS_ORIGIN=https://your-frontend.vercel.app
   ```
5. **Import Database** via MySQL CLI
6. **Deploy!**

### Frontend → Vercel

1. **Build React app:**
   ```bash
   npm run build
   ```
2. **Deploy to Vercel:**
   ```bash
   npm install -g vercel
   vercel
   ```
3. **Set Environment Variable:**
   ```env
   VITE_API_BASE_URL=https://your-backend.railway.app/api
   ```

---

## 🔧 Troubleshooting

### ❌ Error: Cannot find module

**Solution:**
```bash
npm install
```

### ❌ Error: Database connection failed

**Check:**
1. ✅ XAMPP MySQL running
2. ✅ Database created
3. ✅ Credentials in `.env` correct
4. ✅ MySQL port 3306

**Test connection:**
```bash
mysql -u root -p
USE kp_diskominfo;
```

### ❌ Error: Port already in use

**Solution:**
```bash
# Windows
netstat -ano | findstr :5000
taskkill /PID <PID> /F

# Mac/Linux
lsof -ti:5000 | xargs kill -9
```

### ❌ Error: CORS Error

**Solution:**
Update `CORS_ORIGIN` in `.env`:
```env
CORS_ORIGIN=http://localhost:3000,http://localhost:5173
```

### ❌ Error: JWT_SECRET not defined

**Solution:**
1. Check `.env` file exists
2. Check `JWT_SECRET` is set
3. Restart server


## 🤝 Contributing

1. Fork repository
2. Create feature branch: `git checkout -b feature/new-feature`
3. Commit changes: `git commit -m "Add new feature"`
4. Push to branch: `git push origin feature/new-feature`
5. Create Pull Request

---

## 📄 License

ISC License

---

## 👨‍💻 Developer

**Project:** SD Negeri Bandarharjo Website Management System

**Tech Stack:** 
- Backend: Node.js + Express.js + MySQL
- Frontend: React.js (separate repository)

---

## 🎉 Acknowledgments

- Express.js community
- MySQL documentation
- Node.js best practices
- React.js community
- All contributors

---

**Last Updated:** November 20, 2025
**Version:** 1.0.0
**Status:** ✅ Production Ready

---

