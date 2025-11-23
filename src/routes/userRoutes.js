import express from "express";
import { body } from "express-validator";
import { validate } from "../middlewares/validator.js";
import { authenticate, authorize } from "../middlewares/authMiddleware.js";
import * as userController from "../controllers/userController.js";

const router = express.Router();

// MUST BE AT TOP
router.get(
  "/deleted",
  authenticate,
  authorize("admin", "super_admin"),
  userController.getDeletedUsers
);

router.post(
  "/:id/restore",
  authenticate,
  authorize("admin", "super_admin"),
  userController.restoreUser
);

router.get(
  "/",
  authenticate,
  authorize("admin", "super_admin"),
  userController.getAllUsers
);

router.get(
  "/:id",
  authenticate,
  authorize("admin", "super_admin"),
  userController.getUserById
);

router.post(
  "/",
  authenticate,
  authorize("admin", "super_admin"),
  [
    body("username").notEmpty(),
    body("email").optional().isEmail(),
    body("password").isLength({ min: 6 }),
    body("full_name").notEmpty(),
    validate,
  ],
  userController.createUser
);

router.put(
  "/:id",
  authenticate,
  authorize("admin", "super_admin"),
  [body("email").optional().isEmail(), body("full_name").notEmpty(), validate],
  userController.updateUser
);

router.delete(
  "/:id",
  authenticate,
  authorize("admin", "super_admin"),
  userController.deleteUser
);

router.post(
  "/:id/reset-password",
  authenticate,
  authorize("admin", "super_admin"),
  [body("new_password").isLength({ min: 6 }), validate],
  userController.resetPassword
);

export default router;
