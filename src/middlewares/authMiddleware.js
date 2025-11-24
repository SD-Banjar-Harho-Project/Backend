import jwt from "jsonwebtoken";
import { errorResponse } from "../utils/responseHelper.js";
import User from "../models/user.js";

// ======================================================
// AUTHENTICATE (WAJIB LOGIN)
// ======================================================
export const authenticate = async (req, res, next) => {
  try {
    const authHeader = req.headers.authorization;

    if (!authHeader || !authHeader.startsWith("Bearer ")) {
      return errorResponse(res, "No token provided", 401);
    }

    const token = authHeader.split(" ")[1];

    const decoded = jwt.verify(token, process.env.JWT_SECRET);

    // Gunakan decoded.id (sesuai token)
    const user = await User.findById(decoded.id);

    if (!user) {
      return errorResponse(res, "User not found", 404);
    }

    if (!user.is_active) {
      return errorResponse(res, "User account is inactive", 403);
    }

    // Simpan data user untuk digunakan oleh controller
    req.user = {
      id: user.id,
      username: user.username,
      role: decoded.role, // role dari token
      email: user.email,
      is_active: user.is_active,
    };

    next();
  } catch (error) {
    if (error.name === "TokenExpiredError") {
      return errorResponse(res, "Token expired", 401);
    }
    if (error.name === "JsonWebTokenError") {
      return errorResponse(res, "Invalid token", 401);
    }
    next(error);
  }
};

// ======================================================
// AUTHORIZE (HARUS ROLE TERTENTU)
// ======================================================
export const authorize = (...roles) => {
  return async (req, res, next) => {
    try {
      if (!req.user) {
        return errorResponse(res, "Authentication required", 401);
      }

      console.log("User role:", req.user.role);
      console.log("Allowed roles:", roles);

      if (!roles.includes(req.user.role)) {
        return errorResponse(
          res,
          "Access denied. Insufficient permissions.",
          403
        );
      }

      next();
    } catch (error) {
      next(error);
    }
  };
};

// ======================================================
// OPTIONAL AUTH (LOGIN OPSIONAL)
// ======================================================
export const optionalAuth = async (req, res, next) => {
  try {
    const authHeader = req.headers.authorization;

    if (authHeader && authHeader.startsWith("Bearer ")) {
      const token = authHeader.split(" ")[1];
      const decoded = jwt.verify(token, process.env.JWT_SECRET);
      const user = await User.findById(decoded.id);

      if (user && user.is_active) {
        req.user = {
          id: user.id,
          username: user.username,
          role: decoded.role,
          email: user.email,
          is_active: user.is_active,
        };
      }
    }

    next();
  } catch (error) {
    next(); // tetap lanjut meski token invalid
  }
};
