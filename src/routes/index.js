import express from "express";
import authRoutes from "./authRoutes.js";
import userRoutes from "./userRoutes.js";
import roleRoutes from "./roleRoutes.js";
import profileRoutes from "./profileRoutes.js";
import subjectRoutes from "./subjectRoutes.js";
import teacherRoutes from "./teacherRoutes.js";
import studentRoutes from "./studentRoutes.js";
import postRoutes from "./postRoutes.js";
import galleryRoutes from "./galleryRoutes.js";

const router = express.Router();

// API Routes
router.use("/auth", authRoutes);
router.use("/users", userRoutes);
router.use("/roles", roleRoutes);
router.use("/profile", profileRoutes);
router.use("/subjects", subjectRoutes);
router.use("/teachers", teacherRoutes);
router.use("/students", studentRoutes);
router.use("/posts", postRoutes);
router.use("/galleries", galleryRoutes);

// Health check
router.get("/health", (req, res) => {
  res.json({
    success: true,
    message: "API is running",
    timestamp: new Date().toISOString(),
  });
});

export default router;
