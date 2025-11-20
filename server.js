import express from "express";
import cors from "cors";
import helmet from "helmet";
import morgan from "morgan";
import rateLimit from "express-rate-limit";
import dotenv from "dotenv";
//import { testConnection } from "./src/config/database.js";
import routes from "./src/routes/index.js";
import {
  errorHandler,
  notFoundHandler,
} from "./src/middleware/errorHandler.js";

dotenv.config();

const app = express();
const PORT = process.env.PORT || 5000;

const limiter = rateLimit({
  windowMs: 15 * 60 * 1000,
  max: 100,
  message: "Too many requests from this IP, please try again later.",
});

app.use(helmet());
app.use(
  cors({
    origin: process.env.CORS_ORIGIN || "*",
    credentials: true,
  })
);
app.use(morgan("dev"));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use("/api", limiter);

app.use("/uploads", express.static("uploads"));

app.get("/", (req, res) => {
  res.json({
    success: true,
    message: "Welcome to SD Negeri Bandarharjo API",
    version: "1.0.0",
    documentation: "/api",
  });
});

app.use("/api", routes);

app.use(notFoundHandler);
app.use(errorHandler);

const startServer = async () => {
  try {
    //await testConnection();

    app.listen(PORT, () => {
      console.log("=".repeat(50));
      console.log("🚀 Server Information");
      console.log("=".repeat(50));
      console.log(`Environment: ${process.env.NODE_ENV || "development"}`);
      console.log(`Server running on port: ${PORT}`);
      console.log(`API endpoint: http://localhost:${PORT}/api`);
      console.log("=".repeat(50));
    });
  } catch (error) {
    console.error("Failed to start server:", error);
    process.exit(1);
  }
};

startServer();

export default app;
