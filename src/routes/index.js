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

// ==============================================
// LOGGING (untuk debugging)
// ==============================================
router.use((req, res, next) => {
  console.log(`🔍 API Route: ${req.method} ${req.originalUrl}`);
  next();
});

// ==============================================
// HEALTH CHECK (PERTAMA)
// ==============================================
router.get("/health", (req, res) => {
  res.json({
    success: true,
    message: "API is running",
    timestamp: new Date().toISOString(),
    uptime: process.uptime(),
  });
});

// ==============================================
// API ROUTES
// ==============================================
router.use("/auth", authRoutes);
router.use("/users", userRoutes);
router.use("/roles", roleRoutes);
router.use("/profile", profileRoutes);
router.use("/subjects", subjectRoutes);
router.use("/teachers", teacherRoutes);
router.use("/students", studentRoutes);
router.use("/posts", postRoutes);
router.use("/galleries", galleryRoutes);

// ==============================================
// TEST ROUTE (untuk memastikan routing bekerja)
// ==============================================
router.get("/test", (req, res) => {
  res.json({
    success: true,
    message: "Route index.js is working!",
    availableRoutes: [
      "GET /api/health",
      "GET /api/test",
      "POST /api/auth/login",
      "GET /api/teachers",
      "GET /api/users",
      "GET /api/subjects",
    ],
  });
});

// ==============================================
// CATCH UNDEFINED ROUTES di level /api
// ==============================================
router.use((req, res) => {
  res.status(404).json({
    success: false,
    message: `Route ${req.method} ${req.originalUrl} not found in API routes`,
    hint: "Check /api/test for available routes",
  });
});

console.log("✅ Routes loaded successfully");

export default router;
