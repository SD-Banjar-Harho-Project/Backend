import express from "express";
import { body } from "express-validator";
import { validate } from "../middlewares/validator.js";
import { authenticate, authorize } from "../middlewares/authMiddleware.js";
import { uploadImage } from "../middlewares/upload.js";
import * as postController from "../controllers/postController.js";

const router = express.Router();

// =======================
// PUBLIC ROUTES
// =======================
router.get("/", postController.getAllPosts);
router.get("/id/:id", postController.getPostById);
router.get("/slug/:slug", postController.getPostBySlug);

// =======================
// PROTECTED ROUTES
// =======================

// Create Post
router.post(
  "/",
  authenticate,
  authorize("admin", "superadmin"),

  // Set upload folder: uploads/posts/
  (req, res, next) => {
    req.uploadSubDir = "posts";
    next();
  },

  // Multer harus duluan agar req.body terisi
  uploadImage.single("image"),

  // Lalu validator dibaca dari req.body yang sudah lengkap
  [
    body("title").notEmpty().withMessage("Title is required"),
    body("content").notEmpty().withMessage("Content is required"),
    validate,
  ],

  postController.createPost
);

// Update Post
router.put(
  "/:id",
  authenticate,
  authorize("admin", "superadmin"),

  (req, res, next) => {
    req.uploadSubDir = "posts";
    next();
  },

  uploadImage.single("image"),

  [
    body("title").optional().notEmpty(),
    body("content").optional().notEmpty(),
    validate,
  ],

  postController.updatePost
);

// Soft Delete
router.delete(
  "/:id",
  authenticate,
  authorize("admin", "superadmin"),
  postController.softDeletePost
);

export default router;
