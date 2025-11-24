import Teacher from "../models/teacher.js";
import { successResponse, errorResponse } from "../utils/responseHelper.js";

// =====================================================
// GET ALL
// =====================================================
export const getAllTeachers = async (req, res, next) => {
  try {
    const teachers = await Teacher.findAll();
    return successResponse(res, "Teachers retrieved successfully", teachers);
  } catch (error) {
    next(error);
  }
};

// =====================================================
// GET DELETED TEACHERS
// =====================================================
export const getDeletedTeachers = async (req, res, next) => {
  try {
    const teachers = await Teacher.findDeleted();
    return successResponse(
      res,
      "Deleted teachers retrieved successfully",
      teachers
    );
  } catch (error) {
    next(error);
  }
};

// =====================================================
// GET BY ID
// =====================================================
export const getTeacherById = async (req, res, next) => {
  try {
    const teacher = await Teacher.findById(req.params.id);
    if (!teacher) return errorResponse(res, "Teacher not found", 404);

    return successResponse(res, "Teacher retrieved successfully", teacher);
  } catch (error) {
    next(error);
  }
};

// =====================================================
// CREATE TEACHER
// =====================================================
export const createTeacher = async (req, res, next) => {
  try {
    // AUTO SET user_id sesuai user login
    const user_id = req.user.id;

    const payload = {
      user_id,
      nip: req.body.nip || null,
      name: req.body.name,
      photo: req.body.photo || null,
      subject_id: req.body.subject_id || null,
      class_name: req.body.class_name || null,
      email: req.body.email || null,
      phone: req.body.phone || null,
      bio: req.body.bio || null,
      join_date: req.body.join_date || new Date(),
    };

    const teacher = await Teacher.create(payload);

    return successResponse(res, "Teacher created successfully", teacher, 201);
  } catch (error) {
    next(error);
  }
};

// =====================================================
// UPDATE TEACHER
// =====================================================
export const updateTeacher = async (req, res, next) => {
  try {
    const teacher = await Teacher.findById(req.params.id);
    if (!teacher) return errorResponse(res, "Teacher not found", 404);

    const payload = {
      user_id: req.body.user_id || teacher.user_id,
      nip: req.body.nip || teacher.nip,
      name: req.body.name || teacher.name,
      photo: req.body.photo || teacher.photo,
      subject_id: req.body.subject_id || teacher.subject_id,
      class_name: req.body.class_name || teacher.class_name,
      email: req.body.email || teacher.email,
      phone: req.body.phone || teacher.phone,
      bio: req.body.bio || teacher.bio,
      join_date: req.body.join_date || teacher.join_date,
      is_active: req.body.is_active ?? teacher.is_active,
    };

    const updated = await Teacher.update(req.params.id, payload);

    return successResponse(res, "Teacher updated successfully", updated);
  } catch (error) {
    next(error);
  }
};

// =====================================================
// DELETE (SOFT DELETE)
// =====================================================
export const deleteTeacher = async (req, res, next) => {
  try {
    const teacher = await Teacher.findById(req.params.id);
    if (!teacher) return errorResponse(res, "Teacher not found", 404);

    await Teacher.softDelete(req.params.id);

    return successResponse(res, "Teacher deleted successfully");
  } catch (error) {
    next(error);
  }
};

// =====================================================
// RESTORE
// =====================================================
export const restoreTeacher = async (req, res, next) => {
  try {
    const teacher = await Teacher.findDeletedById(req.params.id);
    if (!teacher)
      return errorResponse(res, "Teacher not found in deleted list", 404);

    const restored = await Teacher.restore(req.params.id);

    return successResponse(res, "Teacher restored successfully", restored);
  } catch (error) {
    next(error);
  }
};
