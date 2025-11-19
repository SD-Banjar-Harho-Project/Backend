import express from 'express';
import { body } from 'express-validator';
import { validate } from '../middlewares/validator.js';
import { authenticate, authorize, optionalAuth } from '../middlewares/authMiddleware.js';
import * as postController from '../controllers/postController.js';

const router = express.Router();

router.get('/', optionalAuth, postController.getAllPosts);
router.get('/:id', optionalAuth, postController.getPostById);
router.get('/slug/:slug', optionalAuth, postController.getPostBySlug);

router.post('/',
  authenticate,
  authorize('admin', 'editor', 'superadmin'),
  [
    body('title').notEmpty().withMessage('Title is required'),
    body('content').notEmpty().withMessage('Content is required'),
    body('post_type').optional().isIn(['article', 'news', 'announcement', 'page'])
      .withMessage('Invalid post type'),
    body('status').optional().isIn(['draft', 'published', 'archived'])
      .withMessage('Invalid status'),
    validate
  ],
  postController.createPost
);

router.put('/:id',
  authenticate,
  authorize('admin', 'editor', 'superadmin'),
  [
    body('title').notEmpty().withMessage('Title is required'),
    body('content').notEmpty().withMessage('Content is required'),
    validate
  ],
  postController.updatePost
);

router.delete('/:id',
  authenticate,
  authorize('admin', 'superadmin'),
  postController.deletePost
);

export default router;
