import express from "express";
import { authenticate, authorize } from "../middlewares/authMiddleware.js";
import upload from "../middlewares/upload.js";
import * as profileController from "../controllers/profileContoller.js";

const router = express.Router();

// Get profile (public or protected, terserah kamu)
// Jika kamu ingin semua orang bisa lihat profile sekolah → tidak pakai authenticate
router.get("/", profileController.getProfile);

// Update / Create profile (admin only)
router.post(
  "/",
  authenticate,
  authorize("admin", "superadmin"),
  upload.fields([
    { name: "logo", maxCount: 1 },
    { name: "principal_photo", maxCount: 1 },
  ]),
  profileController.updateProfile
);

export default router;
