import express from "express";
import { authenticate, authorize } from "../middlewares/authMiddleware.js";
import upload from "../middlewares/upload.js";
import * as galleryController from "../controllers/galleryController.js";

const router = express.Router();

// Public routes (jika frontend perlu fetch)
router.get("/", galleryController.getAllGalleries);
router.get("/published", galleryController.getPublishedGalleries);
router.get("/slug/:slug", galleryController.getGalleryBySlug);

// Admin-only routes
router.get(
  "/:id",
  authenticate,
  authorize("admin", "superadmin"),
  galleryController.getGalleryById
);

router.post(
  "/",
  authenticate,
  authorize("admin", "superadmin"),
  upload.fields([
    { name: "img", maxCount: 1 },
    { name: "video", maxCount: 1 },
  ]),
  galleryController.createGallery
);

router.put(
  "/:id",
  authenticate,
  authorize("admin", "superadmin"),
  upload.fields([
    { name: "img", maxCount: 1 },
    { name: "video", maxCount: 1 },
  ]),
  galleryController.updateGallery
);

router.delete(
  "/:id",
  authenticate,
  authorize("admin", "superadmin"),
  galleryController.deleteGallery
);

// Update status (draft → published → archived)
router.patch(
  "/:id/status",
  authenticate,
  authorize("admin", "superadmin"),
  galleryController.updateGalleryStatus
);

export default router;
