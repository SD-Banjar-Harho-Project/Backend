import express from 'express';
import authRoutes from './authRoutes.js';
import userRoutes from './userRoutes.js';
import postRoutes from './postRoutes.js';
import teacherRoutes from './teacherRoutes.js';

const router = express.Router();

router.use('/auth', authRoutes);
router.use('/users', userRoutes);
router.use('/posts', postRoutes);
router.use('/teachers', teacherRoutes);

router.get('/', (req, res) => {
  res.json({
    success: true,
    message: 'Backend API SD Negeri Bandarharjo',
    version: '1.0.0',
    endpoints: {
      auth: '/api/auth',
      users: '/api/users',
      posts: '/api/posts',
      teachers: '/api/teachers'
    }
  });
});

export default router;
