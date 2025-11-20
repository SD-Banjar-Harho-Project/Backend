# 🔗 PANDUAN INTEGRASI BACKEND DENGAN REACT.JS

Panduan lengkap untuk mengintegrasikan Backend REST API dengan Frontend React.js

---

## 📋 TABLE OF CONTENTS

1. [Setup Project React](#-setup-project-react)
2. [Install Dependencies](#-install-dependencies)
3. [Environment Variables](#-environment-variables)
4. [Setup Axios Instance](#-setup-axios-instance)
5. [Authentication Service](#-authentication-service)
6. [Protected Routes](#-protected-routes)
7. [API Services](#-api-services)
8. [React Components Examples](#-react-components-examples)
9. [State Management](#-state-management)
10. [Error Handling](#-error-handling)
11. [File Upload](#-file-upload)
12. [Deployment](#-deployment)

---

## 🚀 Setup Project React

### Create React App (Vite - Recommended)

```bash
npm create vite@latest sd-bandarharjo-frontend -- --template react
cd sd-bandarharjo-frontend
npm install
```

### Atau menggunakan Create React App

```bash
npx create-react-app sd-bandarharjo-frontend
cd sd-bandarharjo-frontend
```

---

## 📦 Install Dependencies

```bash
# Core dependencies
npm install axios react-router-dom

# State management (pilih salah satu)
npm install zustand          # Recommended: Simple & lightweight
# ATAU
npm install @reduxjs/toolkit react-redux

# UI Library (optional)
npm install @mui/material @emotion/react @emotion/styled
# ATAU
npm install antd
# ATAU
npm install tailwindcss

# Form handling
npm install react-hook-form yup @hookform/resolvers

# Utilities
npm install date-fns          # Date formatting
npm install react-toastify    # Toast notifications
npm install react-loading-skeleton  # Loading skeleton
```

---

## 🔧 Environment Variables

### Create `.env` file

```env
# Backend API URL
VITE_API_BASE_URL=http://localhost:5000/api

# Optional: Other configs
VITE_APP_NAME=SD Negeri Bandarharjo
VITE_APP_VERSION=1.0.0
```

### For Production

```env
VITE_API_BASE_URL=https://your-backend.railway.app/api
```

---

## 🌐 Setup Axios Instance

### `src/services/api.js`

```javascript
import axios from 'axios';

const API_BASE_URL = import.meta.env.VITE_API_BASE_URL || 'http://localhost:5000/api';

// Create axios instance
const api = axios.create({
  baseURL: API_BASE_URL,
  headers: {
    'Content-Type': 'application/json',
  },
  timeout: 10000, // 10 seconds
});

// Request interceptor - Add token to all requests
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

// Response interceptor - Handle errors globally
api.interceptors.response.use(
  (response) => response.data, // Return only data
  (error) => {
    // Handle specific error codes
    if (error.response) {
      const { status, data } = error.response;
      
      switch (status) {
        case 401:
          // Unauthorized - clear token and redirect to login
          localStorage.removeItem('token');
          localStorage.removeItem('user');
          window.location.href = '/login';
          break;
        
        case 403:
          // Forbidden
          console.error('Access denied:', data.message);
          break;
        
        case 404:
          console.error('Resource not found:', data.message);
          break;
        
        case 422:
          // Validation error
          console.error('Validation error:', data.errors);
          break;
        
        case 500:
          console.error('Server error:', data.message);
          break;
        
        default:
          console.error('Error:', data.message);
      }
    } else if (error.request) {
      console.error('Network error - No response from server');
    } else {
      console.error('Error:', error.message);
    }
    
    return Promise.reject(error);
  }
);

export default api;
```

---

## 🔐 Authentication Service

### `src/services/authService.js`

```javascript
import api from './api';

const AUTH_ENDPOINTS = {
  REGISTER: '/auth/register',
  LOGIN: '/auth/login',
  PROFILE: '/auth/profile',
  UPDATE_PROFILE: '/auth/profile',
  CHANGE_PASSWORD: '/auth/change-password',
  LOGOUT: '/auth/logout',
};

// Register new user
export const register = async (userData) => {
  const response = await api.post(AUTH_ENDPOINTS.REGISTER, userData);
  return response;
};

// Login
export const login = async (username, password) => {
  const response = await api.post(AUTH_ENDPOINTS.LOGIN, {
    username,
    password,
  });
  
  if (response.success) {
    // Save token and user data
    localStorage.setItem('token', response.data.token);
    localStorage.setItem('user', JSON.stringify(response.data.user));
  }
  
  return response;
};

// Get current user profile
export const getProfile = async () => {
  const response = await api.get(AUTH_ENDPOINTS.PROFILE);
  return response;
};

// Update profile
export const updateProfile = async (profileData) => {
  const response = await api.put(AUTH_ENDPOINTS.UPDATE_PROFILE, profileData);
  return response;
};

// Change password
export const changePassword = async (oldPassword, newPassword) => {
  const response = await api.post(AUTH_ENDPOINTS.CHANGE_PASSWORD, {
    old_password: oldPassword,
    new_password: newPassword,
  });
  return response;
};

// Logout
export const logout = async () => {
  try {
    await api.post(AUTH_ENDPOINTS.LOGOUT);
  } catch (error) {
    console.error('Logout error:', error);
  } finally {
    // Clear local storage
    localStorage.removeItem('token');
    localStorage.removeItem('user');
    window.location.href = '/login';
  }
};

// Check if user is authenticated
export const isAuthenticated = () => {
  const token = localStorage.getItem('token');
  return !!token;
};

// Get current user from localStorage
export const getCurrentUser = () => {
  const userStr = localStorage.getItem('user');
  if (userStr) {
    try {
      return JSON.parse(userStr);
    } catch (error) {
      return null;
    }
  }
  return null;
};

// Check if user has role
export const hasRole = (role) => {
  const user = getCurrentUser();
  return user && user.role === role;
};
```

---

## 🛡️ Protected Routes

### `src/components/ProtectedRoute.jsx`

```javascript
import { Navigate } from 'react-router-dom';
import { isAuthenticated, getCurrentUser, hasRole } from '../services/authService';

const ProtectedRoute = ({ children, requiredRole }) => {
  if (!isAuthenticated()) {
    return <Navigate to="/login" replace />;
  }

  if (requiredRole && !hasRole(requiredRole)) {
    return <Navigate to="/unauthorized" replace />;
  }

  return children;
};

export default ProtectedRoute;
```

### Setup Routes - `src/App.jsx`

```javascript
import { BrowserRouter, Routes, Route } from 'react-router-dom';
import ProtectedRoute from './components/ProtectedRoute';

// Pages
import HomePage from './pages/HomePage';
import LoginPage from './pages/LoginPage';
import RegisterPage from './pages/RegisterPage';
import Dashboard from './pages/Dashboard';
import PostsPage from './pages/PostsPage';
import PostDetailPage from './pages/PostDetailPage';
import TeachersPage from './pages/TeachersPage';
import GalleriesPage from './pages/GalleriesPage';
import ContactPage from './pages/ContactPage';
import ComplaintsPage from './pages/ComplaintsPage';

// Admin Pages
import AdminDashboard from './pages/admin/Dashboard';
import AdminPosts from './pages/admin/Posts';
import AdminTeachers from './pages/admin/Teachers';

function App() {
  return (
    <BrowserRouter>
      <Routes>
        {/* Public Routes */}
        <Route path="/" element={<HomePage />} />
        <Route path="/login" element={<LoginPage />} />
        <Route path="/register" element={<RegisterPage />} />
        <Route path="/posts" element={<PostsPage />} />
        <Route path="/posts/:slug" element={<PostDetailPage />} />
        <Route path="/teachers" element={<TeachersPage />} />
        <Route path="/galleries" element={<GalleriesPage />} />
        <Route path="/contact" element={<ContactPage />} />
        <Route path="/complaints" element={<ComplaintsPage />} />

        {/* Protected Routes - User */}
        <Route
          path="/dashboard"
          element={
            <ProtectedRoute>
              <Dashboard />
            </ProtectedRoute>
          }
        />

        {/* Protected Routes - Admin */}
        <Route
          path="/admin"
          element={
            <ProtectedRoute requiredRole="admin">
              <AdminDashboard />
            </ProtectedRoute>
          }
        />
        <Route
          path="/admin/posts"
          element={
            <ProtectedRoute requiredRole="admin">
              <AdminPosts />
            </ProtectedRoute>
          }
        />
        <Route
          path="/admin/teachers"
          element={
            <ProtectedRoute requiredRole="admin">
              <AdminTeachers />
            </ProtectedRoute>
          }
        />
      </Routes>
    </BrowserRouter>
  );
}

export default App;
```

---

## 📡 API Services

### Posts Service - `src/services/postService.js`

```javascript
import api from './api';

export const getPosts = async (page = 1, limit = 10, filters = {}) => {
  const params = new URLSearchParams({
    page,
    limit,
    ...filters,
  });
  
  const response = await api.get(`/posts?${params}`);
  return response;
};

export const getPostById = async (id) => {
  const response = await api.get(`/posts/${id}`);
  return response;
};

export const getPostBySlug = async (slug) => {
  const response = await api.get(`/posts/slug/${slug}`);
  return response;
};

export const createPost = async (postData) => {
  const response = await api.post('/posts', postData);
  return response;
};

export const updatePost = async (id, postData) => {
  const response = await api.put(`/posts/${id}`, postData);
  return response;
};

export const deletePost = async (id) => {
  const response = await api.delete(`/posts/${id}`);
  return response;
};
```

### Teachers Service - `src/services/teacherService.js`

```javascript
import api from './api';

export const getTeachers = async (page = 1, limit = 10, search = '') => {
  const params = new URLSearchParams({ page, limit, search });
  const response = await api.get(`/teachers?${params}`);
  return response;
};

export const getTeacherById = async (id) => {
  const response = await api.get(`/teachers/${id}`);
  return response;
};

export const createTeacher = async (teacherData) => {
  const response = await api.post('/teachers', teacherData);
  return response;
};

export const updateTeacher = async (id, teacherData) => {
  const response = await api.put(`/teachers/${id}`, teacherData);
  return response;
};

export const deleteTeacher = async (id) => {
  const response = await api.delete(`/teachers/${id}`);
  return response;
};
```

### Galleries Service - `src/services/galleryService.js`

```javascript
import api from './api';

export const getGalleries = async (page = 1, limit = 10) => {
  const response = await api.get(`/galleries?page=${page}&limit=${limit}`);
  return response;
};

export const getGalleryById = async (id) => {
  const response = await api.get(`/galleries/${id}`);
  return response;
};

export const createGallery = async (galleryData) => {
  const response = await api.post('/galleries', galleryData);
  return response;
};
```

### Contact Service - `src/services/contactService.js`

```javascript
import api from './api';

export const sendContactMessage = async (messageData) => {
  const response = await api.post('/contact', messageData);
  return response;
};

export const getContactMessages = async (page = 1, status = '') => {
  const params = new URLSearchParams({ page, status });
  const response = await api.get(`/contact?${params}`);
  return response;
};
```

### Complaints Service - `src/services/complaintService.js`

```javascript
import api from './api';

export const createComplaint = async (complaintData) => {
  const response = await api.post('/complaints', complaintData);
  return response;
};

export const getComplaints = async (page = 1, filters = {}) => {
  const params = new URLSearchParams({ page, ...filters });
  const response = await api.get(`/complaints?${params}`);
  return response;
};

export const getComplaintById = async (id) => {
  const response = await api.get(`/complaints/${id}`);
  return response;
};
```

### Notifications Service - `src/services/notificationService.js`

```javascript
import api from './api';

export const getMyNotifications = async (page = 1, limit = 10) => {
  const response = await api.get(`/notifications/me?page=${page}&limit=${limit}`);
  return response;
};

export const getUnreadCount = async () => {
  const response = await api.get('/notifications/me/unread-count');
  return response;
};

export const markAsRead = async (id) => {
  const response = await api.put(`/notifications/${id}/read`);
  return response;
};

export const markAllAsRead = async () => {
  const response = await api.put('/notifications/me/mark-all-read');
  return response;
};
```

---

## 🎨 React Components Examples

### Login Page - `src/pages/LoginPage.jsx`

```javascript
import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { login } from '../services/authService';
import { toast } from 'react-toastify';

function LoginPage() {
  const navigate = useNavigate();
  const [formData, setFormData] = useState({
    username: '',
    password: '',
  });
  const [loading, setLoading] = useState(false);

  const handleChange = (e) => {
    setFormData({
      ...formData,
      [e.target.name]: e.target.value,
    });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setLoading(true);

    try {
      const response = await login(formData.username, formData.password);
      
      if (response.success) {
        toast.success('Login berhasil!');
        navigate('/dashboard');
      }
    } catch (error) {
      toast.error(error.response?.data?.message || 'Login gagal');
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="login-page">
      <h1>Login</h1>
      <form onSubmit={handleSubmit}>
        <input
          type="text"
          name="username"
          placeholder="Username"
          value={formData.username}
          onChange={handleChange}
          required
        />
        <input
          type="password"
          name="password"
          placeholder="Password"
          value={formData.password}
          onChange={handleChange}
          required
        />
        <button type="submit" disabled={loading}>
          {loading ? 'Loading...' : 'Login'}
        </button>
      </form>
    </div>
  );
}

export default LoginPage;
```

### Posts List - `src/pages/PostsPage.jsx`

```javascript
import { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import { getPosts } from '../services/postService';

function PostsPage() {
  const [posts, setPosts] = useState([]);
  const [loading, setLoading] = useState(true);
  const [pagination, setPagination] = useState(null);
  const [currentPage, setCurrentPage] = useState(1);

  useEffect(() => {
    fetchPosts(currentPage);
  }, [currentPage]);

  const fetchPosts = async (page) => {
    try {
      setLoading(true);
      const data = await getPosts(page, 10, { status: 'published' });
      
      if (data.success) {
        setPosts(data.data);
        setPagination(data.pagination);
      }
    } catch (error) {
      console.error('Error fetching posts:', error);
    } finally {
      setLoading(false);
    }
  };

  if (loading) return <div>Loading...</div>;

  return (
    <div className="posts-page">
      <h1>Artikel & Berita</h1>
      
      <div className="posts-grid">
        {posts.map((post) => (
          <article key={post.id} className="post-card">
            {post.featured_image && (
              <img src={post.featured_image} alt={post.title} />
            )}
            <h2>{post.title}</h2>
            <p>{post.excerpt}</p>
            <Link to={`/posts/${post.slug}`}>Baca Selengkapnya</Link>
          </article>
        ))}
      </div>

      {/* Pagination */}
      {pagination && (
        <div className="pagination">
          <button
            onClick={() => setCurrentPage(currentPage - 1)}
            disabled={!pagination.hasPrevPage}
          >
            Previous
          </button>
          <span>
            Page {pagination.currentPage} of {pagination.totalPages}
          </span>
          <button
            onClick={() => setCurrentPage(currentPage + 1)}
            disabled={!pagination.hasNextPage}
          >
            Next
          </button>
        </div>
      )}
    </div>
  );
}

export default PostsPage;
```

### Post Detail - `src/pages/PostDetailPage.jsx`

```javascript
import { useState, useEffect } from 'react';
import { useParams } from 'react-router-dom';
import { getPostBySlug } from '../services/postService';
import { format } from 'date-fns';

function PostDetailPage() {
  const { slug } = useParams();
  const [post, setPost] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetchPost();
  }, [slug]);

  const fetchPost = async () => {
    try {
      const data = await getPostBySlug(slug);
      if (data.success) {
        setPost(data.data);
      }
    } catch (error) {
      console.error('Error fetching post:', error);
    } finally {
      setLoading(false);
    }
  };

  if (loading) return <div>Loading...</div>;
  if (!post) return <div>Post not found</div>;

  return (
    <div className="post-detail">
      {post.featured_image && (
        <img src={post.featured_image} alt={post.title} />
      )}
      <h1>{post.title}</h1>
      <div className="post-meta">
        <span>By {post.author_name}</span>
        <span>{format(new Date(post.published_at), 'dd MMMM yyyy')}</span>
        <span>Category: {post.category_name}</span>
      </div>
      <div 
        className="post-content"
        dangerouslySetInnerHTML={{ __html: post.content }}
      />
      {post.tags && post.tags.length > 0 && (
        <div className="post-tags">
          {post.tags.map((tag) => (
            <span key={tag.id} className="tag">
              {tag.name}
            </span>
          ))}
        </div>
      )}
    </div>
  );
}

export default PostDetailPage;
```

### Contact Form - `src/pages/ContactPage.jsx`

```javascript
import { useState } from 'react';
import { sendContactMessage } from '../services/contactService';
import { toast } from 'react-toastify';

function ContactPage() {
  const [formData, setFormData] = useState({
    name: '',
    email: '',
    phone: '',
    subject: '',
    message: '',
  });
  const [loading, setLoading] = useState(false);

  const handleChange = (e) => {
    setFormData({
      ...formData,
      [e.target.name]: e.target.value,
    });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setLoading(true);

    try {
      const response = await sendContactMessage(formData);
      
      if (response.success) {
        toast.success('Pesan berhasil dikirim!');
        setFormData({
          name: '',
          email: '',
          phone: '',
          subject: '',
          message: '',
        });
      }
    } catch (error) {
      toast.error('Gagal mengirim pesan');
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="contact-page">
      <h1>Hubungi Kami</h1>
      <form onSubmit={handleSubmit}>
        <input
          type="text"
          name="name"
          placeholder="Nama Lengkap"
          value={formData.name}
          onChange={handleChange}
          required
        />
        <input
          type="email"
          name="email"
          placeholder="Email"
          value={formData.email}
          onChange={handleChange}
          required
        />
        <input
          type="tel"
          name="phone"
          placeholder="No. Telepon"
          value={formData.phone}
          onChange={handleChange}
        />
        <input
          type="text"
          name="subject"
          placeholder="Subjek"
          value={formData.subject}
          onChange={handleChange}
          required
        />
        <textarea
          name="message"
          placeholder="Pesan Anda"
          value={formData.message}
          onChange={handleChange}
          required
          rows="6"
        />
        <button type="submit" disabled={loading}>
          {loading ? 'Mengirim...' : 'Kirim Pesan'}
        </button>
      </form>
    </div>
  );
}

export default ContactPage;
```

### Notification Bell - `src/components/NotificationBell.jsx`

```javascript
import { useState, useEffect } from 'react';
import { getUnreadCount, getMyNotifications, markAsRead } from '../services/notificationService';

function NotificationBell() {
  const [unreadCount, setUnreadCount] = useState(0);
  const [notifications, setNotifications] = useState([]);
  const [showDropdown, setShowDropdown] = useState(false);

  useEffect(() => {
    fetchUnreadCount();
    const interval = setInterval(fetchUnreadCount, 30000); // Every 30 seconds
    return () => clearInterval(interval);
  }, []);

  const fetchUnreadCount = async () => {
    try {
      const data = await getUnreadCount();
      if (data.success) {
        setUnreadCount(data.data.unread_count);
      }
    } catch (error) {
      console.error('Error fetching unread count:', error);
    }
  };

  const fetchNotifications = async () => {
    try {
      const data = await getMyNotifications(1, 5);
      if (data.success) {
        setNotifications(data.data);
      }
    } catch (error) {
      console.error('Error fetching notifications:', error);
    }
  };

  const handleBellClick = () => {
    if (!showDropdown) {
      fetchNotifications();
    }
    setShowDropdown(!showDropdown);
  };

  const handleNotificationClick = async (notification) => {
    if (!notification.is_read) {
      await markAsRead(notification.id);
      fetchUnreadCount();
    }
    if (notification.action_url) {
      window.location.href = notification.action_url;
    }
  };

  return (
    <div className="notification-bell">
      <button onClick={handleBellClick}>
        🔔
        {unreadCount > 0 && (
          <span className="badge">{unreadCount}</span>
        )}
      </button>

      {showDropdown && (
        <div className="notifications-dropdown">
          <h3>Notifikasi</h3>
          {notifications.length === 0 ? (
            <p>Tidak ada notifikasi</p>
          ) : (
            <ul>
              {notifications.map((notif) => (
                <li
                  key={notif.id}
                  onClick={() => handleNotificationClick(notif)}
                  className={!notif.is_read ? 'unread' : ''}
                >
                  <strong>{notif.title}</strong>
                  <p>{notif.message}</p>
                </li>
              ))}
            </ul>
          )}
        </div>
      )}
    </div>
  );
}

export default NotificationBell;
```

---

## 🗂️ State Management (Zustand - Recommended)

### `src/store/authStore.js`

```javascript
import { create } from 'zustand';
import { persist } from 'zustand/middleware';

export const useAuthStore = create(
  persist(
    (set) => ({
      user: null,
      token: null,
      isAuthenticated: false,

      setAuth: (user, token) => set({
        user,
        token,
        isAuthenticated: true,
      }),

      clearAuth: () => set({
        user: null,
        token: null,
        isAuthenticated: false,
      }),

      updateUser: (userData) => set((state) => ({
        user: { ...state.user, ...userData },
      })),
    }),
    {
      name: 'auth-storage',
    }
  )
);
```

### Usage in Component

```javascript
import { useAuthStore } from '../store/authStore';

function Dashboard() {
  const { user, isAuthenticated, clearAuth } = useAuthStore();

  if (!isAuthenticated) {
    return <Navigate to="/login" />;
  }

  return (
    <div>
      <h1>Welcome, {user.full_name}</h1>
      <button onClick={clearAuth}>Logout</button>
    </div>
  );
}
```

---

## ⚠️ Error Handling

### `src/utils/errorHandler.js`

```javascript
export const handleApiError = (error) => {
  if (error.response) {
    // Server responded with error
    const { status, data } = error.response;
    
    switch (status) {
      case 400:
        return 'Permintaan tidak valid';
      case 401:
        return 'Anda harus login terlebih dahulu';
      case 403:
        return 'Anda tidak memiliki akses';
      case 404:
        return 'Data tidak ditemukan';
      case 422:
        return data.errors || 'Validasi gagal';
      case 500:
        return 'Terjadi kesalahan server';
      default:
        return data.message || 'Terjadi kesalahan';
    }
  } else if (error.request) {
    // No response from server
    return 'Tidak dapat terhubung ke server';
  } else {
    return error.message || 'Terjadi kesalahan';
  }
};
```

---

## 📤 File Upload

### `src/utils/uploadHelpers.js`

```javascript
export const uploadImage = async (file) => {
  const formData = new FormData();
  formData.append('image', file);

  try {
    const response = await fetch('http://localhost:5000/api/upload/image', {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${localStorage.getItem('token')}`,
      },
      body: formData,
    });

    const data = await response.json();
    return data;
  } catch (error) {
    throw error;
  }
};
```

### Image Upload Component

```javascript
import { useState } from 'react';
import { uploadImage } from '../utils/uploadHelpers';

function ImageUpload({ onUploadSuccess }) {
  const [uploading, setUploading] = useState(false);
  const [preview, setPreview] = useState(null);

  const handleFileChange = async (e) => {
    const file = e.target.files[0];
    if (!file) return;

    // Show preview
    const reader = new FileReader();
    reader.onloadend = () => {
      setPreview(reader.result);
    };
    reader.readAsDataURL(file);

    // Upload file
    try {
      setUploading(true);
      const response = await uploadImage(file);
      if (response.success) {
        onUploadSuccess(response.data.path);
      }
    } catch (error) {
      console.error('Upload error:', error);
    } finally {
      setUploading(false);
    }
  };

  return (
    <div>
      <input
        type="file"
        accept="image/*"
        onChange={handleFileChange}
        disabled={uploading}
      />
      {preview && <img src={preview} alt="Preview" width="200" />}
      {uploading && <p>Uploading...</p>}
    </div>
  );
}

export default ImageUpload;
```

---

## 🚀 Deployment

### Build for Production

```bash
npm run build
```

### Deploy to Vercel

1. Install Vercel CLI:
```bash
npm install -g vercel
```

2. Deploy:
```bash
vercel
```

3. Set environment variables di Vercel dashboard:
```
VITE_API_BASE_URL=https://your-backend.railway.app/api
```

### Deploy to Netlify

1. Build project
2. Drag & drop `dist` folder ke Netlify
3. Set environment variables

---

## 📋 Checklist Integration

- [x] Setup Axios instance
- [x] Add request/response interceptors
- [x] Create auth service
- [x] Implement protected routes
- [x] Create API services for all endpoints
- [x] Handle authentication flow
- [x] Handle errors globally
- [x] Add toast notifications
- [x] Implement file upload
- [x] Setup state management
- [x] Build production-ready

---

## 🎯 Best Practices

1. ✅ Always use environment variables for API URL
2. ✅ Handle loading states in UI
3. ✅ Show error messages to users
4. ✅ Implement request cancellation for unmounted components
5. ✅ Use React Query or SWR for better data fetching
6. ✅ Implement retry logic for failed requests
7. ✅ Add request timeout
8. ✅ Validate forms before API calls
9. ✅ Cache API responses when appropriate
10. ✅ Implement optimistic UI updates

---

**Last Updated:** November 20, 2025
**React Version:** 18.x
**Backend API Version:** 1.0.0
