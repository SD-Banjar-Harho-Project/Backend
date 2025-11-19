# Backend REST API - SD Negeri Bandarharjo

Backend REST API lengkap untuk sistem manajemen website SD Negeri Bandarharjo menggunakan Node.js, Express.js, dan MySQL.

## 🚀 Teknologi yang Digunakan

- **Node.js** v22
- **Express.js** - Web framework
- **MySQL** - Database (dengan mysql2/promise)
- **JWT** - Authentication
- **bcryptjs** - Password hashing
- **ES Modules** - Import/Export syntax
- **Multer** - File upload
- **Express Validator** - Request validation

## 📁 Struktur Project

```
Backend_kp/
├── src/
│   ├── config/
│   │   └── database.js          # Konfigurasi database
│   ├── models/                  # Database models
│   │   ├── User.js
│   │   ├── Role.js
│   │   ├── Permission.js
│   │   ├── Post.js
│   │   ├── ContentCategory.js
│   │   ├── Teacher.js
│   │   └── ...
│   ├── controllers/             # Business logic
│   │   ├── authController.js
│   │   ├── userController.js
│   │   ├── postController.js
│   │   ├── teacherController.js
│   │   └── ...
│   ├── routes/                  # API routes
│   │   ├── authRoutes.js
│   │   ├── userRoutes.js
│   │   ├── postRoutes.js
│   │   ├── teacherRoutes.js
│   │   └── index.js
│   ├── middlewares/             # Middleware functions
│   │   ├── authMiddleware.js
│   │   ├── errorHandler.js
│   │   ├── validator.js
│   │   └── upload.js
│   └── utils/                   # Utility functions
│       ├── responseHelper.js
│       ├── slugify.js
│       └── pagination.js
├── .env.example
├── .gitignore
├── package.json
└── server.js                    # Entry point
```

## 🛠️ Instalasi

### 1. Clone atau Extract Project

```bash
cd Backend_kp
```

### 2. Install Dependencies

```bash
npm install
```

### 3. Setup Environment

Copy file `.env.example` menjadi `.env`:

```bash
cp .env.example .env
```

Edit file `.env` sesuai konfigurasi Anda:

```env
PORT=5000
NODE_ENV=development

DB_HOST=localhost
DB_PORT=3306
DB_USER=root
DB_PASSWORD=your_password
DB_NAME=dbsdnbandarharjo

JWT_SECRET=your-super-secret-jwt-key-change-this
JWT_EXPIRES_IN=7d

CORS_ORIGIN=http://localhost:3000
```

### 4. Import Database

Import file `dbsdnbandarharjo.sql` ke MySQL:

```bash
mysql -u root -p dbsdnbandarharjo < dbsdnbandarharjo.sql
```

Atau melalui phpMyAdmin:
1. Buat database `dbsdnbandarharjo`
2. Import file SQL

### 5. Jalankan Server

**Development mode (dengan auto-reload):**
```bash
npm run dev
```

**Production mode:**
```bash
npm start
```

Server akan berjalan di: `http://localhost:5000`

## 📡 API Endpoints

### Authentication

| Method | Endpoint | Description | Auth Required |
|--------|----------|-------------|---------------|
| POST | `/api/auth/register` | Register user baru | No |
| POST | `/api/auth/login` | Login user | No |
| GET | `/api/auth/profile` | Get user profile | Yes |
| PUT | `/api/auth/profile` | Update profile | Yes |
| POST | `/api/auth/change-password` | Change password | Yes |
| POST | `/api/auth/logout` | Logout user | Yes |

### Users

| Method | Endpoint | Description | Auth Required | Role |
|--------|----------|-------------|---------------|------|
| GET | `/api/users` | Get all users | Yes | Admin |
| GET | `/api/users/:id` | Get user by ID | Yes | Admin |
| POST | `/api/users` | Create new user | Yes | Admin |
| PUT | `/api/users/:id` | Update user | Yes | Admin |
| DELETE | `/api/users/:id` | Delete user | Yes | Admin |
| POST | `/api/users/:id/reset-password` | Reset password | Yes | Admin |

### Posts

| Method | Endpoint | Description | Auth Required | Role |
|--------|----------|-------------|---------------|------|
| GET | `/api/posts` | Get all posts | No | - |
| GET | `/api/posts/:id` | Get post by ID | No | - |
| GET | `/api/posts/slug/:slug` | Get post by slug | No | - |
| POST | `/api/posts` | Create new post | Yes | Editor/Admin |
| PUT | `/api/posts/:id` | Update post | Yes | Editor/Admin |
| DELETE | `/api/posts/:id` | Delete post | Yes | Admin |

### Teachers

| Method | Endpoint | Description | Auth Required | Role |
|--------|----------|-------------|---------------|------|
| GET | `/api/teachers` | Get all teachers | No | - |
| GET | `/api/teachers/:id` | Get teacher by ID | No | - |
| POST | `/api/teachers` | Create new teacher | Yes | Admin |
| PUT | `/api/teachers/:id` | Update teacher | Yes | Admin |
| DELETE | `/api/teachers/:id` | Delete teacher | Yes | Admin |

## 📝 Contoh Request

### 1. Register

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

### 2. Login

```bash
POST /api/auth/login
Content-Type: application/json

{
  "username": "johndoe",
  "password": "password123"
}
```

**Response:**
```json
{
  "success": true,
  "message": "Login successful",
  "data": {
    "user": {
      "id": 1,
      "username": "johndoe",
      "email": "john@example.com",
      "full_name": "John Doe"
    },
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
  }
}
```

### 3. Get All Posts (dengan pagination)

```bash
GET /api/posts?page=1&limit=10&status=published
```

### 4. Create Post (dengan Authentication)

```bash
POST /api/posts
Authorization: Bearer your-jwt-token
Content-Type: application/json

{
  "title": "Judul Post",
  "content": "Konten post...",
  "excerpt": "Ringkasan singkat",
  "post_type": "article",
  "category_id": 1,
  "status": "published",
  "is_featured": 1,
  "tag_ids": [1, 2, 3]
}
```

## 🔐 Authentication

API menggunakan JWT (JSON Web Token) untuk authentication. 

Untuk mengakses endpoint yang memerlukan authentication:

1. Login terlebih dahulu untuk mendapatkan token
2. Sertakan token di header setiap request:

```bash
Authorization: Bearer your-jwt-token
```

## 🎯 Relasi Database yang Dihandle

✅ **Users - Roles** (One to Many)
- User memiliki role
- Role bisa dimiliki banyak user

✅ **Users - Posts** (One to Many)
- User adalah author dari posts
- User bisa membuat banyak posts

✅ **Posts - Categories** (Many to One)
- Post termasuk dalam category
- Category memiliki banyak posts

✅ **Posts - Tags** (Many to Many)
- Post bisa memiliki banyak tags
- Tag bisa digunakan banyak posts
- Melalui tabel `post_tag_relations`

✅ **Teachers - Users** (One to One)
- Teacher terhubung dengan user account

✅ **Galleries - Gallery Items** (One to Many)
- Gallery memiliki banyak gallery items

✅ **Comments - Posts** (Many to One)
- Comment terhubung ke post
- Support nested comments (self-referencing)

## 🔌 Integrasi dengan React.js

### Install Axios di React

```bash
npm install axios
```

### Setup Axios Instance

```javascript
// src/api/axios.js
import axios from 'axios';

const api = axios.create({
  baseURL: 'http://localhost:5000/api',
  headers: {
    'Content-Type': 'application/json'
  }
});

// Add token to requests
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

export default api;
```

### Contoh Penggunaan di React

```javascript
// src/services/authService.js
import api from '../api/axios';

export const login = async (username, password) => {
  const response = await api.post('/auth/login', { username, password });
  if (response.data.data.token) {
    localStorage.setItem('token', response.data.data.token);
  }
  return response.data;
};

export const getPosts = async (page = 1, limit = 10) => {
  const response = await api.get(`/posts?page=${page}&limit=${limit}`);
  return response.data;
};

export const createPost = async (postData) => {
  const response = await api.post('/posts', postData);
  return response.data;
};
```

## 🧪 Testing API

### Menggunakan Thunder Client / Postman

1. Import collection (bisa dibuat manual)
2. Set environment variable:
   - `base_url`: http://localhost:5000/api
   - `token`: (akan diisi setelah login)

### Menggunakan cURL

```bash
# Login
curl -X POST http://localhost:5000/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"username":"admin","password":"password123"}'

# Get Posts
curl http://localhost:5000/api/posts

# Create Post (dengan token)
curl -X POST http://localhost:5000/api/posts \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -d '{"title":"Test Post","content":"Content..."}'
```

## 📊 Response Format

### Success Response

```json
{
  "success": true,
  "message": "Success message",
  "data": { ... }
}
```

### Error Response

```json
{
  "success": false,
  "message": "Error message",
  "errors": [ ... ]
}
```

### Paginated Response

```json
{
  "success": true,
  "message": "Success message",
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

## 🚧 Troubleshooting

### Error: Cannot find module

```bash
npm install
```

### Error: Database connection failed

- Pastikan MySQL sudah running
- Cek kredensial di file `.env`
- Cek nama database sudah dibuat

### Error: Port already in use

Ubah PORT di file `.env` atau kill process yang menggunakan port:

```bash
# Windows
netstat -ano | findstr :5000
taskkill /PID <PID> /F

# Linux/Mac
lsof -ti:5000 | xargs kill
```

## 📈 TODO / Pengembangan Selanjutnya

- [ ] Implementasi semua model (Galleries, Comments, Complaints, dll)
- [ ] Email verification
- [ ] Forgot password functionality
- [ ] File upload optimization
- [ ] Image processing (resize, compress)
- [ ] Logging system
- [ ] API documentation (Swagger)
- [ ] Unit testing
- [ ] Rate limiting per user
- [ ] Caching (Redis)

## 👨‍💻 Developer

Backend API ini dibuat untuk SD Negeri Bandarharjo.

## 📄 License

ISC
