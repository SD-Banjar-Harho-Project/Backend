import express from "express";
import { body } from "express-validator";
import { validate } from "../middlewares/validator.js";
import { authenticate, authorize } from "../middlewares/authMiddleware.js";
import { uploadImage } from "../middlewares/upload.js";
import * as teacherController from "../controllers/teacherController.js";

const router = express.Router();

// =====================================================
// Middleware untuk set uploadSubDir
// =====================================================
const setTeacherUploadDir = (req, res, next) => {
  req.uploadSubDir = "teachers";
  next();
};

// =====================================================
// PUBLIC ROUTES
// =====================================================
router.get("/", teacherController.getAllTeachers);
router.get("/:id", teacherController.getTeacherById);

// =====================================================
// ADMIN ROUTES - GET DELETED
// =====================================================
router.get(
  "/deleted",
  authenticate,
  authorize("admin", "superadmin"),
  teacherController.getDeletedTeachers
);

// =====================================================
// ADMIN ROUTES - CREATE (dengan photo upload)
// =====================================================
router.post(
  "/",
  authenticate,
  authorize("admin", "superadmin"),
  setTeacherUploadDir, // ← Set folder destination
  uploadImage.single("photo"), // ← Upload middleware
  [
    body("name").notEmpty().withMessage("Full name is required"),
    body("nip").optional().isString().withMessage("NIP must be a string"),
    body("email").optional().isEmail().withMessage("Valid email is required"),
    body("phone")
      .optional()
      .isMobilePhone()
      .withMessage("Valid phone number is required"),
    body("subject_id")
      .optional()
      .isInt()
      .withMessage("Subject ID must be an integer"),
    body("class_name")
      .optional()
      .isString()
      .withMessage("Class name must be a string"),
    body("join_date")
      .optional()
      .isISO8601()
      .withMessage("Valid date is required"),
    validate,
  ],
  teacherController.createTeacher
);

// =====================================================
// ADMIN ROUTES - UPDATE (dengan photo upload)
// =====================================================
router.put(
  "/:id",
  authenticate,
  authorize("admin", "superadmin"),
  setTeacherUploadDir, // ← Set folder destination
  uploadImage.single("photo"), // ← Upload middleware
  [
    body("name").optional().notEmpty().withMessage("Full name cannot be empty"),
    body("nip").optional().isString().withMessage("NIP must be a string"),
    body("email").optional().isEmail().withMessage("Valid email is required"),
    body("phone")
      .optional()
      .isMobilePhone()
      .withMessage("Valid phone number is required"),
    body("subject_id")
      .optional()
      .isInt()
      .withMessage("Subject ID must be an integer"),
    body("class_name")
      .optional()
      .isString()
      .withMessage("Class name must be a string"),
    body("join_date")
      .optional()
      .isISO8601()
      .withMessage("Valid date is required"),
    body("is_active")
      .optional()
      .isBoolean()
      .withMessage("is_active must be boolean"),
    validate,
  ],
  teacherController.updateTeacher
);

// =====================================================
// ADMIN ROUTES - RESTORE
// =====================================================
router.post(
  "/:id/restore",
  authenticate,
  authorize("admin", "superadmin"),
  teacherController.restoreTeacher
);

// =====================================================
// ADMIN ROUTES - DELETE (SOFT DELETE)
// =====================================================
router.delete(
  "/:id",
  authenticate,
  authorize("admin", "superadmin"),
  teacherController.deleteTeacher
);

export default router;
