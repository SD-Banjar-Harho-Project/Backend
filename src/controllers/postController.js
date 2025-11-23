import Post from "../models/post.js";
import { successResponse, errorResponse } from "../utils/responseHelper.js";
import { generateUniqueSlug } from "../utils/slugify.js";

export const getAllPosts = async (req, res, next) => {
  try {
    const posts = await Post.getAllPost(); // FIX

    return successResponse(res, posts, "Posts retrieved successfully");
  } catch (error) {
    next(error);
  }
};

export const getPostById = async (req, res, next) => {
  try {
    const { id } = req.params;

    const post = await Post.findById(id);

    if (!post) {
      return errorResponse(res, "Post not found", 404);
    }

    return successResponse(res, post, "Post retrieved successfully");
  } catch (error) {
    next(error);
  }
};

export const getPostBySlug = async (req, res, next) => {
  try {
    const { slug } = req.params;
    const post = await Post.findBySlug(slug);

    if (!post) {
      return errorResponse(res, "Post not found", 404);
    }

    // Karena tidak ada incrementViews() dan getWithTags() di model,
    // kita hapus dan langsung return post saja.

    return successResponse(res, post, "Post retrieved successfully");
  } catch (error) {
    next(error);
  }
};

export const createPost = async (req, res, next) => {
  try {
    const { title, content, status } = req.body;

    const slug = await generateUniqueSlug(Post, title);

    const postData = {
      title,
      slug,
      content,
      status: status || "draft",
      author_id: req.user.id,
    };

    const post = await Post.create(postData);

    return successResponse(res, post, "Post created successfully", 201);
  } catch (error) {
    next(error);
  }
};

export const updatePost = async (req, res, next) => {
  try {
    const { id } = req.params;
    const { title, content, status } = req.body;

    const existingPost = await Post.findById(id);

    if (!existingPost) {
      return errorResponse(res, "Post not found", 404);
    }

    const slug =
      title && title !== existingPost.title
        ? await generateUniqueSlug(Post, title, id)
        : existingPost.slug;

    const postData = {
      title: title || existingPost.title,
      slug,
      content: content || existingPost.content,
      status: status || existingPost.status,
    };

    const updatedPost = await Post.update(id, postData);

    return successResponse(res, updatedPost, "Post updated successfully");
  } catch (error) {
    next(error);
  }
};

export const softDeletePost = async (req, res, next) => {
  try {
    const { id } = req.params;

    const post = await Post.findById(id);

    if (!post) {
      return errorResponse(res, "Post not found", 404);
    }

    await Post.softDelete(id);

    return successResponse(res, null, "Post deleted successfully");
  } catch (error) {
    next(error);
  }
};
