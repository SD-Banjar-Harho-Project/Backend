import express from "express";
import { body } from "express-validator";
import { validate } from "../middlewares/validator.js";
import { authenticate, authorize } from "../middlewares/authMiddleware.js";
import * as postController from "../controllers/postController.js";

const router = express.Router();

// =======================
// PUBLIC ROUTES
// =======================

// Semua post (published + draft jika admin)
router.get("/", postController.getAllPosts);

// Get post by ID (public)
router.get("/id/:id", postController.getPostById);

// Get post by slug (public)
router.get("/slug/:slug", postController.getPostBySlug);

// =======================
// PROTECTED ROUTES (admin/superadmin only)
// =======================

// Create post
router.post(
  "/",
  authenticate,
  authorize("admin", "superadmin"),
  [
    body("title").notEmpty().withMessage("Title is required"),
    body("content").notEmpty().withMessage("Content is required"),
    validate,
  ],
  postController.createPost
);

// Update post
router.put(
  "/:id",
  authenticate,
  authorize("admin", "superadmin"),
  [
    body("title").optional().notEmpty(),
    body("content").optional().notEmpty(),
    validate,
  ],
  postController.updatePost
);

// Soft delete
router.delete(
  "/:id",
  authenticate,
  authorize("admin", "superadmin"),
  postController.softDeletePost
);

export default router;
