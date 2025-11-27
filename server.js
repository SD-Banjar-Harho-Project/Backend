import express from "express";
import cors from "cors";
import helmet from "helmet";
import morgan from "morgan";
import rateLimit from "express-rate-limit";
import dotenv from "dotenv";
import pool from "./src/config/database.js";
import routes from "./src/routes/index.js";
import {
  errorHandler,
  notFoundHandler,
} from "./src/middlewares/errorHandler.js";

dotenv.config();

const app = express();
const PORT = process.env.PORT || 5000;

// ==============================================
// MIDDLEWARES
// ==============================================

// Security
app.use(helmet());

// CORS
app.use(
  cors({
    origin: process.env.CORS_ORIGIN || "*",
    credentials: true,
  })
);

// Logging
app.use(morgan("dev"));

// Body Parser
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Static Files
app.use("/uploads", express.static("uploads"));

// Rate Limiting (HANYA untuk /api)
const limiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 menit
  max: 1000, // Naikkan limit dulu untuk testing
  message: "Too many requests from this IP, please try again later.",
  standardHeaders: true,
  legacyHeaders: false,
});

// ==============================================
// LOGGING MIDDLEWARE (untuk debugging)
// ==============================================
app.use((req, res, next) => {
  console.log(`📥 ${req.method} ${req.path}`);
  next();
});

// ==============================================
// ROUTES
// ==============================================

// Root endpoint
app.get("/", (req, res) => {
  res.json({
    success: true,
    message: "Welcome to SD Negeri Bandarharjo API",
    version: "1.0.0",
    documentation: "/api",
  });
});

// API Routes (dengan rate limiting)
app.use("/api", limiter, routes);

// ==============================================
// ERROR HANDLERS
// ==============================================
app.use(notFoundHandler);
app.use(errorHandler);

// ==============================================
// DATABASE CONNECTION TEST
// ==============================================
const testConnection = async () => {
  try {
    await pool.query("SELECT 1");
    console.log("✅ Database connected successfully");
    return true;
  } catch (error) {
    console.error("❌ Database connection failed:", error.message);
    throw error;
  }
};

// ==============================================
// START SERVER
// ==============================================
const startServer = async () => {
  try {
    // Test database connection
    await testConnection();

    // Start server
    app.listen(PORT, () => {
      console.log("=".repeat(50));
      console.log("🚀 Server Information");
      console.log("=".repeat(50));
      console.log(`Environment: ${process.env.NODE_ENV || "development"}`);
      console.log(`Server running on port: ${PORT}`);
      console.log(`API endpoint: http://localhost:${PORT}/api`);
      console.log(`Health check: http://localhost:${PORT}/api/health`);
      console.log("=".repeat(50));
      console.log("📋 Available routes:");
      console.log("  - GET  /api/health");
      console.log("  - POST /api/auth/login");
      console.log("  - GET  /api/teachers");
      console.log("  - GET  /api/users");
      console.log("=".repeat(50));
    });
  } catch (error) {
    console.error("❌ Failed to start server:", error);
    process.exit(1);
  }
};

startServer();

export default app;
