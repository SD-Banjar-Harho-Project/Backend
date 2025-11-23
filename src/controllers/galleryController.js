import Gallery from "../models/gallery.js";
import { successResponse, errorResponse } from "../utils/responseHelper.js";

export const getAllGalleries = async (req, res, next) => {
  try {
    const galleries = await Gallery.findAll();
    return successResponse(res, "Galleries retrieved successfully", galleries);
  } catch (error) {
    next(error);
  }
};

export const getPublishedGalleries = async (req, res, next) => {
  try {
    const galleries = await Gallery.findPublished();
    return successResponse(
      res,
      "Published galleries retrieved successfully",
      galleries
    );
  } catch (error) {
    next(error);
  }
};

export const getGalleryById = async (req, res, next) => {
  try {
    const { id } = req.params;
    const gallery = await Gallery.findById(id);

    if (!gallery) {
      return errorResponse(res, "Gallery not found", 404);
    }

    return successResponse(res, "Gallery retrieved successfully", gallery);
  } catch (error) {
    next(error);
  }
};

export const getGalleryBySlug = async (req, res, next) => {
  try {
    const { slug } = req.params;
    const gallery = await Gallery.findBySlug(slug);

    if (!gallery) {
      return errorResponse(res, "Gallery not found", 404);
    }

    return successResponse(res, "Gallery retrieved successfully", gallery);
  } catch (error) {
    next(error);
  }
};

export const createGallery = async (req, res, next) => {
  try {
    const data = req.body;

    const existingGallery = await Gallery.findBySlug(data.slug);
    if (existingGallery) {
      return errorResponse(res, "Slug already exists", 409);
    }

    if (req.files) {
      if (req.files.img) {
        data.img = req.files.img[0].path;
      }
      if (req.files.video) {
        data.video = req.files.video[0].path;
      }
    }

    const gallery = await Gallery.create(data);

    return successResponse(res, "Gallery created successfully", gallery, 201);
  } catch (error) {
    next(error);
  }
};

export const updateGallery = async (req, res, next) => {
  try {
    const { id } = req.params;
    const data = req.body;

    const gallery = await Gallery.findById(id);
    if (!gallery) {
      return errorResponse(res, "Gallery not found", 404);
    }

    if (req.files) {
      if (req.files.img) {
        data.img = req.files.img[0].path;
      }
      if (req.files.video) {
        data.video = req.files.video[0].path;
      }
    }

    const updatedGallery = await Gallery.update(id, data);

    return successResponse(res, "Gallery updated successfully", updatedGallery);
  } catch (error) {
    next(error);
  }
};

export const deleteGallery = async (req, res, next) => {
  try {
    const { id } = req.params;

    const gallery = await Gallery.findById(id);
    if (!gallery) {
      return errorResponse(res, "Gallery not found", 404);
    }

    await Gallery.softDelete(id);

    return successResponse(res, "Gallery deleted successfully");
  } catch (error) {
    next(error);
  }
};

export const updateGalleryStatus = async (req, res, next) => {
  try {
    const { id } = req.params;
    const { status } = req.body;

    const gallery = await Gallery.findById(id);
    if (!gallery) {
      return errorResponse(res, "Gallery not found", 404);
    }

    const updatedGallery = await Gallery.updateStatus(id, status);

    return successResponse(
      res,
      "Gallery status updated successfully",
      updatedGallery
    );
  } catch (error) {
    next(error);
  }
};
