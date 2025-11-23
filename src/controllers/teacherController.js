import Teacher from "../models/teacher.js";
import { successResponse, errorResponse } from "../utils/responseHelper.js";

export const getAllTeachers = async (req, res, next) => {
  try {
    const teachers = await Teacher.findAll();
    return successResponse(res, "Teachers retrieved successfully", teachers);
  } catch (error) {
    next(error);
  }
};

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

export const getTeacherById = async (req, res, next) => {
  try {
    const teacher = await Teacher.findById(req.params.id);
    if (!teacher) return errorResponse(res, "Teacher not found", 404);

    return successResponse(res, "Teacher retrieved successfully", teacher);
  } catch (error) {
    next(error);
  }
};

export const createTeacher = async (req, res, next) => {
  try {
    const teacher = await Teacher.create(req.body);
    return successResponse(res, "Teacher created successfully", teacher, 201);
  } catch (error) {
    next(error);
  }
};

export const updateTeacher = async (req, res, next) => {
  try {
    const teacher = await Teacher.findById(req.params.id);
    if (!teacher) return errorResponse(res, "Teacher not found", 404);

    const updated = await Teacher.update(req.params.id, req.body);
    return successResponse(res, "Teacher updated successfully", updated);
  } catch (error) {
    next(error);
  }
};

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
