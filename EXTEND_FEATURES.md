# 🔧 PANDUAN EXTEND FITUR BACKEND

## Tabel yang Sudah Diimplementasi

✅ **Users** - User management dengan authentication
✅ **Roles** - Role management
✅ **Permissions** - Permission management  
✅ **Posts** - Blog/artikel/berita dengan relasi tags
✅ **ContentCategories** - Kategori untuk posts
✅ **Teachers** - Data guru/staff

## Tabel yang Perlu Diimplementasi

Berikut adalah tabel-tabel lain yang ada di database dan perlu dibuatkan Model, Controller, dan Routes:

### 1. **PostTag** (post_tags)
- Model untuk mengelola tag
- Endpoint: GET, POST, PUT, DELETE tags
- Relasi: Many-to-Many dengan Posts

### 2. **Gallery** (galleries)
- Model untuk album galeri
- Upload cover image
- Relasi: One-to-Many dengan GalleryItems

### 3. **GalleryItem** (gallery_items)
- Item dalam galeri (foto/video)
- Upload file support
- Relasi: Many-to-One dengan Gallery

### 4. **Comment** (comments)
- Komentar di posts
- Support nested comments (parent_id)
- Moderasi komentar (status: pending, approved, spam)

### 5. **Complaint** (complaints)
- Sistem pengaduan
- Ticket number generator
- Status tracking
- Relasi: One-to-Many dengan ComplaintResponses

### 6. **ComplaintResponse** (complaint_responses)
- Response untuk complaint
- Internal note support

### 7. **ContactMessage** (contact_messages)
- Pesan dari contact form
- Reply functionality

### 8. **Page** (pages)
- Halaman statis (About, Contact, dll)
- Page template support
- Hierarchical (parent-child)

### 9. **Menu** & **MenuItem**
- Menu management
- Support nested menu items
- Dynamic menu location

### 10. **Slider** (sliders)
- Homepage slider
- Active date range
- Display order

### 11. **SchoolProfile** (school_profiles)
- Profil sekolah
- Single record (singleton pattern)
- Social media links
- Maps coordinates

### 12. **Setting** (settings)
- Key-value settings
- Group by category
- Public/private settings

### 13. **MediaLibrary** (media_library)
- File manager
- Image metadata
- Usage tracking

### 14. **Notification** (notifications)
- User notifications
- Read/unread status
- Action URL

### 15. **ActivityLog** (activity_logs)
- Audit trail
- Track user actions
- Store old/new values (JSON)

### 16. **SeoMetadata** (seo_metadata)
- SEO untuk model polymorphic
- Open Graph tags
- Twitter Cards
- Schema markup (JSON)

---

## 📝 Template untuk Membuat Fitur Baru

### STEP 1: Membuat Model

```javascript
// src/models/Gallery.js
import { pool } from '../config/database.js';

class Gallery {
  static async findAll(limit = 10, offset = 0) {
    const [rows] = await pool.execute(
      `SELECT g.*, u.full_name as author_name
       FROM galleries g
       LEFT JOIN users u ON g.author_id = u.id
       WHERE g.deleted_at IS NULL
       ORDER BY g.created_at DESC
       LIMIT ? OFFSET ?`,
      [limit, offset]
    );
    return rows;
  }

  static async count() {
    const [rows] = await pool.execute(
      'SELECT COUNT(*) as total FROM galleries WHERE deleted_at IS NULL'
    );
    return rows[0].total;
  }

  static async findById(id) {
    const [rows] = await pool.execute(
      'SELECT * FROM galleries WHERE id = ? AND deleted_at IS NULL',
      [id]
    );
    return rows[0];
  }

  static async create(data) {
    const { title, slug, description, cover_image, gallery_type, event_date, author_id } = data;
    
    const [result] = await pool.execute(
      `INSERT INTO galleries (title, slug, description, cover_image, gallery_type, event_date, 
       author_id, views_count, is_featured, status, created_at, updated_at)
       VALUES (?, ?, ?, ?, ?, ?, ?, 0, 0, 'active', NOW(), NOW())`,
      [title, slug, description, cover_image, gallery_type, event_date, author_id]
    );

    return this.findById(result.insertId);
  }

  static async update(id, data) {
    const { title, slug, description, cover_image, gallery_type, event_date } = data;
    
    await pool.execute(
      `UPDATE galleries SET title = ?, slug = ?, description = ?, cover_image = ?, 
       gallery_type = ?, event_date = ?, updated_at = NOW()
       WHERE id = ?`,
      [title, slug, description, cover_image, gallery_type, event_date, id]
    );

    return this.findById(id);
  }

  static async delete(id) {
    await pool.execute(
      'UPDATE galleries SET deleted_at = NOW() WHERE id = ?',
      [id]
    );
  }

  // Method tambahan untuk relasi
  static async getWithItems(id) {
    const gallery = await this.findById(id);
    if (!gallery) return null;

    const [items] = await pool.execute(
      'SELECT * FROM gallery_items WHERE gallery_id = ? ORDER BY display_order',
      [id]
    );

    gallery.items = items;
    return gallery;
  }
}

export default Gallery;
```

### STEP 2: Membuat Controller

```javascript
// src/controllers/galleryController.js
import Gallery from '../models/Gallery.js';
import { successResponse, errorResponse, paginatedResponse } from '../utils/responseHelper.js';
import { getPaginationParams } from '../utils/pagination.js';
import { generateUniqueSlug } from '../utils/slugify.js';

export const getAllGalleries = async (req, res, next) => {
  try {
    const { page, limit, offset } = getPaginationParams(req);
    
    const galleries = await Gallery.findAll(limit, offset);
    const total = await Gallery.count();

    return paginatedResponse(res, galleries, page, limit, total, 'Galleries retrieved successfully');
  } catch (error) {
    next(error);
  }
};

export const getGalleryById = async (req, res, next) => {
  try {
    const { id } = req.params;
    const gallery = await Gallery.getWithItems(id);

    if (!gallery) {
      return errorResponse(res, 'Gallery not found', 404);
    }

    return successResponse(res, gallery, 'Gallery retrieved successfully');
  } catch (error) {
    next(error);
  }
};

export const createGallery = async (req, res, next) => {
  try {
    const { title, description, cover_image, gallery_type, event_date } = req.body;

    const slug = await generateUniqueSlug(Gallery, title);

    const galleryData = {
      title,
      slug,
      description,
      cover_image,
      gallery_type,
      event_date,
      author_id: req.user.id
    };

    const gallery = await Gallery.create(galleryData);

    return successResponse(res, gallery, 'Gallery created successfully', 201);
  } catch (error) {
    next(error);
  }
};

export const updateGallery = async (req, res, next) => {
  try {
    const { id } = req.params;
    const { title, description, cover_image, gallery_type, event_date } = req.body;

    const existing = await Gallery.findById(id);
    if (!existing) {
      return errorResponse(res, 'Gallery not found', 404);
    }

    const slug = title !== existing.title 
      ? await generateUniqueSlug(Gallery, title, id)
      : existing.slug;

    const galleryData = {
      title,
      slug,
      description,
      cover_image,
      gallery_type,
      event_date
    };

    const gallery = await Gallery.update(id, galleryData);

    return successResponse(res, gallery, 'Gallery updated successfully');
  } catch (error) {
    next(error);
  }
};

export const deleteGallery = async (req, res, next) => {
  try {
    const { id } = req.params;

    const gallery = await Gallery.findById(id);
    if (!gallery) {
      return errorResponse(res, 'Gallery not found', 404);
    }

    await Gallery.delete(id);

    return successResponse(res, null, 'Gallery deleted successfully');
  } catch (error) {
    next(error);
  }
};
```

### STEP 3: Membuat Routes

```javascript
// src/routes/galleryRoutes.js
import express from 'express';
import { body } from 'express-validator';
import { validate } from '../middlewares/validator.js';
import { authenticate, authorize } from '../middlewares/authMiddleware.js';
import * as galleryController from '../controllers/galleryController.js';

const router = express.Router();

// Public routes
router.get('/', galleryController.getAllGalleries);
router.get('/:id', galleryController.getGalleryById);

// Protected routes
router.post('/',
  authenticate,
  authorize('admin', 'editor', 'superadmin'),
  [
    body('title').notEmpty().withMessage('Title is required'),
    body('gallery_type').isIn(['photo', 'video', 'mixed']).withMessage('Invalid gallery type'),
    validate
  ],
  galleryController.createGallery
);

router.put('/:id',
  authenticate,
  authorize('admin', 'editor', 'superadmin'),
  [
    body('title').notEmpty().withMessage('Title is required'),
    validate
  ],
  galleryController.updateGallery
);

router.delete('/:id',
  authenticate,
  authorize('admin', 'superadmin'),
  galleryController.deleteGallery
);

export default router;
```

### STEP 4: Daftarkan Route di index.js

```javascript
// src/routes/index.js
import galleryRoutes from './galleryRoutes.js';

// Tambahkan di router
router.use('/galleries', galleryRoutes);
```

---

## 🎯 Fitur Khusus yang Perlu Diimplementasi

### 1. File Upload untuk Gallery
- Implementasi upload image/video
- Resize dan compress image
- Generate thumbnail
- Validasi file type dan size

### 2. Nested Comments
- Recursive query untuk get comment tree
- Limit nesting level (max 3 levels)

### 3. Ticket Number Generator untuk Complaints
```javascript
// Format: CMPL-YYYYMMDD-XXXX
const generateTicketNumber = async () => {
  const date = new Date();
  const dateStr = date.toISOString().slice(0, 10).replace(/-/g, '');
  
  const [result] = await pool.execute(
    'SELECT COUNT(*) as count FROM complaints WHERE DATE(created_at) = CURDATE()'
  );
  
  const sequence = String(result[0].count + 1).padStart(4, '0');
  return `CMPL-${dateStr}-${sequence}`;
};
```

### 4. Singleton Pattern untuk SchoolProfile
```javascript
static async get() {
  const [rows] = await pool.execute(
    'SELECT * FROM school_profiles WHERE is_active = 1 LIMIT 1'
  );
  return rows[0];
}

static async update(data) {
  // Update existing or create if not exists
  const existing = await this.get();
  if (existing) {
    await pool.execute('UPDATE school_profiles SET ... WHERE id = ?', [..., existing.id]);
  } else {
    await pool.execute('INSERT INTO school_profiles SET ...');
  }
}
```

### 5. Activity Log Middleware
```javascript
export const logActivity = (action, modelType) => {
  return async (req, res, next) => {
    const originalSend = res.send;
    
    res.send = function(data) {
      // Log activity after successful response
      if (res.statusCode < 400 && req.user) {
        ActivityLog.create({
          user_id: req.user.id,
          action,
          model_type: modelType,
          model_id: req.params.id,
          description: `User ${action} ${modelType}`,
          ip_address: req.ip,
          user_agent: req.get('user-agent')
        }).catch(err => console.error('Failed to log activity:', err));
      }
      
      originalSend.call(this, data);
    };
    
    next();
  };
};
```

---

## 🚀 Quick Start untuk Fitur Baru

1. **Copy template Model** dari contoh di atas
2. **Sesuaikan field** dengan struktur tabel di database
3. **Buat Controller** dengan CRUD operations
4. **Buat Routes** dengan validation rules
5. **Daftarkan** di `src/routes/index.js`
6. **Test** menggunakan Postman/Thunder Client

---

## 📌 Best Practices

- Selalu gunakan **prepared statements** untuk prevent SQL injection
- Implement **soft delete** (deleted_at) daripada hard delete
- Gunakan **transaction** untuk operasi yang melibatkan multiple tables
- Implement **pagination** untuk list endpoints
- Add **search** functionality di list endpoints
- Gunakan **slugify** untuk URL-friendly strings
- Validate **input** menggunakan express-validator
- Return **consistent response** format
- Handle **errors** properly dengan try-catch
- Log **important activities** menggunakan ActivityLog

---

## 🔍 Testing Checklist

Untuk setiap fitur baru, pastikan test:

- [ ] GET all (with pagination)
- [ ] GET by ID
- [ ] POST create (with validation)
- [ ] PUT update
- [ ] DELETE
- [ ] Search functionality
- [ ] Filter by status/type
- [ ] Authentication required
- [ ] Authorization (role check)
- [ ] Error handling (404, 400, 401, 403)
- [ ] Relasi dengan tabel lain
