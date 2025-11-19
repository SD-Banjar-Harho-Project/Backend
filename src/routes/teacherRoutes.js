import express from 'express';
import { body } from 'express-validator';
import { validate } from '../middlewares/validator.js';
import { authenticate, authorize } from '../middlewares/authMiddleware.js';
import * as teacherController from '../controllers/teacherController.js';

const router = express.Router();

router.get('/', teacherController.getAllTeachers);
router.get('/:id', teacherController.getTeacherById);

router.post('/',
  authenticate,
  authorize('admin', 'superadmin'),
  [
    body('full_name').notEmpty().withMessage('Full name is required'),
    body('nip').optional().notEmpty().withMessage('NIP cannot be empty'),
    body('email').optional().isEmail().withMessage('Valid email is required'),
    validate
  ],
  teacherController.createTeacher
);

router.put('/:id',
  authenticate,
  authorize('admin', 'superadmin'),
  [
    body('full_name').notEmpty().withMessage('Full name is required'),
    validate
  ],
  teacherController.updateTeacher
);

router.delete('/:id',
  authenticate,
  authorize('admin', 'superadmin'),
  teacherController.deleteTeacher
);

export default router;
