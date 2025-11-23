import Subject from "../models/subject.js";
import { successResponse, errorResponse } from "../utils/responseHelper.js";

export const getAllSubjects = async (req, res, next) => {
  try {
    const subjects = await Subject.findAll();
    return successResponse(res, "Subjects retrieved successfully", subjects);
  } catch (error) {
    next(error);
  }
};

export const getSubjectById = async (req, res, next) => {
  try {
    const { id } = req.params;
    const subject = await Subject.findById(id);

    if (!subject) {
      return errorResponse(res, "Subject not found", 404);
    }

    return successResponse(res, "Subject retrieved successfully", subject);
  } catch (error) {
    next(error);
  }
};

export const createSubject = async (req, res, next) => {
  try {
    const subject = await Subject.create(req.body);
    return successResponse(res, "Subject created successfully", subject, 201);
  } catch (error) {
    next(error);
  }
};

export const updateSubject = async (req, res, next) => {
  try {
    const { id } = req.params;

    const subject = await Subject.findById(id);
    if (!subject) {
      return errorResponse(res, "Subject not found", 404);
    }

    const updatedSubject = await Subject.update(id, req.body);
    return successResponse(res, "Subject updated successfully", updatedSubject);
  } catch (error) {
    next(error);
  }
};

export const deleteSubject = async (req, res, next) => {
  try {
    const { id } = req.params;

    const subject = await Subject.findById(id);
    if (!subject) {
      return errorResponse(res, "Subject not found", 404);
    }

    await Subject.delete(id);
    return successResponse(res, "Subject deleted successfully");
  } catch (error) {
    next(error);
  }
};
