-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 27 Nov 2025 pada 04.04
-- Versi server: 10.4.32-MariaDB
-- Versi PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `kp_diskominfo`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `galleries`
--

CREATE TABLE `galleries` (
  `id` int(11) NOT NULL,
  `title` varchar(200) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `descr` text DEFAULT NULL,
  `img` varchar(255) DEFAULT NULL,
  `video` varchar(255) DEFAULT NULL,
  `status` enum('draft','published','archived') NOT NULL DEFAULT 'draft',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `galleries`
--

INSERT INTO `galleries` (`id`, `title`, `slug`, `descr`, `img`, `video`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'SISWA BERPRESTASI', '', 'wquidfgaslbdqwjbdiouqbwd', 'C:\\Users\\NHQE1\\OneDrive\\Documents\\KP\\Kp_Backend\\uploads\\general\\img1-1763952248028-837016918.jpeg', '', 'draft', '2025-11-24 02:44:08', '2025-11-24 02:44:08', NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `posts`
--

CREATE TABLE `posts` (
  `id` int(11) NOT NULL,
  `author_id` int(11) DEFAULT NULL,
  `title` varchar(200) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `content` longtext NOT NULL,
  `status` enum('draft','published','archived') NOT NULL DEFAULT 'draft',
  `img_url` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `posts`
--

INSERT INTO `posts` (`id`, `author_id`, `title`, `slug`, `content`, `status`, `img_url`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 2, 'Test Post 2', 'test-post-2', '<p>This is test content</p>', 'draft', NULL, '2025-11-24 01:41:35', '2025-11-24 01:41:35', NULL),
(2, 2, 'test upload 22', 'test-upload-22', 'isi content 2', '', '/uploads/posts/img2-1763950722669-926283800.jpeg', '2025-11-24 01:52:48', '2025-11-24 02:19:10', '2025-11-24 02:19:10'),
(3, 2, 'test upload 1', 'test-upload-1', 'isi content', '', '/uploads/posts/img1-1763950249143-603873430.jpeg', '2025-11-24 02:10:49', '2025-11-24 02:10:49', NULL),
(4, 2, 'test upload 2', 'test-upload-2', 'isi content 2', '', '/uploads/posts/img2-1763950349825-661990325.jpeg', '2025-11-24 02:12:29', '2025-11-24 02:12:29', NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `profiles`
--

CREATE TABLE `profiles` (
  `id` int(11) NOT NULL,
  `school_name` varchar(200) NOT NULL,
  `npsn` varchar(20) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `website` varchar(100) DEFAULT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `accreditation` varchar(5) DEFAULT NULL,
  `principal_name` varchar(100) DEFAULT NULL,
  `principal_photo` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `profiles`
--

INSERT INTO `profiles` (`id`, `school_name`, `npsn`, `address`, `phone`, `email`, `website`, `logo`, `accreditation`, `principal_name`, `principal_photo`, `created_at`, `updated_at`) VALUES
(1, 'SDN BandarHarjo 01', '20329336', 'Jl. Cumi-Cumi Raya No.2, Bandarharjo, Kec. Semarang Utara, Kota Semarang, Jawa Tengah ', '(024) 3551189', '', '', 'C:\\Users\\NHQE1\\OneDrive\\Documents\\KP\\Kp_Backend\\uploads\\general\\img1-1763951939588-734946277.jpeg', '', '', 'C:\\Users\\NHQE1\\OneDrive\\Documents\\KP\\Kp_Backend\\uploads\\general\\img2-1763951939589-727057173.jpeg', '2025-11-24 02:36:30', '2025-11-24 02:38:59');

-- --------------------------------------------------------

--
-- Struktur dari tabel `roles`
--

CREATE TABLE `roles` (
  `id` int(11) NOT NULL,
  `display_name` varchar(50) NOT NULL,
  `descrip` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `roles`
--

INSERT INTO `roles` (`id`, `display_name`, `descrip`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'Administrator dengan akses penuh', '2025-11-23 12:56:40', '2025-11-23 12:56:40'),
(2, 'teacher', 'Guru yang dapat mengelola konten terkait pengajaran', '2025-11-23 12:56:40', '2025-11-23 12:56:40'),
(3, 'staff', 'Staff sekolah dengan akses terbatas', '2025-11-23 12:56:40', '2025-11-23 12:56:40');

-- --------------------------------------------------------

--
-- Struktur dari tabel `students`
--

CREATE TABLE `students` (
  `id` int(11) NOT NULL,
  `nisn` varchar(20) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `class` varchar(20) NOT NULL,
  `gender` enum('L','P') NOT NULL,
  `score_uts` decimal(5,2) DEFAULT NULL,
  `score_uas` decimal(5,2) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `students`
--

INSERT INTO `students` (`id`, `nisn`, `name`, `class`, `gender`, `score_uts`, `score_uas`, `created_at`, `updated_at`) VALUES
(1, '09876545231312', 'Budi Santoso', '5A', 'L', 85.00, 90.00, '2025-11-27 01:58:04', '2025-11-27 01:58:04');

-- --------------------------------------------------------

--
-- Struktur dari tabel `subjects`
--

CREATE TABLE `subjects` (
  `id` int(11) NOT NULL,
  `subject_name` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `subjects`
--

INSERT INTO `subjects` (`id`, `subject_name`, `created_at`, `updated_at`) VALUES
(1, 'Matematika', '2025-11-23 12:57:11', '2025-11-23 12:57:11'),
(2, 'Bahasa Indonesia', '2025-11-23 12:57:11', '2025-11-23 12:57:11'),
(3, 'Bahasa Inggris', '2025-11-23 12:57:11', '2025-11-23 12:57:11'),
(4, 'IPA', '2025-11-23 12:57:11', '2025-11-23 12:57:11'),
(5, 'IPS', '2025-11-23 12:57:11', '2025-11-23 12:57:11'),
(6, 'Pendidikan Agama', '2025-11-23 12:57:11', '2025-11-23 12:57:11'),
(7, 'Pendidikan Jasmani', '2025-11-23 12:57:11', '2025-11-23 12:57:11'),
(8, 'Seni Budaya', '2025-11-23 12:57:11', '2025-11-23 12:57:11'),
(9, 'Prakarya', '2025-11-23 12:57:11', '2025-11-23 12:57:11'),
(10, 'Bahasa Jawa', '2025-11-23 12:57:11', '2025-11-23 12:57:11');

-- --------------------------------------------------------

--
-- Struktur dari tabel `teachers`
--

CREATE TABLE `teachers` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `nip` varchar(30) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `subject_id` int(11) DEFAULT NULL,
  `class_name` varchar(50) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `bio` text DEFAULT NULL,
  `join_date` date DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `teachers`
--

INSERT INTO `teachers` (`id`, `user_id`, `nip`, `name`, `photo`, `subject_id`, `class_name`, `email`, `phone`, `bio`, `join_date`, `is_active`, `created_at`, `updated_at`, `deleted_at`) VALUES
(3, 2, '1978121212340001', 'Siti Nurjanah', NULL, 2, '4A', 'siti.nurjanah@example.com', '081234567890', 'Guru Bahasa Indonesia dengan pengalaman 10 tahun', '2020-07-12', 1, '2025-11-24 03:00:05', '2025-11-24 03:00:05', NULL),
(6, 2, '1978121212340012', 'Siti Busika', NULL, 3, '4', 'siti.Bu@example.com', '08123450987', 'Guru Bahasa Inggris dengan pengalaman 10 tahun', '2020-07-12', 1, '2025-11-24 03:11:05', '2025-11-24 03:12:46', '2025-11-24 03:12:46'),
(8, 2, '2019283715623819', 'EL', NULL, 1, '5', 'EL@example.com', '0987654321', 'Kobokerszz ni boss', '2025-11-27', 1, '2025-11-27 01:09:14', '2025-11-27 01:09:14', NULL),
(9, 2, '1231526474373473476', 'fafa', NULL, 5, '7', 'fafa@example.com', '0987667586723', NULL, '2025-11-27', 1, '2025-11-27 01:17:51', '2025-11-27 01:17:51', NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password_hash` varchar(255) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `role_id` int(11) NOT NULL DEFAULT 3,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `last_login` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password_hash`, `full_name`, `phone`, `role_id`, `is_active`, `last_login`, `created_at`, `updated_at`, `deleted_at`) VALUES
(2, 'admin', 'adminpertama@example.com', '$2a$10$gRCL/fYtkjcjQLLKv8c1i.DWw03QYwv4JIT9QfruMYGvI2P48z7/S', 'Updated admin', '081234567999', 1, 1, '2025-11-27 08:52:18', '2025-11-23 15:07:12', '2025-11-27 01:52:18', NULL),
(5, 'testuser', 'testupdate@example.com', '$2a$10$HaUr0HMb65Wx1/oNReCcrOPaSH0Ujf1yAIeaHP9U.svJwP71YqTDm', 'Updated test', '08978968777', 2, 1, NULL, '2025-11-23 15:35:14', '2025-11-24 01:38:25', NULL),
(6, 'guru1', 'guru1@example.com', '$2a$10$Q8I.I6l8gGmbt/xrT407e.aKqTNevTqIWoMj2gPUjplSDnZaVLyBy', 'saya guru pertama', '0811111111111111', 2, 1, '2025-11-24 08:37:04', '2025-11-24 01:36:49', '2025-11-24 01:38:49', '2025-11-24 01:38:49'),
(7, 'testuser2', 'test@example.com', '$2a$10$H47eyhUsLvRvPt1652Emt.CdmsETqGyuqwcYrrIznba8o5tEIUFeG', 'Test User', '081234567890', 2, 1, NULL, '2025-11-24 01:39:39', '2025-11-24 01:39:39', NULL);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `view_posts_with_author`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `view_posts_with_author` (
`id` int(11)
,`title` varchar(200)
,`slug` varchar(255)
,`content` longtext
,`status` enum('draft','published','archived')
,`author_name` varchar(100)
,`created_at` timestamp
,`updated_at` timestamp
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `view_teachers_detail`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `view_teachers_detail` (
`id` int(11)
,`nip` varchar(30)
,`name` varchar(100)
,`photo` varchar(255)
,`subject_name` varchar(100)
,`class_name` varchar(50)
,`email` varchar(100)
,`phone` varchar(20)
,`bio` text
,`join_date` date
,`is_active` tinyint(1)
,`username` varchar(50)
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `view_users_with_roles`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `view_users_with_roles` (
`id` int(11)
,`username` varchar(50)
,`full_name` varchar(100)
,`phone` varchar(20)
,`role` varchar(50)
,`is_active` tinyint(1)
,`last_login` datetime
,`created_at` timestamp
);

-- --------------------------------------------------------

--
-- Struktur untuk view `view_posts_with_author`
--
DROP TABLE IF EXISTS `view_posts_with_author`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_posts_with_author`  AS SELECT `p`.`id` AS `id`, `p`.`title` AS `title`, `p`.`slug` AS `slug`, `p`.`content` AS `content`, `p`.`status` AS `status`, `u`.`full_name` AS `author_name`, `p`.`created_at` AS `created_at`, `p`.`updated_at` AS `updated_at` FROM (`posts` `p` left join `users` `u` on(`p`.`author_id` = `u`.`id`)) WHERE `p`.`deleted_at` is null ;

-- --------------------------------------------------------

--
-- Struktur untuk view `view_teachers_detail`
--
DROP TABLE IF EXISTS `view_teachers_detail`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_teachers_detail`  AS SELECT `t`.`id` AS `id`, `t`.`nip` AS `nip`, `t`.`name` AS `name`, `t`.`photo` AS `photo`, `s`.`subject_name` AS `subject_name`, `t`.`class_name` AS `class_name`, `t`.`email` AS `email`, `t`.`phone` AS `phone`, `t`.`bio` AS `bio`, `t`.`join_date` AS `join_date`, `t`.`is_active` AS `is_active`, `u`.`username` AS `username` FROM ((`teachers` `t` left join `subjects` `s` on(`t`.`subject_id` = `s`.`id`)) left join `users` `u` on(`t`.`user_id` = `u`.`id`)) WHERE `t`.`deleted_at` is null ;

-- --------------------------------------------------------

--
-- Struktur untuk view `view_users_with_roles`
--
DROP TABLE IF EXISTS `view_users_with_roles`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_users_with_roles`  AS SELECT `u`.`id` AS `id`, `u`.`username` AS `username`, `u`.`full_name` AS `full_name`, `u`.`phone` AS `phone`, `r`.`display_name` AS `role`, `u`.`is_active` AS `is_active`, `u`.`last_login` AS `last_login`, `u`.`created_at` AS `created_at` FROM (`users` `u` left join `roles` `r` on(`u`.`role_id` = `r`.`id`)) WHERE `u`.`deleted_at` is null ;

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `galleries`
--
ALTER TABLE `galleries`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`);

--
-- Indeks untuk tabel `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD KEY `author_id` (`author_id`);

--
-- Indeks untuk tabel `profiles`
--
ALTER TABLE `profiles`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `display_name` (`display_name`);

--
-- Indeks untuk tabel `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `subjects`
--
ALTER TABLE `subjects`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `subject_name` (`subject_name`);

--
-- Indeks untuk tabel `teachers`
--
ALTER TABLE `teachers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nip` (`nip`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `subject_id` (`subject_id`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD KEY `role_id` (`role_id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `galleries`
--
ALTER TABLE `galleries`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `posts`
--
ALTER TABLE `posts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT untuk tabel `profiles`
--
ALTER TABLE `profiles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `students`
--
ALTER TABLE `students`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `subjects`
--
ALTER TABLE `subjects`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT untuk tabel `teachers`
--
ALTER TABLE `teachers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `posts`
--
ALTER TABLE `posts`
  ADD CONSTRAINT `fk_posts_author` FOREIGN KEY (`author_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `teachers`
--
ALTER TABLE `teachers`
  ADD CONSTRAINT `fk_teachers_subject` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_teachers_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `fk_users_role` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
