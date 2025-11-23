import express from "express";
import { body } from "express-validator";
import { validate } from "../middlewares/validator.js";
import { authenticate, authorize } from "../middlewares/authMiddleware.js";
import * as subjectController from "../controllers/subjectController.js";

const router = express.Router();

// GET all subjects (public or protected sesuai kebutuhan)
router.get("/", subjectController.getAllSubjects);

// GET subject by ID
router.get("/:id", subjectController.getSubjectById);

// CREATE subject (admin)
router.post(
  "/",
  authenticate,
  authorize("admin", "superadmin"),
  [
    body("subject_name").notEmpty().withMessage("Subject name is required"),
    validate,
  ],
  subjectController.createSubject
);

// UPDATE subject
router.put(
  "/:id",
  authenticate,
  authorize("admin", "superadmin"),
  [
    body("subject_name").notEmpty().withMessage("Subject name is required"),
    validate,
  ],
  subjectController.updateSubject
);

// DELETE subject
router.delete(
  "/:id",
  authenticate,
  authorize("admin", "superadmin"),
  subjectController.deleteSubject
);

export default router;
