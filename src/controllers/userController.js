import User from "../models/user.js";
import bcrypt from "bcryptjs";
import {
  successResponse,
  errorResponse,
  paginatedResponse,
} from "../utils/responseHelper.js";
import { getPaginationParams } from "../utils/pagination.js";

// GET ALL USERS
export const getAllUsers = async (req, res, next) => {
  try {
    const { page, limit, offset } = getPaginationParams(req);
    const search = req.query.search || "";

    let users, total;

    if (search) {
      users = await User.search(search, limit, offset);
      total = await User.countSearch(search);
    } else {
      users = await User.findAll(limit, offset);
      total = await User.count();
    }

    users.forEach((u) => delete u.password_hash);

    return paginatedResponse(
      res,
      users,
      page,
      limit,
      total,
      "Users retrieved successfully"
    );
  } catch (error) {
    next(error);
  }
};

// GET USER BY ID
export const getUserById = async (req, res, next) => {
  try {
    const user = await User.findById(req.params.id);

    if (!user) return errorResponse(res, "User not found", 404);

    delete user.password_hash;

    return successResponse(res, user, "User retrieved successfully");
  } catch (err) {
    next(err);
  }
};

// CREATE USER
export const createUser = async (req, res, next) => {
  try {
    const { username, email, password, full_name, phone, role_id, is_active } =
      req.body;

    // CHECK USERNAME
    if (await User.findByUsername(username))
      return errorResponse(res, "Username already exists", 409);

    // CHECK EMAIL (optional)
    if (email && (await User.findByEmail(email)))
      return errorResponse(res, "Email already exists", 409);

    // HASH PASSWORD
    const password_hash = await bcrypt.hash(password, 10);

    const user = await User.create({
      username,
      email,
      password_hash,
      full_name,
      phone,
      role_id,
      is_active,
    });

    delete user.password_hash;

    return successResponse(res, user, "User created successfully", 201);
  } catch (err) {
    next(err);
  }
};

// UPDATE USER
export const updateUser = async (req, res, next) => {
  try {
    const { id } = req.params;

    if (!(await User.findById(id)))
      return errorResponse(res, "User not found", 404);

    const { email, full_name, phone, role_id, is_active } = req.body;

    const user = await User.update(id, {
      email,
      full_name,
      phone,
      role_id,
      is_active,
    });

    delete user.password_hash;

    return successResponse(res, user, "User updated successfully");
  } catch (err) {
    next(err);
  }
};

// DELETE USER (soft delete)
export const deleteUser = async (req, res, next) => {
  try {
    if (!(await User.findById(req.params.id)))
      return errorResponse(res, "User not found", 404);

    await User.delete(req.params.id);

    return successResponse(res, null, "User deleted successfully");
  } catch (err) {
    next(err);
  }
};

// RESET PASSWORD
export const resetPassword = async (req, res, next) => {
  try {
    const user = await User.findById(req.params.id);

    if (!user) return errorResponse(res, "User not found", 404);

    const hash = await bcrypt.hash(req.body.new_password, 10);

    await User.updatePassword(req.params.id, hash);

    return successResponse(res, null, "Password reset successfully");
  } catch (err) {
    next(err);
  }
};

// GET DELETED USERS
export const getDeletedUsers = async (req, res, next) => {
  try {
    const { page, limit, offset } = getPaginationParams(req);

    const users = await User.findDeleted(limit, offset);
    const total = await User.countDeleted();

    users.forEach((u) => delete u.password_hash);

    return paginatedResponse(
      res,
      users,
      page,
      limit,
      total,
      "Deleted users retrieved successfully"
    );
  } catch (err) {
    next(err);
  }
};

// RESTORE USER
export const restoreUser = async (req, res, next) => {
  try {
    const restored = await User.restore(req.params.id);

    if (!restored)
      return errorResponse(res, "User not found or already active", 404);

    delete restored.password_hash;

    return successResponse(res, restored, "User restored successfully");
  } catch (err) {
    next(err);
  }
};
