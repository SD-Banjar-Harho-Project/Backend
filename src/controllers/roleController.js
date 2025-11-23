import Role from "../models/role.js";
import { successResponse, errorResponse } from "../utils/responseHelper.js";

export const getAllRoles = async (req, res, next) => {
  try {
    const roles = await Role.findAll();
    return successResponse(res, "Roles retrieved successfully", roles);
  } catch (error) {
    next(error);
  }
};

export const getRoleById = async (req, res, next) => {
  try {
    const { id } = req.params;
    const role = await Role.findById(id);

    if (!role) {
      return errorResponse(res, "Role not found", 404);
    }

    return successResponse(res, "Role retrieved successfully", role);
  } catch (error) {
    next(error);
  }
};

export const createRole = async (req, res, next) => {
  try {
    const { display_name, descrip } = req.body;

    const existingRole = await Role.findByName(display_name);
    if (existingRole) {
      return errorResponse(res, "Role already exists", 409);
    }

    const role = await Role.create({ display_name, descrip });

    return successResponse(res, "Role created successfully", role, 201);
  } catch (error) {
    next(error);
  }
};

export const updateRole = async (req, res, next) => {
  try {
    const { id } = req.params;
    const { display_name, descrip } = req.body;

    const role = await Role.findById(id);
    if (!role) {
      return errorResponse(res, "Role not found", 404);
    }

    const updatedRole = await Role.update(id, { display_name, descrip });

    return successResponse(res, "Role updated successfully", updatedRole);
  } catch (error) {
    next(error);
  }
};

export const deleteRole = async (req, res, next) => {
  try {
    const { id } = req.params;

    const role = await Role.findById(id);
    if (!role) {
      return errorResponse(res, "Role not found", 404);
    }

    await Role.delete(id);

    return successResponse(res, "Role deleted successfully");
  } catch (error) {
    next(error);
  }
};
