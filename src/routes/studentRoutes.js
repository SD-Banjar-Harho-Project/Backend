import express from "express";
import { body } from "express-validator";
import { validate } from "../middlewares/validator.js";
import { authenticate, authorize } from "../middlewares/authMiddleware.js";
import * as studentController from "../controllers/studentController.js";

const router = express.Router();

// PUBLIC (opsional tergantung kebutuhan)
router.get("/", studentController.getAllStudents);
router.get("/stats", studentController.getStudentStats);
router.get("/class/:className", studentController.getStudentsByClass);
router.get("/:id", studentController.getStudentById);

// ADMIN ONLY (create / update / delete)
router.post(
  "/",
  authenticate,
  authorize("admin", "superadmin"),
  [
    body("name").notEmpty().withMessage("Name is required"),
    body("class").notEmpty().withMessage("Class is required"),
    body("gender").isIn(["L", "P"]).withMessage("Gender must be 'L' or 'P'"),
    body("score_uts")
      .optional()
      .isFloat({ min: 0, max: 100 })
      .withMessage("score_uts must be a number 0–100"),
    body("score_uas")
      .optional()
      .isFloat({ min: 0, max: 100 })
      .withMessage("score_uas must be a number 0–100"),
    validate,
  ],
  studentController.createStudent
);

router.put(
  "/:id",
  authenticate,
  authorize("admin", "superadmin"),
  [
    body("name").notEmpty().withMessage("Name is required"),
    body("class").notEmpty().withMessage("Class is required"),
    body("gender").isIn(["L", "P"]).withMessage("Gender must be 'L' or 'P'"),
    body("score_uts")
      .optional()
      .isFloat({ min: 0, max: 100 })
      .withMessage("score_uts must be a number 0–100"),
    body("score_uas")
      .optional()
      .isFloat({ min: 0, max: 100 })
      .withMessage("score_uas must be a number 0–100"),
    validate,
  ],
  studentController.updateStudent
);

router.delete(
  "/:id",
  authenticate,
  authorize("admin", "superadmin"),
  studentController.deleteStudent
);

export default router;
