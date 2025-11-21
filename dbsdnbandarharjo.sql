-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 21, 2025 at 10:55 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dbsdnbandarharjo`
--

-- --------------------------------------------------------

--
-- Table structure for table `activity_logs`
--

CREATE TABLE `activity_logs` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `action` varchar(50) DEFAULT NULL,
  `model_type` varchar(100) DEFAULT NULL,
  `model_id` bigint(20) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `old_values` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`old_values`)),
  `new_values` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`new_values`)),
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `activity_logs`
--

INSERT INTO `activity_logs` (`id`, `user_id`, `action`, `model_type`, `model_id`, `description`, `old_values`, `new_values`, `ip_address`, `user_agent`, `created_at`) VALUES
(2, 15, 'create', 'Post', 1, 'Created new post: Introduction to Programming', NULL, '{\"title\":\"Introduction to Programming\",\"status\":\"published\"}', '::1', 'PostmanRuntime/7.49.1', '2025-11-20 15:11:29');

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `id` bigint(20) NOT NULL,
  `post_id` bigint(20) DEFAULT NULL,
  `parent_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `author_name` varchar(100) DEFAULT NULL,
  `author_email` varchar(100) DEFAULT NULL,
  `content` text DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `comments`
--

INSERT INTO `comments` (`id`, `post_id`, `parent_id`, `user_id`, `author_name`, `author_email`, `content`, `status`, `ip_address`, `user_agent`, `created_at`, `updated_at`) VALUES
(1, 1, NULL, NULL, NULL, NULL, 'Artikel yang sangat bagus dan informatif! Terima kasih sudah berbagi.', 'pending', '::1', 'PostmanRuntime/7.49.1', '2025-11-20 11:44:25', '2025-11-20 11:44:25'),
(2, 1, NULL, NULL, NULL, NULL, 'Artikel yang sangat bagus dan informatif! Terima kasih sudah berbagi.', 'pending', '::1', 'PostmanRuntime/7.49.1', '2025-11-20 11:52:59', '2025-11-20 11:52:59'),
(4, 1, 3, NULL, NULL, NULL, 'Saya setuju dengan pendapat Anda. Sangat tepat sekali.', 'pending', '::1', 'PostmanRuntime/7.49.1', '2025-11-20 11:53:39', '2025-11-20 11:53:39');

-- --------------------------------------------------------

--
-- Table structure for table `complaints`
--

CREATE TABLE `complaints` (
  `id` bigint(20) NOT NULL,
  `ticket_number` varchar(50) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `category` varchar(50) DEFAULT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `attachments` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`attachments`)),
  `status` varchar(20) DEFAULT NULL,
  `priority` varchar(20) DEFAULT NULL,
  `assigned_to` bigint(20) DEFAULT NULL,
  `resolved_by` bigint(20) DEFAULT NULL,
  `resolution_note` text DEFAULT NULL,
  `resolved_at` timestamp NULL DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `complaints`
--

INSERT INTO `complaints` (`id`, `ticket_number`, `name`, `email`, `phone`, `category`, `subject`, `message`, `attachments`, `status`, `priority`, `assigned_to`, `resolved_by`, `resolution_note`, `resolved_at`, `ip_address`, `user_agent`, `created_at`, `updated_at`) VALUES
(2, 'TKT-202511-3537', 'Jonda', 'jonda@example.com', '081234567125', 'fasilitas', 'Kerusakan AC di Kelas 5B', 'AC di kelas 5B tidak berfungsi dengan baik. Mohon segera diperbaiki.', NULL, 'open', 'medium', NULL, NULL, NULL, NULL, '::1', 'PostmanRuntime/7.49.1', '2025-11-20 13:24:20', '2025-11-20 13:24:20');

-- --------------------------------------------------------

--
-- Table structure for table `complaint_responses`
--

CREATE TABLE `complaint_responses` (
  `id` bigint(20) NOT NULL,
  `complaint_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `is_internal` tinyint(1) DEFAULT 0,
  `attachments` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`attachments`)),
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `complaint_responses`
--

INSERT INTO `complaint_responses` (`id`, `complaint_id`, `user_id`, `message`, `is_internal`, `attachments`, `created_at`) VALUES
(1, 2, 8, 'Terima kasih atas laporannya. Tim kami akan segera menindaklanjuti.', 0, NULL, '2025-11-20 13:35:48');

-- --------------------------------------------------------

--
-- Table structure for table `contact_messages`
--

CREATE TABLE `contact_messages` (
  `id` bigint(20) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `subject` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `status` varchar(20) DEFAULT 'unread',
  `replied_at` timestamp NULL DEFAULT NULL,
  `replied_by` bigint(20) DEFAULT NULL,
  `reply_message` text DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `contact_messages`
--

INSERT INTO `contact_messages` (`id`, `name`, `email`, `phone`, `subject`, `message`, `status`, `replied_at`, `replied_by`, `reply_message`, `ip_address`, `user_agent`, `created_at`, `updated_at`) VALUES
(2, 'Jane Doe', 'jane@example.com', '081234567890', 'Informasi Pendaftaran Siswa Baru', 'Saya ingin menanyakan tentang syarat dan jadwal pendaftaran siswa baru untuk tahun ajaran 2025/2026.', 'replied', '2025-11-20 14:04:30', 8, 'Terima kasih atas pertanyaannya. Pendaftaran siswa baru akan dibuka mulai 1 Januari 2025. Untuk informasi lengkap silakan kunjungi halaman PPDB kami.', '::1', 'PostmanRuntime/7.49.1', '2025-11-20 14:02:42', '2025-11-20 14:04:30');

-- --------------------------------------------------------

--
-- Table structure for table `content_categories`
--

CREATE TABLE `content_categories` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `slug` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `icon` varchar(50) DEFAULT NULL,
  `color` varchar(20) DEFAULT NULL,
  `display_order` int(11) DEFAULT 0,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `content_categories`
--

INSERT INTO `content_categories` (`id`, `name`, `slug`, `description`, `parent_id`, `icon`, `color`, `display_order`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'Berita', 'berita', 'Kategori untuk berita sekolah', NULL, NULL, NULL, 1, 1, '2025-11-19 01:28:18', '2025-11-19 01:28:18'),
(2, 'Artikel', 'artikel', 'Kategori untuk artikel umum', NULL, NULL, NULL, 2, 1, '2025-11-19 01:28:18', '2025-11-19 01:28:18'),
(3, 'Pengumuman', 'pengumuman', 'Kategori untuk pengumuman', NULL, NULL, NULL, 3, 1, '2025-11-19 01:28:18', '2025-11-19 01:28:18'),
(4, 'Kegiatan', 'kegiatan', 'Kategori untuk kegiatan sekolah', NULL, NULL, NULL, 4, 1, '2025-11-19 01:28:18', '2025-11-19 01:28:18');

-- --------------------------------------------------------

--
-- Table structure for table `galleries`
--

CREATE TABLE `galleries` (
  `id` bigint(20) NOT NULL,
  `title` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `cover_image` varchar(255) DEFAULT NULL,
  `gallery_type` varchar(20) DEFAULT 'photo',
  `event_date` date DEFAULT NULL,
  `author_id` bigint(20) NOT NULL,
  `views_count` int(11) DEFAULT 0,
  `is_featured` tinyint(1) DEFAULT 0,
  `display_order` int(11) DEFAULT 0,
  `status` varchar(20) DEFAULT 'published',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `galleries`
--

INSERT INTO `galleries` (`id`, `title`, `slug`, `description`, `cover_image`, `gallery_type`, `event_date`, `author_id`, `views_count`, `is_featured`, `display_order`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Perayaan HUT RI ke-80', 'perayaan-hut-ri-78', 'Dokumentasi perayaan HUT RI', 'uploads/gallery/hut-ri-cover.jpg', NULL, '2023-08-17', 8, 0, 1, 1, 'published', '2025-11-20 10:40:02', '2025-11-20 10:41:36', '2025-11-20 10:41:36');

-- --------------------------------------------------------

--
-- Table structure for table `gallery_items`
--

CREATE TABLE `gallery_items` (
  `id` bigint(20) NOT NULL,
  `gallery_id` bigint(20) NOT NULL,
  `file_path` varchar(255) NOT NULL,
  `file_type` varchar(20) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `caption` varchar(500) DEFAULT NULL,
  `file_size` int(11) DEFAULT NULL,
  `mime_type` varchar(100) DEFAULT NULL,
  `width` int(11) DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  `duration` int(11) DEFAULT NULL,
  `display_order` int(11) DEFAULT 0,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `media_library`
--

CREATE TABLE `media_library` (
  `id` bigint(20) NOT NULL,
  `file_name` varchar(255) NOT NULL,
  `file_path` varchar(255) NOT NULL,
  `file_type` varchar(20) NOT NULL,
  `mime_type` varchar(100) NOT NULL,
  `file_size` bigint(20) NOT NULL,
  `alt_text` varchar(255) DEFAULT NULL,
  `caption` text DEFAULT NULL,
  `width` int(11) DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  `duration` int(11) DEFAULT NULL,
  `uploaded_by` bigint(20) NOT NULL,
  `used_count` int(11) DEFAULT 0,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `media_library`
--

INSERT INTO `media_library` (`id`, `file_name`, `file_path`, `file_type`, `mime_type`, `file_size`, `alt_text`, `caption`, `width`, `height`, `duration`, `uploaded_by`, `used_count`, `created_at`) VALUES
(1, 'school-logo-2025.png', 'uploads/images/school-logo.png', 'image', 'image/png', 102400, 'Logo SD Negeri Bandarharjo 2025', 'Logo resmi sekolah tahun ajaran 2025', 512, 512, NULL, 8, 0, '2025-11-20 11:26:14'),
(2, 'panduan-siswa.pdf', 'uploads/documents/panduan-siswa.pdf', 'document', 'application/pdf', 2048000, 'Panduan untuk siswa baru', 'Buku panduan siswa tahun 2025', NULL, NULL, NULL, 8, 0, '2025-11-20 11:26:51');

-- --------------------------------------------------------

--
-- Table structure for table `menus`
--

CREATE TABLE `menus` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `location` varchar(50) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `menus`
--

INSERT INTO `menus` (`id`, `name`, `location`, `created_at`, `updated_at`) VALUES
(1, 'Main Menu', 'header', '2025-11-20 14:06:28', '2025-11-20 14:06:28');

-- --------------------------------------------------------

--
-- Table structure for table `menu_items`
--

CREATE TABLE `menu_items` (
  `id` int(11) NOT NULL,
  `menu_id` int(11) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `label` varchar(100) NOT NULL,
  `url` varchar(255) DEFAULT NULL,
  `link_type` varchar(20) NOT NULL,
  `link_id` int(11) DEFAULT NULL,
  `icon` varchar(50) DEFAULT NULL,
  `css_class` varchar(100) DEFAULT NULL,
  `target` varchar(20) DEFAULT '_self',
  `display_order` int(11) DEFAULT 0,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `type` varchar(50) NOT NULL,
  `title` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`data`)),
  `is_read` tinyint(1) DEFAULT 0,
  `read_at` timestamp NULL DEFAULT NULL,
  `action_url` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`id`, `user_id`, `type`, `title`, `message`, `data`, `is_read`, `read_at`, `action_url`, `created_at`) VALUES
(2, 8, 'announcement', 'Pengumuman Penting', 'Libur sekolah akan dimulai tanggal 20 Desember 2025', NULL, 1, '2025-11-20 14:22:49', '/announcements', '2025-11-20 14:20:07'),
(3, 9, 'announcement', 'Pengumuman Penting', 'Libur sekolah akan dimulai tanggal 20 Desember 2025', NULL, 0, NULL, '/announcements', '2025-11-20 14:20:07'),
(4, 10, 'announcement', 'Pengumuman Penting', 'Libur sekolah akan dimulai tanggal 20 Desember 2025', NULL, 0, NULL, '/announcements', '2025-11-20 14:20:07'),
(5, 11, 'announcement', 'Pengumuman Penting', 'Libur sekolah akan dimulai tanggal 20 Desember 2025', NULL, 0, NULL, '/announcements', '2025-11-20 14:20:07'),
(6, 12, 'announcement', 'Pengumuman Penting', 'Libur sekolah akan dimulai tanggal 20 Desember 2025', NULL, 0, NULL, '/announcements', '2025-11-20 14:20:07'),
(7, 13, 'announcement', 'Pengumuman Penting', 'Libur sekolah akan dimulai tanggal 20 Desember 2025', NULL, 0, NULL, '/announcements', '2025-11-20 14:20:07');

-- --------------------------------------------------------

--
-- Table structure for table `pages`
--

CREATE TABLE `pages` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `content` longtext NOT NULL,
  `page_template` varchar(50) DEFAULT 'default',
  `parent_id` int(11) DEFAULT NULL,
  `display_order` int(11) DEFAULT 0,
  `meta_title` varchar(200) DEFAULT NULL,
  `meta_description` text DEFAULT NULL,
  `meta_keywords` text DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `show_in_menu` tinyint(1) DEFAULT 1,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pages`
--

INSERT INTO `pages` (`id`, `title`, `slug`, `content`, `page_template`, `parent_id`, `display_order`, `meta_title`, `meta_description`, `meta_keywords`, `is_active`, `show_in_menu`, `created_at`, `updated_at`) VALUES
(2, 'Kontak Kami', 'kontak-kami', '<p>098776542345</p>', NULL, NULL, 1, 'Tentang Kami - SMA Negeri 1 Jakarta', 'Profil dan sejarah SMA Negeri 1 Jakarta', 'tentang, profil, sejarah, sma', 1, 0, '2025-11-20 10:30:46', '2025-11-20 10:30:46'),
(3, 'Kontak Kami bandar', 'kontak-kami-bandar', '<p>098776542345</p>', NULL, NULL, 1, 'Tentang Kami - SMA Negeri 1 Jakarta', 'Profil dan sejarah SMA Negeri 1 Jakarta', 'tentang, profil, sejarah, sma', 1, 0, '2025-11-20 10:33:51', '2025-11-20 10:33:51');

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `display_name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `module` varchar(50) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `display_name`, `description`, `module`, `created_at`) VALUES
(1, 'users.edit', 'Edit Users', 'Can edit user details and permissions', 'users', '2025-11-20 15:53:22');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `id` bigint(20) NOT NULL,
  `title` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `excerpt` text DEFAULT NULL,
  `content` longtext NOT NULL,
  `featured_image` varchar(255) DEFAULT NULL,
  `post_type` varchar(20) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `author_id` bigint(20) NOT NULL,
  `status` varchar(20) DEFAULT 'draft',
  `views_count` int(11) DEFAULT 0,
  `published_at` timestamp NULL DEFAULT NULL,
  `scheduled_at` timestamp NULL DEFAULT NULL,
  `meta_title` varchar(200) DEFAULT NULL,
  `meta_description` text DEFAULT NULL,
  `meta_keywords` text DEFAULT NULL,
  `is_featured` tinyint(1) DEFAULT 0,
  `allow_comments` tinyint(1) DEFAULT 1,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`id`, `title`, `slug`, `excerpt`, `content`, `featured_image`, `post_type`, `category_id`, `author_id`, `status`, `views_count`, `published_at`, `scheduled_at`, `meta_title`, `meta_description`, `meta_keywords`, `is_featured`, `allow_comments`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Selamat Datang di SD Negeri Bandarharjo', 'selamat-datang-di-sd-negeri-bandarharjo', 'Artikel pertama di website kami yang membahas tentang sejarah dan visi misi sekolah', '<p>SD Negeri Bandarharjo adalah sekolah dasar negeri yang berlokasi di Bandarharjo. Sekolah kami telah berdiri sejak tahun 1975 dan telah meluluskan ribuan siswa yang sukses.</p><p>Dengan tenaga pengajar yang berkualitas dan fasilitas yang memadai, kami berkomitmen untuk memberikan pendidikan terbaik bagi anak-anak Indonesia.</p>', '/uploads/posts/welcome.jpg', 'article', 1, 8, 'published', 1, '2025-11-19 01:31:04', NULL, 'Selamat Datang di SD Negeri Bandarharjo', 'Mengenal lebih dekat SD Negeri Bandarharjo, sekolah dengan kualitas pendidikan terbaik', 'SD Negeri Bandarharjo, sekolah dasar, pendidikan, Bandarharjo', 1, 1, '2025-11-19 01:31:04', '2025-11-19 03:19:28', NULL),
(2, 'Selamat Datang di SD Negeri Bandarharjo', 'selamat-datang-di-sd-negeri-bandarharjo-1', 'Artikel pertama di website kami yang membahas tentang sejarah dan visi misi sekolah', '<p>awoakowakowkaowkaowkaok.</p>', '/uploads/posts/welcome.jpg', 'article', 1, 8, 'draft', 1, NULL, NULL, 'Selamat Datang di SD Negeri Bandarharjo', 'Mengenal lebih dekat SD Negeri Bandarharjo, sekolah dengan kualitas pendidikan terbaik', 'SD Negeri Bandarharjo, sekolah dasar, pendidikan, Bandarharjo', 0, 1, '2025-11-19 02:48:12', '2025-11-20 01:44:35', NULL),
(3, 'Selamat Datang di SD Negeri Bandarharjo', 'selamat-datang-di-sd-negeri-bandarharjo-2', 'Artikel pertama di website kami yang membahas tentang sejarah dan visi misi sekolah', '<p>update1.</p>', '/uploads/posts/welcome.jpg', 'article', 1, 8, 'draft', 0, NULL, NULL, 'Selamat Datang di SD Negeri Bandarharjo', 'Mengenal lebih dekat SD Negeri Bandarharjo, sekolah dengan kualitas pendidikan terbaik', 'SD Negeri Bandarharjo, sekolah dasar, pendidikan, Bandarharjo', 1, 1, '2025-11-19 02:48:49', '2025-11-19 02:48:49', NULL),
(4, 'Ini adalah SDN 1 Bandarharjo - update', 'ini-adalah-sdn-1-bandarharjo-update', 'Artikel pertama di website kami yang membahas tentang sejarah dan visi misi sekolah', '<p>sudah di update.</p>', '/uploads/posts/welcome.jpg', 'article', 1, 8, 'published', 1, NULL, NULL, 'Selamat Datang di SD Negeri Bandarharjo', 'Mengenal lebih dekat SD Negeri Bandarharjo, sekolah dengan kualitas pendidikan terbaik', 'SD Negeri Bandarharjo, sekolah dasar, pendidikan, Bandarharjo', 1, 1, '2025-11-19 03:57:25', '2025-11-20 06:24:10', NULL),
(5, 'Test Post', 'test-post', 'Test excerpt', '<p>This is test content</p>', '/uploads/posts/image.jpg', 'article', 1, 8, 'published', 0, '2025-11-20 01:51:25', NULL, NULL, NULL, NULL, 1, 1, '2025-11-20 01:51:25', '2025-11-20 01:51:25', NULL),
(6, 'Test Post 2', 'test-post-2', 'Test excerpt', '<p>This is test content</p>', '/uploads/posts/image.jpg', 'article', 1, 8, 'published', 0, '2025-11-20 01:53:12', NULL, NULL, NULL, NULL, 0, 1, '2025-11-20 01:53:12', '2025-11-20 06:24:04', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `post_tags`
--

CREATE TABLE `post_tags` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `slug` varchar(50) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `post_tag_relations`
--

CREATE TABLE `post_tag_relations` (
  `id` bigint(20) NOT NULL,
  `post_id` bigint(20) NOT NULL,
  `tag_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `display_name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `display_name`, `description`, `created_at`, `updated_at`) VALUES
(1, 'super_admin', 'Super Administrator', 'Full system access', '2025-11-15 03:56:46', '2025-11-15 03:56:46'),
(2, 'admin', 'Administrator', 'School administrator', '2025-11-15 03:56:46', '2025-11-15 03:56:46'),
(3, 'teacher', 'Teacher', 'Teacher account', '2025-11-15 03:56:46', '2025-11-15 03:56:46'),
(4, 'staff', 'Staff', 'School staff', '2025-11-15 03:56:46', '2025-11-15 03:56:46'),
(5, 'user', 'User', 'Regular user', '2025-11-15 03:56:46', '2025-11-15 03:56:46');

-- --------------------------------------------------------

--
-- Table structure for table `role_permissions`
--

CREATE TABLE `role_permissions` (
  `id` bigint(20) NOT NULL,
  `role_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `school_profiles`
--

CREATE TABLE `school_profiles` (
  `id` int(11) NOT NULL,
  `school_name` varchar(200) NOT NULL,
  `npsn` varchar(20) DEFAULT NULL,
  `address` text NOT NULL,
  `city` varchar(100) DEFAULT NULL,
  `province` varchar(100) DEFAULT NULL,
  `postal_code` varchar(10) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `fax` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `favicon` varchar(255) DEFAULT NULL,
  `vision` text DEFAULT NULL,
  `mission` text DEFAULT NULL,
  `goals` text DEFAULT NULL,
  `established_year` year(4) DEFAULT NULL,
  `accreditation` varchar(5) DEFAULT NULL,
  `principal_name` varchar(100) DEFAULT NULL,
  `principal_photo` varchar(255) DEFAULT NULL,
  `latitude` decimal(10,8) DEFAULT NULL,
  `longitude` decimal(11,8) DEFAULT NULL,
  `facebook_url` varchar(255) DEFAULT NULL,
  `instagram_url` varchar(255) DEFAULT NULL,
  `twitter_url` varchar(255) DEFAULT NULL,
  `youtube_url` varchar(255) DEFAULT NULL,
  `meta_title` varchar(200) DEFAULT NULL,
  `meta_description` text DEFAULT NULL,
  `meta_keywords` text DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `school_profiles`
--

INSERT INTO `school_profiles` (`id`, `school_name`, `npsn`, `address`, `city`, `province`, `postal_code`, `phone`, `fax`, `email`, `website`, `logo`, `favicon`, `vision`, `mission`, `goals`, `established_year`, `accreditation`, `principal_name`, `principal_photo`, `latitude`, `longitude`, `facebook_url`, `instagram_url`, `twitter_url`, `youtube_url`, `meta_title`, `meta_description`, `meta_keywords`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'SMA Negeri 1 Jakarta', '20100001', 'Jl. Pendidikan No. 123', 'Jakarta Pusat', 'DKI Jakarta', '10310', '021-12345678', '021-87654321', 'info@sman1jakarta.sch.id', 'https://www.sman1jakarta.sch.id', 'uploads/logo/school-logo.png', NULL, 'Menjadi sekolah unggulan...', '1. Menyelenggarakan pendidikan...', NULL, NULL, 'A', 'Dr. Ahmad Suryadi, M.Pd', NULL, NULL, NULL, 'https://facebook.com/sman1jakarta', 'https://instagram.com/sman1jakarta', 'https://twitter.com/sman1jakarta', 'https://youtube.com/@sman1jakarta', NULL, NULL, NULL, 1, '2025-11-20 10:21:46', '2025-11-20 10:21:46');

-- --------------------------------------------------------

--
-- Table structure for table `seo_metadata`
--

CREATE TABLE `seo_metadata` (
  `id` bigint(20) NOT NULL,
  `model_type` varchar(100) NOT NULL,
  `model_id` bigint(20) NOT NULL,
  `og_title` varchar(255) DEFAULT NULL,
  `og_description` text DEFAULT NULL,
  `og_image` varchar(255) DEFAULT NULL,
  `og_type` varchar(50) DEFAULT NULL,
  `twitter_card` varchar(50) DEFAULT NULL,
  `twitter_title` varchar(255) DEFAULT NULL,
  `twitter_description` text DEFAULT NULL,
  `twitter_image` varchar(255) DEFAULT NULL,
  `canonical_url` varchar(255) DEFAULT NULL,
  `robots_meta` varchar(100) DEFAULT NULL,
  `schema_markup` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`schema_markup`)),
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `id` int(11) NOT NULL,
  `key_name` varchar(100) NOT NULL,
  `key_value` text DEFAULT NULL,
  `data_type` varchar(20) DEFAULT 'string',
  `group_name` varchar(50) NOT NULL,
  `description` text DEFAULT NULL,
  `is_public` tinyint(1) DEFAULT 0,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `key_name`, `key_value`, `data_type`, `group_name`, `description`, `is_public`, `created_at`, `updated_at`) VALUES
(1, 'site_name', 'SD Negeri Bandarharjo', 'text', 'general', 'Nama website sekolah', 1, '2025-11-20 10:56:19', '2025-11-20 11:12:52'),
(2, 'site_tagline', 'Sekolah Berkualitas dan Berkarakter', 'text', 'general', 'Tagline website', 1, '2025-11-20 10:56:19', '2025-11-20 11:12:52'),
(3, 'timezone', 'Asia/Jakarta', 'text', 'general', 'Zona waktu', 0, '2025-11-20 10:56:19', '2025-11-20 11:12:52'),
(4, 'language', 'id', 'text', 'general', 'Bahasa default', 0, '2025-11-20 10:56:19', '2025-11-20 11:12:52'),
(5, 'contact_email', 'info@sdnbandarharjo.sch.id', 'text', 'contact', 'Email kontak', 1, '2025-11-20 10:56:19', '2025-11-20 11:12:52'),
(6, 'contact_phone', '0281-1234567', 'text', 'contact', 'Nomor telepon', 1, '2025-11-20 10:56:19', '2025-11-20 11:12:52'),
(7, 'contact_address', 'Jl. Pendidikan No. 123, Pati, Jawa Tengah', 'text', 'contact', 'Alamat sekolah', 1, '2025-11-20 10:56:19', '2025-11-20 11:12:52'),
(8, 'contact_fax', '', 'text', 'contact', 'Nomor fax', 1, '2025-11-20 10:56:19', '2025-11-20 11:12:52'),
(9, 'facebook_url', '', 'text', 'social', 'URL Facebook', 1, '2025-11-20 10:56:19', '2025-11-20 11:12:52'),
(10, 'instagram_url', '', 'text', 'social', 'URL Instagram', 1, '2025-11-20 10:56:19', '2025-11-20 11:12:52'),
(11, 'twitter_url', '', 'text', 'social', 'URL Twitter', 1, '2025-11-20 10:56:19', '2025-11-20 11:12:52'),
(12, 'youtube_url', '', 'text', 'social', 'URL YouTube', 1, '2025-11-20 10:56:19', '2025-11-20 11:12:52'),
(13, 'tiktok_url', '', 'text', 'social', 'URL TikTok', 1, '2025-11-20 10:56:19', '2025-11-20 11:12:52'),
(14, 'maintenance_mode', 'false', 'boolean', 'system', 'Mode maintenance', 0, '2025-11-20 10:56:19', '2025-11-20 11:12:52'),
(15, 'enable_registration', 'true', 'boolean', 'system', 'Aktifkan registrasi user', 0, '2025-11-20 10:56:19', '2025-11-20 11:12:52'),
(16, 'enable_comments', 'true', 'boolean', 'system', 'Aktifkan komentar', 0, '2025-11-20 10:56:19', '2025-11-20 11:12:52'),
(17, 'comment_moderation', 'true', 'boolean', 'system', 'Moderasi komentar', 0, '2025-11-20 10:56:19', '2025-11-20 11:12:52'),
(18, 'posts_per_page', '10', 'number', 'display', 'Jumlah post per halaman', 0, '2025-11-20 10:56:19', '2025-11-20 11:12:52'),
(19, 'galleries_per_page', '12', 'number', 'display', 'Jumlah gallery per halaman', 0, '2025-11-20 10:56:19', '2025-11-20 11:12:52'),
(20, 'meta_title', 'SD Negeri Bandarharjo', 'text', 'seo', 'Meta title default', 1, '2025-11-20 10:56:19', '2025-11-20 11:12:52'),
(21, 'meta_description', 'Website resmi SD Negeri Bandarharjo, Pati, Jawa Tengah', 'text', 'seo', 'Meta description default', 1, '2025-11-20 10:56:19', '2025-11-20 11:12:52'),
(22, 'meta_keywords', 'sekolah, pendidikan, sd, bandarharjo, pati', 'text', 'seo', 'Meta keywords default', 1, '2025-11-20 10:56:19', '2025-11-20 11:12:52'),
(29, 'smtp_username', '', 'text', 'email', 'SMTP Username', 0, '2025-11-20 10:56:19', '2025-11-20 10:56:19'),
(30, 'smtp_password', '', 'text', 'email', 'SMTP Password', 0, '2025-11-20 10:56:19', '2025-11-20 10:56:19'),
(31, 'email_from_name', 'SD Negeri Bandarharjo', 'text', 'email', 'Email from name', 0, '2025-11-20 10:56:19', '2025-11-20 10:56:19'),
(32, 'email_from_address', 'noreply@sdnbandarharjo.sch.id', 'text', 'email', 'Email from address', 0, '2025-11-20 10:56:19', '2025-11-20 10:56:19');

-- --------------------------------------------------------

--
-- Table structure for table `sliders`
--

CREATE TABLE `sliders` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `image` varchar(255) NOT NULL,
  `link_url` varchar(255) DEFAULT NULL,
  `link_text` varchar(100) DEFAULT NULL,
  `link_target` varchar(20) DEFAULT '_self',
  `button_style` varchar(50) DEFAULT NULL,
  `display_order` int(11) DEFAULT 0,
  `is_active` tinyint(1) DEFAULT 1,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `teachers`
--

CREATE TABLE `teachers` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `nip` varchar(30) DEFAULT NULL,
  `full_name` varchar(100) NOT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `position` varchar(100) DEFAULT NULL,
  `subject` varchar(100) DEFAULT NULL,
  `class_name` varchar(50) DEFAULT NULL,
  `education_level` varchar(50) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `bio` text DEFAULT NULL,
  `join_date` date DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `display_order` int(11) DEFAULT 0,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `teachers`
--

INSERT INTO `teachers` (`id`, `user_id`, `nip`, `full_name`, `photo`, `position`, `subject`, `class_name`, `education_level`, `email`, `phone`, `bio`, `join_date`, `is_active`, `display_order`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, NULL, NULL, 'Budi Santoso Updated, S.Pd, M.M', NULL, NULL, 'Matematika & IPA', NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, '2025-11-19 07:06:13', '2025-11-20 09:19:38', NULL),
(3, NULL, '089789079867511112', 'John Doe S.Pd, S.Kom', NULL, 'Guru Kelas', 'Bahasa Indonesia', 'Kelas 5', NULL, 'John@example.com', '0986785671', NULL, NULL, 0, 0, '2025-11-20 09:19:09', '2025-11-20 09:38:23', NULL),
(4, NULL, '089789079867511111', 'John Doe S.Pd', NULL, 'Guru Kelas', 'Bahasa Indonesia', 'Kelas 5', NULL, 'John@example.com', '0986785671', NULL, NULL, 1, 0, '2025-11-20 09:33:55', '2025-11-20 10:15:04', NULL),
(5, NULL, '0897890798675111124', 'Bambang pamungkas S.Pd, S.Kom', NULL, 'Guru Kelas', 'Bahasa Indonesia', 'Kelas 5', NULL, 'John@example.com', '0986785671', NULL, NULL, 1, 0, '2025-11-20 09:36:05', '2025-11-20 09:36:32', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `role_id` int(11) NOT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `last_login_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password_hash`, `full_name`, `phone`, `role_id`, `avatar`, `is_active`, `email_verified_at`, `remember_token`, `last_login_at`, `created_at`, `updated_at`, `deleted_at`) VALUES
(8, 'admin', 'adminsenior2@example.com', '$2a$10$ed72JRwlo9w8WD8u3TguP.7Sq2839eNB73UUZYXq5UcrIOokVr.9O', 'Updated Name 2', '081234567999', 2, 'icik bos', 1, NULL, NULL, '2025-11-20 14:59:28', '2025-11-19 01:11:46', '2025-11-20 14:59:28', NULL),
(9, 'newuser', 'newuser1@sdnbandarharjo.sch.id', '$2a$10$9qlcSXY8TU3qvij.vtBF..dEOfD9nAYxz1m/59sQXhtI23CyoFTti', 'senior user', '081234567899', 5, 'apalah avatar', 1, NULL, NULL, NULL, '2025-11-19 01:41:45', '2025-11-19 01:44:44', NULL),
(10, 'bambang', 'bb@example.com', '$2a$10$xMytRizZzhz5cLypErvU4uhxyl6umFyVmkhdTLO30xEMdXbpOa0/i', 'bambang pencak silat', '081234567890', 5, NULL, 1, NULL, NULL, NULL, '2025-11-19 01:53:38', '2025-11-19 02:16:39', '2025-11-19 02:16:39'),
(11, 'admin2', 'newadmin@sdnbandarharjo.sch.id', '$2a$10$P0vHasl6dX/UYhjF9sUrv.utmxhZlgxqR4QB811.QGez8.hazQocu', 'New admin', '081234565561', 2, 'null', 1, NULL, NULL, NULL, '2025-11-19 02:01:40', '2025-11-19 02:01:40', NULL),
(12, 'testuser', 'test@example.com', '$2a$10$1McU.iqP3vGbFPzNTP.tpu9er3cMVLaABBeLHOqoJETxk1kW.EZO2', 'Test User', '081234567890', 5, NULL, 1, NULL, NULL, NULL, '2025-11-20 01:18:42', '2025-11-20 01:18:42', NULL),
(13, 'newuser2', 'updated111@example.com', '$2a$10$Z0sWFT1zR70CMao9tRrgsueH1t5xw1sN613u8qWvs/Z1JoLEpgOTy', 'Updated Name', '08978968777', 5, NULL, 1, NULL, NULL, NULL, '2025-11-20 01:29:40', '2025-11-20 01:38:54', '2025-11-20 01:38:54'),
(15, 'superadmin', 'superadmin@sdnbandarharjo.sch.id', '$2a$10$IOjcvQTdCNLLwYZYH7/ybOoxnj.dVsFVZxr5sF05Z7.aPaLAU6LXy', 'Super Administrator', '081234567890', 1, NULL, 1, NULL, NULL, '2025-11-20 16:31:29', '2025-11-20 15:02:29', '2025-11-20 16:31:29', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `activity_logs`
--
ALTER TABLE `activity_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `post_id` (`post_id`),
  ADD KEY `parent_id` (`parent_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `complaints`
--
ALTER TABLE `complaints`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ticket_number` (`ticket_number`),
  ADD KEY `assigned_to` (`assigned_to`),
  ADD KEY `resolved_by` (`resolved_by`);

--
-- Indexes for table `complaint_responses`
--
ALTER TABLE `complaint_responses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `complaint_id` (`complaint_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `contact_messages`
--
ALTER TABLE `contact_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `replied_by` (`replied_by`);

--
-- Indexes for table `content_categories`
--
ALTER TABLE `content_categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD KEY `parent_id` (`parent_id`);

--
-- Indexes for table `galleries`
--
ALTER TABLE `galleries`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD KEY `author_id` (`author_id`);

--
-- Indexes for table `gallery_items`
--
ALTER TABLE `gallery_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `gallery_id` (`gallery_id`);

--
-- Indexes for table `media_library`
--
ALTER TABLE `media_library`
  ADD PRIMARY KEY (`id`),
  ADD KEY `uploaded_by` (`uploaded_by`);

--
-- Indexes for table `menus`
--
ALTER TABLE `menus`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `menu_items`
--
ALTER TABLE `menu_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `menu_id` (`menu_id`),
  ADD KEY `parent_id` (`parent_id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `pages`
--
ALTER TABLE `pages`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD KEY `parent_id` (`parent_id`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD KEY `module` (`module`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD KEY `category_id` (`category_id`),
  ADD KEY `author_id` (`author_id`);

--
-- Indexes for table `post_tags`
--
ALTER TABLE `post_tags`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`);

--
-- Indexes for table `post_tag_relations`
--
ALTER TABLE `post_tag_relations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `post_tag` (`post_id`,`tag_id`),
  ADD KEY `tag_id` (`tag_id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `role_permissions`
--
ALTER TABLE `role_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `role_permission` (`role_id`,`permission_id`),
  ADD KEY `permission_id` (`permission_id`);

--
-- Indexes for table `school_profiles`
--
ALTER TABLE `school_profiles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `npsn` (`npsn`);

--
-- Indexes for table `seo_metadata`
--
ALTER TABLE `seo_metadata`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `model_type` (`model_type`,`model_id`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `key_name` (`key_name`);

--
-- Indexes for table `sliders`
--
ALTER TABLE `sliders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `teachers`
--
ALTER TABLE `teachers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nip` (`nip`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `role_id` (`role_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `activity_logs`
--
ALTER TABLE `activity_logs`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `complaints`
--
ALTER TABLE `complaints`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `complaint_responses`
--
ALTER TABLE `complaint_responses`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `contact_messages`
--
ALTER TABLE `contact_messages`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `content_categories`
--
ALTER TABLE `content_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `galleries`
--
ALTER TABLE `galleries`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `gallery_items`
--
ALTER TABLE `gallery_items`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `media_library`
--
ALTER TABLE `media_library`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `menus`
--
ALTER TABLE `menus`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `menu_items`
--
ALTER TABLE `menu_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `pages`
--
ALTER TABLE `pages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `post_tags`
--
ALTER TABLE `post_tags`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `post_tag_relations`
--
ALTER TABLE `post_tag_relations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `role_permissions`
--
ALTER TABLE `role_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `school_profiles`
--
ALTER TABLE `school_profiles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `seo_metadata`
--
ALTER TABLE `seo_metadata`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=109;

--
-- AUTO_INCREMENT for table `sliders`
--
ALTER TABLE `sliders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `teachers`
--
ALTER TABLE `teachers`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
