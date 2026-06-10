-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 31, 2026 at 02:21 PM
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
-- Database: `tubessbd`
--

-- --------------------------------------------------------

--
-- Table structure for table `activity_logs`
--

CREATE TABLE `activity_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `activity_type` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `activity_logs`
--

INSERT INTO `activity_logs` (`id`, `user_id`, `activity_type`, `description`, `created_at`, `updated_at`) VALUES
(1, 1, 'LOGIN', 'Admin login ke sistem', '2026-05-31 07:11:19', '2026-05-31 07:11:19'),
(2, 2, 'COMPLAINT', 'Mengirim laporan air bersih', '2026-05-31 07:11:19', '2026-05-31 07:11:19'),
(3, 3, 'DONATION', 'Mencatat bantuan logistik', '2026-05-31 07:11:19', '2026-05-31 07:11:19');

-- --------------------------------------------------------

--
-- Table structure for table `complaints`
--

CREATE TABLE `complaints` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `shelter_id` bigint(20) UNSIGNED DEFAULT NULL,
  `handled_by` bigint(20) UNSIGNED DEFAULT NULL,
  `title` varchar(150) NOT NULL,
  `description` text NOT NULL,
  `category` enum('food','water','medical','shelter','emergency','other') NOT NULL,
  `urgency_level` enum('low','medium','high') NOT NULL DEFAULT 'medium',
  `status` enum('pending','processing','completed') NOT NULL DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `complaints`
--

INSERT INTO `complaints` (`id`, `user_id`, `shelter_id`, `handled_by`, `title`, `description`, `category`, `urgency_level`, `status`, `created_at`, `updated_at`) VALUES
(1, 2, NULL, NULL, 'Membutuhkan air', 'Air yang bisa di minum', 'water', 'low', 'pending', '2026-05-18 09:01:00', '2026-05-18 09:01:00'),
(2, 2, 1, 1, 'Kekurangan Air Bersih', 'Persediaan air menipis', 'water', 'high', 'processing', '2026-05-31 07:17:54', '2026-05-31 07:17:54'),
(3, 2, 1, 1, 'Obat Habis', 'Paracetamol hampir habis', 'medical', 'high', 'pending', '2026-05-31 07:17:54', '2026-05-31 07:17:54'),
(4, 2, 1, 1, 'Selimut Kurang', 'Cuaca dingin malam hari', 'shelter', 'medium', 'completed', '2026-05-31 07:17:54', '2026-05-31 07:17:54');

-- --------------------------------------------------------

--
-- Table structure for table `complaint_images`
--

CREATE TABLE `complaint_images` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `complaint_id` bigint(20) UNSIGNED NOT NULL,
  `image_path` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `complaint_images`
--

INSERT INTO `complaint_images` (`id`, `complaint_id`, `image_path`, `created_at`, `updated_at`) VALUES
(1, 1, '1779120060.jpg', '2026-05-18 09:01:00', '2026-05-18 09:01:00'),
(2, 2, 'complaints/air_bersih.jpg', '2026-05-31 07:22:19', '2026-05-31 07:22:19'),
(3, 3, 'complaints/obat_habis.jpg', '2026-05-31 07:22:19', '2026-05-31 07:22:19'),
(4, 4, 'complaints/selimut_kurang.jpg', '2026-05-31 07:22:19', '2026-05-31 07:22:19');

-- --------------------------------------------------------

--
-- Table structure for table `donations`
--

CREATE TABLE `donations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `logistics_id` bigint(20) UNSIGNED NOT NULL,
  `donor_name` varchar(100) NOT NULL,
  `quantity` int(11) NOT NULL,
  `donation_date` date NOT NULL,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `donations`
--

INSERT INTO `donations` (`id`, `logistics_id`, `donor_name`, `quantity`, `donation_date`, `notes`, `created_at`, `updated_at`) VALUES
(1, 1, 'PT Peduli Negeri', 50, '2026-05-01', 'Bantuan pangan', '2026-05-31 07:27:32', '2026-05-31 07:27:32'),
(2, 2, 'Yayasan Kemanusiaan', 100, '2026-05-03', 'Air bersih', '2026-05-31 07:27:32', '2026-05-31 07:27:32'),
(3, 3, 'RS Medan Sehat', 75, '2026-05-05', 'Bantuan medis', '2026-05-31 07:27:32', '2026-05-31 07:27:32');

-- --------------------------------------------------------

--
-- Table structure for table `logistics`
--

CREATE TABLE `logistics` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `category_id` bigint(20) UNSIGNED NOT NULL,
  `shelter_id` bigint(20) UNSIGNED NOT NULL,
  `item_name` varchar(100) NOT NULL,
  `stock` int(11) NOT NULL,
  `minimum_stock` int(11) NOT NULL DEFAULT 10,
  `expired_date` date DEFAULT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `logistics`
--

INSERT INTO `logistics` (`id`, `category_id`, `shelter_id`, `item_name`, `stock`, `minimum_stock`, `expired_date`, `description`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'Beras 5Kg', 100, 20, '2027-12-31', 'Stok beras utama', '2026-05-31 07:26:41', '2026-05-31 07:26:41'),
(2, 2, 1, 'Air Mineral', 300, 50, '2027-06-30', 'Air minum kemasan', '2026-05-31 07:26:41', '2026-05-31 07:26:41'),
(3, 3, 2, 'Paracetamol', 150, 30, '2027-05-15', 'Obat demam', '2026-05-31 07:26:41', '2026-05-31 07:26:41'),
(4, 4, 3, 'Selimut', 80, 10, NULL, 'Bantuan selimut', '2026-05-31 07:26:41', '2026-05-31 07:26:41');

-- --------------------------------------------------------

--
-- Table structure for table `logistics_categories`
--

CREATE TABLE `logistics_categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `category_name` varchar(100) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `logistics_categories`
--

INSERT INTO `logistics_categories` (`id`, `category_name`, `created_at`, `updated_at`) VALUES
(1, 'Makanan', '2026-05-31 07:25:06', '2026-05-31 07:25:06'),
(2, 'Minuman', '2026-05-31 07:25:06', '2026-05-31 07:25:06'),
(3, 'Obat-obatan', '2026-05-31 07:25:06', '2026-05-31 07:25:06'),
(4, 'Pakaian', '2026-05-31 07:25:06', '2026-05-31 07:25:06');

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` char(36) NOT NULL,
  `type` varchar(255) NOT NULL,
  `notifiable_type` varchar(255) NOT NULL,
  `notifiable_id` bigint(20) UNSIGNED NOT NULL,
  `data` text NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`id`, `type`, `notifiable_type`, `notifiable_id`, `data`, `read_at`, `created_at`, `updated_at`, `user_id`) VALUES
('1', 'ComplaintNotification', 'Complaint', 1, '{\"message\":\"Keluhan baru masuk\"}', NULL, '2026-05-31 07:13:07', '2026-05-31 07:13:07', 1),
('2', 'DonationNotification', 'Donation', 1, '{\"message\":\"Donasi baru diterima\"}', NULL, '2026-05-31 07:13:07', '2026-05-31 07:13:07', 1),
('3', 'StockNotification', 'Logistics', 3, '{\"message\":\"Stok obat menipis\"}', NULL, '2026-05-31 07:13:07', '2026-05-31 07:13:07', 1);

-- --------------------------------------------------------

--
-- Table structure for table `refugees`
--

CREATE TABLE `refugees` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `shelter_id` bigint(20) UNSIGNED NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `age` int(11) NOT NULL,
  `gender` enum('male','female') NOT NULL,
  `family_group` varchar(255) DEFAULT NULL,
  `medical_condition` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `refugees`
--

INSERT INTO `refugees` (`id`, `shelter_id`, `full_name`, `age`, `gender`, `family_group`, `medical_condition`, `created_at`, `updated_at`) VALUES
(1, 1, 'Budi Santoso', 35, 'male', 'Keluarga A', 'Asma', NULL, NULL),
(2, 1, 'Siti Aminah', 30, 'female', 'Keluarga A', 'Demam', NULL, NULL),
(3, 2, 'Andi Saputra', 42, 'male', 'Keluarga B', 'Diabetes', NULL, NULL),
(4, 2, 'Rina Marlina', 27, 'female', 'Keluarga C', 'Hipertensi', NULL, NULL),
(5, 3, 'Doni Pratama', 18, 'male', 'Keluarga D', 'Flu', NULL, NULL),
(6, 1, 'Ahmad Fauzi', 35, 'male', 'Keluarga E', 'Tidak ada', '2026-05-31 07:36:43', '2026-05-31 07:36:43'),
(7, 1, 'Nur Aisyah', 30, 'female', 'Keluarga E', 'Asma', '2026-05-31 07:36:43', '2026-05-31 07:36:43'),
(8, 2, 'Rudi Hartono', 40, 'male', 'Keluarga F', 'Diabetes', '2026-05-31 07:36:43', '2026-05-31 07:36:43'),
(9, 2, 'Dewi Lestari', 25, 'female', 'Keluarga G', 'Tidak ada', '2026-05-31 07:36:43', '2026-05-31 07:36:43'),
(10, 3, 'Fajar Nugraha', 29, 'male', 'Keluarga H', 'Hipertensi', '2026-05-31 07:36:43', '2026-05-31 07:36:43');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `role_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `role_name`, `created_at`, `updated_at`) VALUES
(1, 'admin', '2026-05-12 21:12:05', '2026-05-12 21:12:05'),
(2, 'citizen', '2026-05-12 21:12:05', '2026-05-12 21:12:05'),
(3, 'volunteer', '2026-05-12 21:12:05', '2026-05-12 21:12:05');

-- --------------------------------------------------------

--
-- Table structure for table `shelters`
--

CREATE TABLE `shelters` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `shelter_name` varchar(100) NOT NULL,
  `address` text NOT NULL,
  `capacity` int(11) NOT NULL,
  `current_refugees` int(11) NOT NULL DEFAULT 0,
  `status` enum('active','full','closed') NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `shelters`
--

INSERT INTO `shelters` (`id`, `shelter_name`, `address`, `capacity`, `current_refugees`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Shelter Medan 1', 'Jl. Gatot Subroto', 100, 45, 'active', NULL, NULL),
(2, 'Shelter Binjai', 'Jl. Sudirman', 80, 80, 'full', NULL, NULL),
(3, 'Shelter Tebing Tinggi', 'Jl. Ahmad Yani', 60, 20, 'active', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `shelter_assignments`
--

CREATE TABLE `shelter_assignments` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `shelter_id` bigint(20) UNSIGNED NOT NULL,
  `role_in_shelter` varchar(100) DEFAULT NULL,
  `assigned_at` date DEFAULT NULL,
  `finished_at` date DEFAULT NULL,
  `status` enum('active','completed','moved') DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `shelter_assignments`
--

INSERT INTO `shelter_assignments` (`id`, `user_id`, `shelter_id`, `role_in_shelter`, `assigned_at`, `finished_at`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'Admin Shelter', '2026-05-01', NULL, 'active', NULL, NULL),
(2, 2, 1, 'Volunteer Medis', '2026-05-03', NULL, 'active', NULL, NULL),
(3, 2, 2, 'Volunteer Logistik', '2026-04-01', '2026-04-20', 'completed', NULL, NULL),
(4, 3, 2, 'Koordinator Shelter', '2026-05-05', NULL, 'active', NULL, NULL),
(5, 3, 3, 'Relawan Lapangan', '2026-03-10', '2026-03-25', 'completed', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED DEFAULT NULL,
  `shelter_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `profile_photo` varchar(255) DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `two_factor_code` varchar(255) DEFAULT NULL,
  `two_factor_expires_at` timestamp NULL DEFAULT NULL,
  `two_factor_enabled` tinyint(1) NOT NULL DEFAULT 0,
  `bio` text DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `gender` varchar(255) DEFAULT NULL,
  `skills` varchar(255) DEFAULT NULL,
  `organization` varchar(255) DEFAULT NULL,
  `experience` varchar(255) DEFAULT NULL,
  `availability` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `role_id`, `shelter_id`, `name`, `email`, `phone`, `address`, `profile_photo`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`, `two_factor_code`, `two_factor_expires_at`, `two_factor_enabled`, `bio`, `date_of_birth`, `gender`, `skills`, `organization`, `experience`, `availability`) VALUES
(1, 2, NULL, 'Raja', 'akunchatgpt211@gmail.com', NULL, NULL, NULL, NULL, '$2y$12$zY5Cy.fYys.JobwrsCQD1eY9m6O6S1MiOuN8BUhy4.g2uajkLGd5e', NULL, '2026-05-13 03:22:39', '2026-05-14 10:21:26', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2, 2, NULL, 'Nabil', 'farelhiayamo@gmail.com', '085266677888', 'jln. Hakimi', '1778923648.jpeg', '2026-05-14 11:09:33', '$2y$12$gb.fVFTxO/gv1GB8tiOTbebJ/2dsQ8BO4B5Yz9rwSbeBPlk9/Gz2K', 'YNz9eFQ1SGSy14U03GgOLAPxOVgXLpsSeffTlAzmDDeg8mIlFrK7ZuLYhtk1', '2026-05-14 04:55:58', '2026-05-18 09:04:40', NULL, NULL, 0, 'i am intovert and smart', '2007-07-12', 'Male', NULL, NULL, NULL, NULL),
(3, 3, NULL, 'Farel', 'yaaja@gmail.com', NULL, NULL, NULL, NULL, '$2y$12$2zN6X.9c4RY7GnniCq9az.DthlCm35HOKMeimtxBoSegVsOrKpnC2', 'n2HHKfY7WXX8FWZ1Cq6ICPpcn6Uw2o1LLUwEv4BL4OIdC5dlH0FjFk9xWc8W', '2026-05-14 05:45:19', '2026-05-14 05:45:19', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(4, 3, NULL, 'Raja', 'marunoyumitgc@gmail.com', NULL, NULL, NULL, NULL, '$2y$12$RQm76SWbEJQ8P6y7yVYBa.Le8vwZPxvORnHOkpI1KcRSW4qMSHSTW', NULL, '2026-05-14 10:06:43', '2026-05-14 10:06:43', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(5, 2, NULL, 'Mana', 'jojosantuygame66@gmail.com', NULL, NULL, NULL, '2026-05-14 10:38:42', '$2y$12$/Nt/oDxRCwlPV6ElxH2niewteFSdkuHrpzGPllr64oWTM5siTrWx.', '6gERzP5IWzXAdtI85KocSPogBdZqFFmokjuTqwyXUUhBySA5XhQ9pS0XweS0', '2026-05-14 10:17:27', '2026-05-14 10:56:59', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(6, 3, NULL, 'Budi', 'papieleven@gmail.com', NULL, NULL, NULL, '2026-05-14 11:14:45', '$2y$12$tTazwgY4vbhYUphPJoF6bOi8AgjT4qqVdbZ0hBgyb768N2wKgckBW', 'EPT2jq4q8m6KGdONomwlBu43yvgjqJ3Qjb2WKZqTjkEUF1DXgUkgHbViOXMH', '2026-05-14 10:26:29', '2026-05-15 04:51:22', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(7, 2, NULL, 'Cinta', 'turut3833@gmail.com', NULL, NULL, NULL, NULL, '$2y$12$h.kDdsPR9rgg433/sHlRhOW5fXYZ61YFyFs4mxHX3FkDTEc/eVvNi', NULL, '2026-05-14 10:43:06', '2026-05-14 10:43:06', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(8, 2, NULL, 'oalah', 'telurbebekmandala@gmail.com', NULL, NULL, NULL, '2026-05-14 11:32:33', '$2y$12$I4sJou8wRj1c5H.zEAqESu0ee.shczf6/Nhh7Z2r.ujzJRlU6kcfG', 'ckLQWt7mdiF4unwFzPIWwqqD4aOlkMbMvAJwJtha6Y0JU2pgRuMiRDv4PgR1', '2026-05-14 11:31:49', '2026-05-14 11:33:17', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(9, 3, NULL, 'Darin', 'darinvolunteer@gmail.com', '08786755436', 'jln. Pinguin Raya 3', '1779019913.jpg', NULL, '$2y$12$kcNvn1E.yZOEMyMggcmMcOHaI.SEUqp1DM17mljgR7fZFX9B7LgQS', 'OiK445w3SAEv3ljmkPD9Z6a4UwWkNz4OURq1yiWFr69Yua69fyjNGKH3Ig5h', '2026-05-14 11:57:46', '2026-05-17 05:36:16', NULL, NULL, 0, 'Saya suka menolong orang', '2018-02-16', 'Female', 'Logistik', 'Agent Of Changes', '3 Tahun', 'Full Time'),
(10, 1, 1, 'Kevin', 'kevin@gmail.com', '08123456789', NULL, NULL, NULL, 'admin123', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(11, 2, 1, 'Gabriel', 'gabriel@gmail.com', '08111111111', NULL, NULL, NULL, 'volunteer123', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(12, 3, 2, 'William', 'william@gmail.com', '08222222222', NULL, NULL, NULL, 'staff123', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(13, 1, 1, 'Admin Utama', 'adminbaru@test.com', '081111111111', 'Medan', NULL, NULL, 'admin123', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(14, 2, 1, 'Budi Santoso', 'budibaru@test.com', '082222222222', 'Medan', NULL, NULL, 'volunteer123', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(15, 2, 2, 'Siti Rahma', 'sitibaru@test.com', '083333333333', 'Binjai', NULL, NULL, 'volunteer123', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(16, 2, 3, 'Andi Saputra', 'andibaru@test.com', '084444444444', 'Deli Serdang', NULL, NULL, 'volunteer123', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_complaints`
-- (See below for the actual view)
--
CREATE TABLE `view_complaints` (
`id` bigint(20) unsigned
,`title` varchar(150)
,`status` enum('pending','processing','completed')
,`pelapor` varchar(100)
,`shelter_name` varchar(100)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_logistics`
-- (See below for the actual view)
--
CREATE TABLE `view_logistics` (
`item_name` varchar(100)
,`stock` int(11)
,`category_name` varchar(100)
,`shelter_name` varchar(100)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_refugee_shelter`
-- (See below for the actual view)
--
CREATE TABLE `view_refugee_shelter` (
`id` bigint(20) unsigned
,`full_name` varchar(100)
,`age` int(11)
,`gender` enum('male','female')
,`shelter_name` varchar(100)
);

-- --------------------------------------------------------

--
-- Structure for view `view_complaints`
--
DROP TABLE IF EXISTS `view_complaints`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_complaints`  AS SELECT `complaints`.`id` AS `id`, `complaints`.`title` AS `title`, `complaints`.`status` AS `status`, `users`.`name` AS `pelapor`, `shelters`.`shelter_name` AS `shelter_name` FROM ((`complaints` join `users` on(`complaints`.`user_id` = `users`.`id`)) join `shelters` on(`complaints`.`shelter_id` = `shelters`.`id`)) ;

-- --------------------------------------------------------

--
-- Structure for view `view_logistics`
--
DROP TABLE IF EXISTS `view_logistics`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_logistics`  AS SELECT `logistics`.`item_name` AS `item_name`, `logistics`.`stock` AS `stock`, `logistics_categories`.`category_name` AS `category_name`, `shelters`.`shelter_name` AS `shelter_name` FROM ((`logistics` join `logistics_categories` on(`logistics`.`category_id` = `logistics_categories`.`id`)) join `shelters` on(`logistics`.`shelter_id` = `shelters`.`id`)) ;

-- --------------------------------------------------------

--
-- Structure for view `view_refugee_shelter`
--
DROP TABLE IF EXISTS `view_refugee_shelter`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_refugee_shelter`  AS SELECT `refugees`.`id` AS `id`, `refugees`.`full_name` AS `full_name`, `refugees`.`age` AS `age`, `refugees`.`gender` AS `gender`, `shelters`.`shelter_name` AS `shelter_name` FROM (`refugees` join `shelters` on(`refugees`.`shelter_id` = `shelters`.`id`)) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `activity_logs`
--
ALTER TABLE `activity_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `activity_logs_user_id_foreign` (`user_id`);

--
-- Indexes for table `complaints`
--
ALTER TABLE `complaints`
  ADD PRIMARY KEY (`id`),
  ADD KEY `complaints_user_id_foreign` (`user_id`),
  ADD KEY `complaints_shelter_id_foreign` (`shelter_id`),
  ADD KEY `complaints_handled_by_foreign` (`handled_by`);

--
-- Indexes for table `complaint_images`
--
ALTER TABLE `complaint_images`
  ADD PRIMARY KEY (`id`),
  ADD KEY `complaint_images_complaint_id_foreign` (`complaint_id`);

--
-- Indexes for table `donations`
--
ALTER TABLE `donations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `donations_logistics_id_foreign` (`logistics_id`);

--
-- Indexes for table `logistics`
--
ALTER TABLE `logistics`
  ADD PRIMARY KEY (`id`),
  ADD KEY `logistics_category_id_foreign` (`category_id`),
  ADD KEY `logistics_shelter_id_foreign` (`shelter_id`);

--
-- Indexes for table `logistics_categories`
--
ALTER TABLE `logistics_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `notifications_notifiable_type_notifiable_id_index` (`notifiable_type`,`notifiable_id`),
  ADD KEY `fk_notifications_users` (`user_id`);

--
-- Indexes for table `refugees`
--
ALTER TABLE `refugees`
  ADD PRIMARY KEY (`id`),
  ADD KEY `refugees_shelter_id_foreign` (`shelter_id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `shelters`
--
ALTER TABLE `shelters`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `shelter_assignments`
--
ALTER TABLE `shelter_assignments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `shelter_id` (`shelter_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD KEY `users_role_id_foreign` (`role_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `activity_logs`
--
ALTER TABLE `activity_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `complaints`
--
ALTER TABLE `complaints`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `complaint_images`
--
ALTER TABLE `complaint_images`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `donations`
--
ALTER TABLE `donations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `logistics`
--
ALTER TABLE `logistics`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `logistics_categories`
--
ALTER TABLE `logistics_categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `refugees`
--
ALTER TABLE `refugees`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `shelters`
--
ALTER TABLE `shelters`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `shelter_assignments`
--
ALTER TABLE `shelter_assignments`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `activity_logs`
--
ALTER TABLE `activity_logs`
  ADD CONSTRAINT `activity_logs_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `complaints`
--
ALTER TABLE `complaints`
  ADD CONSTRAINT `complaints_handled_by_foreign` FOREIGN KEY (`handled_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `complaints_shelter_id_foreign` FOREIGN KEY (`shelter_id`) REFERENCES `shelters` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `complaints_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `complaint_images`
--
ALTER TABLE `complaint_images`
  ADD CONSTRAINT `complaint_images_complaint_id_foreign` FOREIGN KEY (`complaint_id`) REFERENCES `complaints` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `donations`
--
ALTER TABLE `donations`
  ADD CONSTRAINT `donations_logistics_id_foreign` FOREIGN KEY (`logistics_id`) REFERENCES `logistics` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `logistics`
--
ALTER TABLE `logistics`
  ADD CONSTRAINT `logistics_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `logistics_categories` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `logistics_shelter_id_foreign` FOREIGN KEY (`shelter_id`) REFERENCES `shelters` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `fk_notifications_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `refugees`
--
ALTER TABLE `refugees`
  ADD CONSTRAINT `refugees_shelter_id_foreign` FOREIGN KEY (`shelter_id`) REFERENCES `shelters` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `shelter_assignments`
--
ALTER TABLE `shelter_assignments`
  ADD CONSTRAINT `shelter_assignments_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `shelter_assignments_ibfk_2` FOREIGN KEY (`shelter_id`) REFERENCES `shelters` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
