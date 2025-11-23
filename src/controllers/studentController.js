import Student from "../models/student.js";
import { successResponse, errorResponse } from "../utils/responseHelper.js";

export const getAllStudents = async (req, res, next) => {
  try {
    const students = await Student.findAll();
    return successResponse(res, "Students retrieved successfully", students);
  } catch (error) {
    next(error);
  }
};

export const getStudentById = async (req, res, next) => {
  try {
    const { id } = req.params;
    const student = await Student.findById(id);

    if (!student) {
      return errorResponse(res, "Student not found", 404);
    }

    return successResponse(res, "Student retrieved successfully", student);
  } catch (error) {
    next(error);
  }
};

export const getStudentsByClass = async (req, res, next) => {
  try {
    const { className } = req.params;
    const students = await Student.findByClass(className);
    return successResponse(res, "Students retrieved successfully", students);
  } catch (error) {
    next(error);
  }
};

export const createStudent = async (req, res, next) => {
  try {
    const student = await Student.create(req.body);
    return successResponse(res, "Student created successfully", student, 201);
  } catch (error) {
    next(error);
  }
};

export const updateStudent = async (req, res, next) => {
  try {
    const { id } = req.params;

    const student = await Student.findById(id);
    if (!student) {
      return errorResponse(res, "Student not found", 404);
    }

    const updatedStudent = await Student.update(id, req.body);
    return successResponse(res, "Student updated successfully", updatedStudent);
  } catch (error) {
    next(error);
  }
};

export const deleteStudent = async (req, res, next) => {
  try {
    const { id } = req.params;

    const student = await Student.findById(id);
    if (!student) {
      return errorResponse(res, "Student not found", 404);
    }

    await Student.delete(id);
    return successResponse(res, "Student deleted successfully");
  } catch (error) {
    next(error);
  }
};

export const getStudentStats = async (req, res, next) => {
  try {
    const stats = await Student.getStatsByClass();
    return successResponse(
      res,
      "Student statistics retrieved successfully",
      stats
    );
  } catch (error) {
    next(error);
  }
};
