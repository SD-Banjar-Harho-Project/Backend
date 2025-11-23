import express from "express";
import { body } from "express-validator";
import { validate } from "../middlewares/validator.js";
import { authenticate, authorize } from "../middlewares/authMiddleware.js";
import * as roleController from "../controllers/roleController.js";

const router = express.Router();

// GET all roles
router.get(
  "/",
  authenticate,
  authorize("admin", "superadmin"),
  roleController.getAllRoles
);

// GET role by ID
router.get(
  "/:id",
  authenticate,
  authorize("admin", "superadmin"),
  roleController.getRoleById
);

// CREATE new role
router.post(
  "/",
  authenticate,
  authorize("admin", "superadmin"),
  [
    body("display_name").notEmpty().withMessage("Display name is required"),
    validate,
  ],
  roleController.createRole
);

// UPDATE role
router.put(
  "/:id",
  authenticate,
  authorize("admin", "superadmin"),
  [
    body("display_name").notEmpty().withMessage("Display name is required"),
    validate,
  ],
  roleController.updateRole
);

// DELETE role
router.delete(
  "/:id",
  authenticate,
  authorize("admin", "superadmin"),
  roleController.deleteRole
);

export default router;
