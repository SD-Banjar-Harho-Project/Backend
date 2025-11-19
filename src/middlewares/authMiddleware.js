import jwt from 'jsonwebtoken';
import { errorResponse } from '../utils/responseHelper.js';
import User from '../models/User.js';

export const authenticate = async (req, res, next) => {
  try {
    const authHeader = req.headers.authorization;

    if (!authHeader || !authHeader.startsWith('Bearer ')) {
      return errorResponse(res, 'No token provided', 401);
    }

    const token = authHeader.substring(7);

    const decoded = jwt.verify(token, process.env.JWT_SECRET);

    const user = await User.findById(decoded.userId);

    if (!user) {
      return errorResponse(res, 'User not found', 404);
    }

    if (!user.is_active) {
      return errorResponse(res, 'User account is inactive', 403);
    }

    req.user = user;
    next();
  } catch (error) {
    if (error.name === 'TokenExpiredError') {
      return errorResponse(res, 'Token expired', 401);
    }
    if (error.name === 'JsonWebTokenError') {
      return errorResponse(res, 'Invalid token', 401);
    }
    next(error);
  }
};

export const authorize = (...roles) => {
  return async (req, res, next) => {
    try {
      if (!req.user) {
        return errorResponse(res, 'Authentication required', 401);
      }

      const user = await User.findByIdWithRole(req.user.id);

      if (!user || !user.role_name) {
        return errorResponse(res, 'User role not found', 403);
      }

      if (!roles.includes(user.role_name)) {
        return errorResponse(res, 'Access denied. Insufficient permissions.', 403);
      }

      next();
    } catch (error) {
      next(error);
    }
  };
};

export const optionalAuth = async (req, res, next) => {
  try {
    const authHeader = req.headers.authorization;

    if (authHeader && authHeader.startsWith('Bearer ')) {
      const token = authHeader.substring(7);
      const decoded = jwt.verify(token, process.env.JWT_SECRET);
      const user = await User.findById(decoded.userId);
      
      if (user && user.is_active) {
        req.user = user;
      }
    }

    next();
  } catch (error) {
    next();
  }
};
