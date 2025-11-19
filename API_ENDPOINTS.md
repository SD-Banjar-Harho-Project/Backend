# 📡 API ENDPOINTS DOCUMENTATION

## Base URL
```
http://localhost:5000/api
```

## Authentication Header
Untuk endpoint yang memerlukan authentication, sertakan token di header:
```
Authorization: Bearer <your-jwt-token>
```

---

## 🔐 AUTHENTICATION ENDPOINTS

### 1. Register User Baru
**POST** `/auth/register`

**Body:**
```json
{
  "username": "johndoe",
  "email": "john@example.com",
  "password": "password123",
  "full_name": "John Doe",
  "phone": "081234567890",
  "role_id": 3  // optional, default: 3 (user)
}
```

**Success Response (201):**
```json
{
  "success": true,
  "message": "User registered successfully",
  "data": {
    "id": 1,
    "username": "johndoe",
    "email": "john@example.com",
    "full_name": "John Doe",
    "role_name": "user"
  }
}
```

---

### 2. Login
**POST** `/auth/login`

**Body:**
```json
{
  "username": "johndoe",
  "password": "password123"
}
```

**Success Response (200):**
```json
{
  "success": true,
  "message": "Login successful",
  "data": {
    "user": {
      "id": 1,
      "username": "johndoe",
      "email": "john@example.com",
      "full_name": "John Doe",
      "role_name": "admin"
    },
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
  }
}
```

---

### 3. Get Profile
**GET** `/auth/profile`

**Headers:** `Authorization: Bearer <token>`

**Success Response (200):**
```json
{
  "success": true,
  "message": "Profile retrieved successfully",
  "data": {
    "id": 1,
    "username": "johndoe",
    "email": "john@example.com",
    "full_name": "John Doe",
    "phone": "081234567890",
    "role_name": "admin"
  }
}
```

---

### 4. Update Profile
**PUT** `/auth/profile`

**Headers:** `Authorization: Bearer <token>`

**Body:**
```json
{
  "email": "newemail@example.com",
  "full_name": "John Doe Updated",
  "phone": "081234567890",
  "avatar": "/uploads/avatar.jpg"
}
```

**Success Response (200):**
```json
{
  "success": true,
  "message": "Profile updated successfully",
  "data": { ... }
}
```

---

### 5. Change Password
**POST** `/auth/change-password`

**Headers:** `Authorization: Bearer <token>`

**Body:**
```json
{
  "old_password": "oldpassword123",
  "new_password": "newpassword123"
}
```

**Success Response (200):**
```json
{
  "success": true,
  "message": "Password changed successfully",
  "data": null
}
```

---

## 👥 USER MANAGEMENT ENDPOINTS

### 1. Get All Users
**GET** `/users?page=1&limit=10&search=john`

**Headers:** `Authorization: Bearer <token>` (Admin only)

**Query Parameters:**
- `page` (optional): Page number, default: 1
- `limit` (optional): Items per page, default: 10
- `search` (optional): Search by username, email, or name

**Success Response (200):**
```json
{
  "success": true,
  "message": "Users retrieved successfully",
  "data": [
    {
      "id": 1,
      "username": "johndoe",
      "email": "john@example.com",
      "full_name": "John Doe",
      "role_name": "admin"
    }
  ],
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

### 2. Get User by ID
**GET** `/users/:id`

**Headers:** `Authorization: Bearer <token>` (Admin only)

**Success Response (200):**
```json
{
  "success": true,
  "message": "User retrieved successfully",
  "data": {
    "id": 1,
    "username": "johndoe",
    "email": "john@example.com",
    "full_name": "John Doe",
    "role_name": "admin"
  }
}
```

---

### 3. Create User
**POST** `/users`

**Headers:** `Authorization: Bearer <token>` (Admin only)

**Body:**
```json
{
  "username": "newuser",
  "email": "newuser@example.com",
  "password": "password123",
  "full_name": "New User",
  "phone": "081234567890",
  "role_id": 2,
  "is_active": 1
}
```

**Success Response (201):**
```json
{
  "success": true,
  "message": "User created successfully",
  "data": { ... }
}
```

---

### 4. Update User
**PUT** `/users/:id`

**Headers:** `Authorization: Bearer <token>` (Admin only)

**Body:**
```json
{
  "email": "updated@example.com",
  "full_name": "Updated Name",
  "phone": "081234567890",
  "role_id": 2,
  "is_active": 1
}
```

---

### 5. Delete User
**DELETE** `/users/:id`

**Headers:** `Authorization: Bearer <token>` (Admin only)

**Success Response (200):**
```json
{
  "success": true,
  "message": "User deleted successfully",
  "data": null
}
```

---

## 📝 POSTS ENDPOINTS

### 1. Get All Posts
**GET** `/posts?page=1&limit=10&status=published&category_id=1&is_featured=1`

**Query Parameters:**
- `page` (optional): Page number
- `limit` (optional): Items per page
- `status` (optional): draft, published, archived
- `post_type` (optional): article, news, announcement
- `category_id` (optional): Filter by category
- `is_featured` (optional): 0 or 1

**Success Response (200):**
```json
{
  "success": true,
  "message": "Posts retrieved successfully",
  "data": [
    {
      "id": 1,
      "title": "Judul Post",
      "slug": "judul-post",
      "excerpt": "Ringkasan...",
      "content": "Konten lengkap...",
      "featured_image": "/uploads/image.jpg",
      "category_name": "Berita",
      "author_name": "John Doe",
      "views_count": 150,
      "comments_count": 5,
      "created_at": "2024-01-01 10:00:00"
    }
  ],
  "pagination": { ... }
}
```

---

### 2. Get Post by ID
**GET** `/posts/:id`

**Success Response (200):**
```json
{
  "success": true,
  "message": "Post retrieved successfully",
  "data": {
    "id": 1,
    "title": "Judul Post",
    "slug": "judul-post",
    "content": "Konten lengkap...",
    "category_name": "Berita",
    "author_name": "John Doe",
    "tags": [
      { "id": 1, "name": "pendidikan", "slug": "pendidikan" },
      { "id": 2, "name": "sekolah", "slug": "sekolah" }
    ]
  }
}
```

---

### 3. Get Post by Slug
**GET** `/posts/slug/:slug`

**Success Response (200):**
Same as Get Post by ID
(Note: This endpoint also increments views_count)

---

### 4. Create Post
**POST** `/posts`

**Headers:** `Authorization: Bearer <token>` (Editor/Admin)

**Body:**
```json
{
  "title": "Judul Post Baru",
  "excerpt": "Ringkasan singkat",
  "content": "Konten lengkap post...",
  "featured_image": "/uploads/image.jpg",
  "post_type": "article",
  "category_id": 1,
  "status": "published",
  "meta_title": "SEO Title",
  "meta_description": "SEO Description",
  "meta_keywords": "keyword1, keyword2",
  "is_featured": 1,
  "allow_comments": 1,
  "tag_ids": [1, 2, 3]
}
```

**Success Response (201):**
```json
{
  "success": true,
  "message": "Post created successfully",
  "data": { ... }
}
```

---

### 5. Update Post
**PUT** `/posts/:id`

**Headers:** `Authorization: Bearer <token>` (Editor/Admin)

**Body:** Same as Create Post

---

### 6. Delete Post
**DELETE** `/posts/:id`

**Headers:** `Authorization: Bearer <token>` (Admin only)

---

## 👨‍🏫 TEACHERS ENDPOINTS

### 1. Get All Teachers
**GET** `/teachers?page=1&limit=10`

**Success Response (200):**
```json
{
  "success": true,
  "message": "Teachers retrieved successfully",
  "data": [
    {
      "id": 1,
      "nip": "123456789",
      "full_name": "Budi Santoso, S.Pd",
      "position": "Guru Kelas",
      "subject": "Matematika",
      "class_name": "6A",
      "education_level": "S1 Pendidikan",
      "email": "budi@example.com",
      "phone": "081234567890",
      "photo": "/uploads/teachers/photo.jpg",
      "is_active": 1
    }
  ],
  "pagination": { ... }
}
```

---

### 2. Get Teacher by ID
**GET** `/teachers/:id`

---

### 3. Create Teacher
**POST** `/teachers`

**Headers:** `Authorization: Bearer <token>` (Admin only)

**Body:**
```json
{
  "user_id": 5,
  "nip": "123456789",
  "full_name": "Budi Santoso, S.Pd",
  "photo": "/uploads/teachers/photo.jpg",
  "position": "Guru Kelas",
  "subject": "Matematika",
  "class_name": "6A",
  "education_level": "S1 Pendidikan",
  "email": "budi@example.com",
  "phone": "081234567890",
  "bio": "Pengalaman mengajar 10 tahun",
  "join_date": "2015-01-01",
  "is_active": 1,
  "display_order": 1
}
```

---

### 4. Update Teacher
**PUT** `/teachers/:id`

**Headers:** `Authorization: Bearer <token>` (Admin only)

---

### 5. Delete Teacher
**DELETE** `/teachers/:id`

**Headers:** `Authorization: Bearer <token>` (Admin only)

---

## ⚠️ Error Responses

### Validation Error (422)
```json
{
  "success": false,
  "message": "Validation failed",
  "errors": [
    {
      "field": "email",
      "message": "Valid email is required"
    }
  ]
}
```

### Unauthorized (401)
```json
{
  "success": false,
  "message": "No token provided",
  "errors": null
}
```

### Forbidden (403)
```json
{
  "success": false,
  "message": "Access denied. Insufficient permissions.",
  "errors": null
}
```

### Not Found (404)
```json
{
  "success": false,
  "message": "Resource not found",
  "errors": null
}
```

### Conflict (409)
```json
{
  "success": false,
  "message": "Username already exists",
  "errors": null
}
```

### Server Error (500)
```json
{
  "success": false,
  "message": "Internal server error",
  "errors": null
}
```

---

## 📌 Notes

1. Semua timestamp menggunakan format MySQL: `YYYY-MM-DD HH:MM:SS`
2. Boolean values: `0` untuk false, `1` untuk true
3. Soft delete: Record tidak dihapus permanen, hanya menandai `deleted_at`
4. Pagination default: page=1, limit=10
5. Token JWT expires dalam 7 hari (konfigurasi di .env)
