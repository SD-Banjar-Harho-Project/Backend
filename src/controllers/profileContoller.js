import Profile from "../models/profile.js";
import { successResponse, errorResponse } from "../utils/responseHelper.js";

export const getProfile = async (req, res, next) => {
  try {
    const profile = await Profile.get();

    if (!profile) {
      return errorResponse(res, "Profile not found", 404);
    }

    return successResponse(res, "Profile retrieved successfully", profile);
  } catch (error) {
    next(error);
  }
};

export const updateProfile = async (req, res, next) => {
  try {
    const data = req.body;

    if (req.files) {
      if (req.files.logo) {
        data.logo = req.files.logo[0].path;
      }
      if (req.files.principal_photo) {
        data.principal_photo = req.files.principal_photo[0].path;
      }
    }

    const profile = await Profile.createOrUpdate(data);

    return successResponse(res, "Profile updated successfully", profile);
  } catch (error) {
    next(error);
  }
};
