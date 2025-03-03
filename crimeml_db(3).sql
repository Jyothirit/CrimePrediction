-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 28, 2025 at 05:00 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.0.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `crimeml_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add user', 4, 'add_user'),
(14, 'Can change user', 4, 'change_user'),
(15, 'Can delete user', 4, 'delete_user'),
(16, 'Can view user', 4, 'view_user'),
(17, 'Can add content type', 5, 'add_contenttype'),
(18, 'Can change content type', 5, 'change_contenttype'),
(19, 'Can delete content type', 5, 'delete_contenttype'),
(20, 'Can view content type', 5, 'view_contenttype'),
(21, 'Can add session', 6, 'add_session'),
(22, 'Can change session', 6, 'change_session'),
(23, 'Can delete session', 6, 'delete_session'),
(24, 'Can view session', 6, 'view_session'),
(25, 'Can add category', 7, 'add_category'),
(26, 'Can change category', 7, 'change_category'),
(27, 'Can delete category', 7, 'delete_category'),
(28, 'Can view category', 7, 'view_category'),
(29, 'Can add login', 8, 'add_login'),
(30, 'Can change login', 8, 'change_login'),
(31, 'Can delete login', 8, 'delete_login'),
(32, 'Can view login', 8, 'view_login'),
(33, 'Can add user info', 9, 'add_userinfo'),
(34, 'Can change user info', 9, 'change_userinfo'),
(35, 'Can delete user info', 9, 'delete_userinfo'),
(36, 'Can view user info', 9, 'view_userinfo'),
(37, 'Can add district', 10, 'add_district'),
(38, 'Can change district', 10, 'change_district'),
(39, 'Can delete district', 10, 'delete_district'),
(40, 'Can view district', 10, 'view_district'),
(41, 'Can add police station', 11, 'add_policestation'),
(42, 'Can change police station', 11, 'change_policestation'),
(43, 'Can delete police station', 11, 'delete_policestation'),
(44, 'Can view police station', 11, 'view_policestation'),
(45, 'Can add state', 12, 'add_state'),
(46, 'Can change state', 12, 'change_state'),
(47, 'Can delete state', 12, 'delete_state'),
(48, 'Can view state', 12, 'view_state'),
(49, 'Can add crime', 13, 'add_crime'),
(50, 'Can change crime', 13, 'change_crime'),
(51, 'Can delete crime', 13, 'delete_crime'),
(52, 'Can view crime', 13, 'view_crime'),
(53, 'Can add feedback', 14, 'add_feedback'),
(54, 'Can change feedback', 14, 'change_feedback'),
(55, 'Can delete feedback', 14, 'delete_feedback'),
(56, 'Can view feedback', 14, 'view_feedback'),
(57, 'Can add crime record', 15, 'add_crimerecord'),
(58, 'Can change crime record', 15, 'change_crimerecord'),
(59, 'Can delete crime record', 15, 'delete_crimerecord'),
(60, 'Can view crime record', 15, 'view_crimerecord'),
(61, 'Can add crime hot spot', 16, 'add_crimehotspot'),
(62, 'Can change crime hot spot', 16, 'change_crimehotspot'),
(63, 'Can delete crime hot spot', 16, 'delete_crimehotspot'),
(64, 'Can view crime hot spot', 16, 'view_crimehotspot'),
(65, 'Can add crime prediction', 17, 'add_crimeprediction'),
(66, 'Can change crime prediction', 17, 'change_crimeprediction'),
(67, 'Can delete crime prediction', 17, 'delete_crimeprediction'),
(68, 'Can view crime prediction', 17, 'view_crimeprediction'),
(69, 'Can add crime hot spot police', 18, 'add_crimehotspotpolice'),
(70, 'Can change crime hot spot police', 18, 'change_crimehotspotpolice'),
(71, 'Can delete crime hot spot police', 18, 'delete_crimehotspotpolice'),
(72, 'Can view crime hot spot police', 18, 'view_crimehotspotpolice'),
(73, 'Can add culprit', 19, 'add_culprit'),
(74, 'Can change culprit', 19, 'change_culprit'),
(75, 'Can delete culprit', 19, 'delete_culprit'),
(76, 'Can view culprit', 19, 'view_culprit'),
(77, 'Can add crime prediction police', 20, 'add_crimepredictionpolice'),
(78, 'Can change crime prediction police', 20, 'change_crimepredictionpolice'),
(79, 'Can delete crime prediction police', 20, 'delete_crimepredictionpolice'),
(80, 'Can view crime prediction police', 20, 'view_crimepredictionpolice'),
(81, 'Can add crime updates', 21, 'add_crimeupdates'),
(82, 'Can change crime updates', 21, 'change_crimeupdates'),
(83, 'Can delete crime updates', 21, 'delete_crimeupdates'),
(84, 'Can view crime updates', 21, 'view_crimeupdates');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user`
--

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `auth_user`
--

INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
(1, 'pbkdf2_sha256$720000$zj8kc73BvO5fm6iafX0kqe$76zjkOWf5x8QpYjkaDlVaAGBV0dZKEBaTE9caJmyR64=', NULL, 1, 'admin', '', '', 'admin@gmail.com', 1, 1, '2025-01-20 16:59:35.371298');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_groups`
--

CREATE TABLE `auth_user_groups` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_user_permissions`
--

CREATE TABLE `auth_user_user_permissions` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'auth', 'user'),
(5, 'contenttypes', 'contenttype'),
(7, 'crimeapp', 'category'),
(13, 'crimeapp', 'crime'),
(16, 'crimeapp', 'crimehotspot'),
(18, 'crimeapp', 'crimehotspotpolice'),
(17, 'crimeapp', 'crimeprediction'),
(20, 'crimeapp', 'crimepredictionpolice'),
(15, 'crimeapp', 'crimerecord'),
(21, 'crimeapp', 'crimeupdates'),
(19, 'crimeapp', 'culprit'),
(10, 'crimeapp', 'district'),
(14, 'crimeapp', 'feedback'),
(8, 'crimeapp', 'login'),
(11, 'crimeapp', 'policestation'),
(12, 'crimeapp', 'state'),
(9, 'crimeapp', 'userinfo'),
(6, 'sessions', 'session');

-- --------------------------------------------------------

--
-- Table structure for table `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2025-01-20 16:59:11.664260'),
(2, 'auth', '0001_initial', '2025-01-20 16:59:11.962448'),
(3, 'admin', '0001_initial', '2025-01-20 16:59:12.040966'),
(4, 'admin', '0002_logentry_remove_auto_add', '2025-01-20 16:59:12.056602'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2025-01-20 16:59:12.056602'),
(6, 'contenttypes', '0002_remove_content_type_name', '2025-01-20 16:59:12.103478'),
(7, 'auth', '0002_alter_permission_name_max_length', '2025-01-20 16:59:12.150747'),
(8, 'auth', '0003_alter_user_email_max_length', '2025-01-20 16:59:12.166374'),
(9, 'auth', '0004_alter_user_username_opts', '2025-01-20 16:59:12.181998'),
(10, 'auth', '0005_alter_user_last_login_null', '2025-01-20 16:59:12.213281'),
(11, 'auth', '0006_require_contenttypes_0002', '2025-01-20 16:59:12.213281'),
(12, 'auth', '0007_alter_validators_add_error_messages', '2025-01-20 16:59:12.232994'),
(13, 'auth', '0008_alter_user_username_max_length', '2025-01-20 16:59:12.232994'),
(14, 'auth', '0009_alter_user_last_name_max_length', '2025-01-20 16:59:12.245002'),
(15, 'auth', '0010_alter_group_name_max_length', '2025-01-20 16:59:12.245002'),
(16, 'auth', '0011_update_proxy_permissions', '2025-01-20 16:59:12.260636'),
(17, 'auth', '0012_alter_user_first_name_max_length', '2025-01-20 16:59:12.260636'),
(18, 'crimeapp', '0001_initial', '2025-01-20 16:59:12.323137'),
(19, 'sessions', '0001_initial', '2025-01-20 16:59:12.339151'),
(20, 'crimeapp', '0002_district_state_policestation_district_state_id', '2025-01-21 11:49:31.650111'),
(21, 'crimeapp', '0003_rename_state_id_district_state_and_more', '2025-01-22 04:36:38.202973'),
(22, 'crimeapp', '0004_crime', '2025-01-27 06:04:47.669319'),
(23, 'crimeapp', '0005_rename_complaint_id_crime_crime_id', '2025-01-27 06:23:47.167630'),
(24, 'crimeapp', '0006_feedback', '2025-01-27 09:50:26.590514'),
(25, 'crimeapp', '0007_crimerecord', '2025-01-29 05:43:53.578193'),
(26, 'crimeapp', '0008_rename_date_time_crimerecord_crimetime', '2025-02-05 04:46:34.186651'),
(27, 'crimeapp', '0009_alter_crimerecord_holiday', '2025-02-05 04:48:22.806276'),
(28, 'crimeapp', '0010_alter_crimerecord_arrest_made_and_more', '2025-02-05 04:49:47.181303'),
(29, 'crimeapp', '0011_userinfo_latitude_userinfo_longitude_and_more', '2025-02-07 04:41:10.549322'),
(30, 'crimeapp', '0012_alter_userinfo_latitude_alter_userinfo_longitude', '2025-02-07 04:43:16.845861'),
(31, 'crimeapp', '0013_crimehotspot', '2025-02-07 11:50:01.107097'),
(32, 'crimeapp', '0014_crimehotspot_crime_checking_type', '2025-02-18 10:28:46.960371'),
(33, 'crimeapp', '0015_remove_crimehotspot_crime_checking_type_and_more', '2025-02-18 10:36:43.933136'),
(34, 'crimeapp', '0016_policestation_latitude_policestation_longitude', '2025-02-27 00:31:00.195562'),
(35, 'crimeapp', '0017_crimehotspotpolice', '2025-02-27 02:00:45.067989'),
(36, 'crimeapp', '0018_crimepredictionpolice_crimeupdates_culprit', '2025-02-28 01:58:09.444920');

-- --------------------------------------------------------

--
-- Table structure for table `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('2ypu966fb3wr3nl2ng4uas4a9h4vcm77', 'eyJhbmFtZSI6ImFkbWluIiwic2xvZ2lkIjoxfQ:1tiblX:7gMhM8SlYMCb5J4JZYqciTQZQxt5m_axCf6RYH8AHtU', '2025-02-27 16:08:39.023257'),
('7wlcd4ditvr9m2urad75xlnon7fyuisi', 'eyJhbmFtZSI6ImFkbWluIiwic2xvZ2lkIjoxfQ:1thPHX:qXbOSXLGw7QkCG92atmPng7amAW8gZrPbsloB-RQhFI', '2025-02-24 08:36:43.496861'),
('9msjs0sxxuo2x4xss55hnppi83izxtbe', 'eyJ1bmFtZSI6ImNoaW5udTEyMyIsInNsb2dpZCI6MTB9:1tgMxM:q1cdy6BC1X1A8oG3Prxu4bzf2fn7SOKgdf6OjT9LmZQ', '2025-02-21 11:55:36.446355'),
('a2a8hwfn25j35yjif8gmf7v9mdgzjw8a', 'eyJwbmFtZSI6ImFkb29ycGxjMTIzIiwic2xvZ2lkIjo4fQ:1tcdcB:qvl2NeBTU0-mkSTtl8OnJvw61SVwm-ezlGtnxKdHuH8', '2025-02-11 04:54:19.290294'),
('fm4qi5zendnd7xilkc3oi2fussxiuop5', 'eyJhbmFtZSI6ImFkbWluIiwic2xvZ2lkIjoxfQ:1tjqPz:8itlSv5Z9gLIcOx_PrYmE5NrBqSCLOyq1c9jKppjyg4', '2025-03-03 01:59:31.943630'),
('msdhfis3wlq2izy3nlzbb5rgpet00838', 'eyJhbmFtZSI6ImFkbWluIiwic2xvZ2lkIjoxfQ:1tnpyT:k4UCTcqsEl4abRMq7amP4leg3nBUCIDL-clD00_6AyU', '2025-03-14 02:19:37.100468'),
('zetjagl7svrz0cyfdmchyvup3e33pyfn', 'eyJhbmFtZSI6ImFkbWluIiwic2xvZ2lkIjoxfQ:1tnTkt:NLCDl2Y24KaiQhqfSDQfTbm0GL3SU7gmdCur_FQ9bSM', '2025-03-13 02:36:07.888895');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_category`
--

CREATE TABLE `tbl_category` (
  `category_id` int(11) NOT NULL,
  `category` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_category`
--

INSERT INTO `tbl_category` (`category_id`, `category`) VALUES
(1, 'Robbery'),
(2, 'Theft');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_crime`
--

CREATE TABLE `tbl_crime` (
  `crime_id` int(11) NOT NULL,
  `place` varchar(255) NOT NULL,
  `subject` varchar(255) NOT NULL,
  `complaint_text` longtext NOT NULL,
  `crime_datetime` datetime(6) NOT NULL,
  `supporting_document` varchar(100) DEFAULT NULL,
  `status` varchar(50) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `category_id` int(11) NOT NULL,
  `district_id` int(11) NOT NULL,
  `police_station_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_crime`
--

INSERT INTO `tbl_crime` (`crime_id`, `place`, `subject`, `complaint_text`, `crime_datetime`, `supporting_document`, `status`, `created_at`, `category_id`, `district_id`, `police_station_id`, `user_id`) VALUES
(1, 'Adoor', 'Robbery Incident', 'I am writing to formally report a robbery incident that occurred on [date] at [time]. The incident took place at [specific location]. During this time, [briefly describe what happened, e.g., \"two individuals forcibly entered my property and stole valuable items including cash, jewelry, and electronics\"].\r\n\r\nI kindly request immediate action to investigate this matter and ensure the recovery of my stolen belongings. Please let me know if any additional information or documents are required to proceed.', '2025-01-28 04:04:00.000000', '/media/1..jpg', 'Investigation is started', '2025-01-27 06:04:55.654859', 1, 259, 1, 2),
(2, 'Adoor', 'Robbery Incident', 'I am writing to formally report a robbery incident that occurred on [date] at [time]. The incident took place at [specific location]. During this time, [briefly describe what happened, e.g., \"two individuals forcibly entered my property and stole valuable items including cash, jewelry, and electronics\"].\r\n\r\nI kindly request immediate action to investigate this matter and ensure the recovery of my stolen belongings. Please let me know if any additional information or documents are required to proceed.', '2025-01-21 05:06:00.000000', '/media/2.pdf', 'Investigation is started', '2025-01-27 06:11:44.850506', 1, 259, 1, 2),
(3, 'Adoor', 'Robbery in myy House', 'At approximately 2:30 AM, the homeowner, John Doe, was awakened by unusual noises coming from the living room. Upon checking the surveillance camera feed, he noticed two masked individuals forcibly entering through the back door. The burglars searched through drawers and cabinets, stealing valuables, including jewelry, cash, and electronic devices.\r\n\r\nThe homeowner immediately called 911, but by the time authorities arrived, the suspects had already fled the scene in a dark-colored SUV.', '2025-02-27 23:08:00.000000', '/media/5.png', 'Investigation is started', '2025-02-28 01:45:57.995744', 1, 259, 1, 2),
(4, 'Adoor', 'Robbery in myy House', 'At approximately 2:30 AM, the homeowner, John Doe, was awakened by unusual noises coming from the living room. Upon checking the surveillance camera feed, he noticed two masked individuals forcibly entering through the back door. The burglars searched through drawers and cabinets, stealing valuables, including jewelry, cash, and electronic devices.\r\n\r\nThe homeowner immediately called 911, but by the time authorities arrived, the suspects had already fled the scene in a dark-colored SUV.', '2025-02-26 08:08:00.000000', '/media/6.png', 'Investigation is started', '2025-02-28 01:47:30.600291', 1, 259, 1, 2),
(5, 'Pathanamthitta', 'Robbery in my House', 'At approximately 2:30 AM, the homeowner, John Doe, was awakened by unusual noises coming from the living room. Upon checking the surveillance camera feed, he noticed two masked individuals forcibly entering through the back door. The burglars searched through drawers and cabinets, stealing valuables, including jewelry, cash, and electronic devices.\r\n\r\nThe homeowner immediately called 911, but by the time authorities arrived, the suspects had already fled the scene in a dark-colored SUV.', '2025-02-27 20:10:00.000000', '/media/7.png', 'Investigation is started', '2025-02-28 01:48:14.611730', 1, 259, 1, 2),
(6, 'Pathanamthitta', 'Robbery in my House', 'At approximately 2:30 AM, the homeowner, John Doe, was awakened by unusual noises coming from the living room. Upon checking the surveillance camera feed, he noticed two masked individuals forcibly entering through the back door. The burglars searched through drawers and cabinets, stealing valuables, including jewelry, cash, and electronic devices.\r\n\r\nThe homeowner immediately called 911, but by the time authorities arrived, the suspects had already fled the scene in a dark-colored SUV.', '2025-02-20 16:05:00.000000', '/media/8.png', 'Pending', '2025-02-28 01:48:54.288627', 1, 259, 1, 2);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_crime_hot_spot`
--

CREATE TABLE `tbl_crime_hot_spot` (
  `crim_hotspot_id` int(11) NOT NULL,
  `latitude` decimal(12,6) DEFAULT NULL,
  `longitude` decimal(12,6) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_crime_hot_spot`
--

INSERT INTO `tbl_crime_hot_spot` (`crim_hotspot_id`, `latitude`, `longitude`, `created_at`, `user_id`) VALUES
(1, 26.851622, 80.941163, '2025-02-07 11:50:08.142086', 2),
(2, 26.851622, 80.941163, '2025-02-07 11:50:08.142086', 3),
(8, 26.851622, 80.941163, '2025-02-27 02:00:54.230671', 2),
(9, 26.851622, 80.941163, '2025-02-27 02:00:54.230671', 3),
(10, 26.851622, 80.941163, '2025-02-27 02:03:24.244496', 2),
(11, 26.851622, 80.941163, '2025-02-27 02:03:24.265060', 3);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_crime_hot_spot_police`
--

CREATE TABLE `tbl_crime_hot_spot_police` (
  `crim_hotspot_id` int(11) NOT NULL,
  `latitude` decimal(12,6) DEFAULT NULL,
  `longitude` decimal(12,6) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `police_station_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_crime_hot_spot_police`
--

INSERT INTO `tbl_crime_hot_spot_police` (`crim_hotspot_id`, `latitude`, `longitude`, `created_at`, `police_station_id`) VALUES
(1, 26.851622, 80.941163, '2025-02-27 02:03:24.265060', 1);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_crime_record`
--

CREATE TABLE `tbl_crime_record` (
  `crime_record_id` int(11) NOT NULL,
  `crimetime` datetime(6) DEFAULT NULL,
  `latitude` decimal(12,6) DEFAULT NULL,
  `longitude` decimal(12,6) DEFAULT NULL,
  `crime_type` varchar(50) DEFAULT NULL,
  `severity` varchar(20) DEFAULT NULL,
  `police_station_jurisdiction` varchar(100) DEFAULT NULL,
  `weather` varchar(50) DEFAULT NULL,
  `population_density` int(11) DEFAULT NULL,
  `proximity_to_landmark` int(11) DEFAULT NULL,
  `time_of_day` varchar(20) DEFAULT NULL,
  `day_of_week` varchar(20) DEFAULT NULL,
  `holiday` varchar(20) DEFAULT NULL,
  `recurring_crime_location` varchar(30) DEFAULT NULL,
  `victim_age_group` varchar(20) DEFAULT NULL,
  `suspect_age_group` varchar(20) DEFAULT NULL,
  `weapon_involved` varchar(30) DEFAULT NULL,
  `arrest_made` varchar(30) DEFAULT NULL,
  `criminal_record_found` varchar(30) DEFAULT NULL,
  `number_of_victims` int(11) DEFAULT NULL,
  `emergency_response_time` int(11) DEFAULT NULL,
  `crime_recorded_by_cctv` varchar(30) DEFAULT NULL,
  `witnesses_present` int(11) DEFAULT NULL,
  `area_type` varchar(50) DEFAULT NULL,
  `economic_status_of_area` varchar(50) DEFAULT NULL,
  `traffic_density` varchar(50) DEFAULT NULL,
  `nearby_facilities` varchar(100) DEFAULT NULL,
  `reporting_time` int(11) DEFAULT NULL,
  `crime_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_crime_record`
--

INSERT INTO `tbl_crime_record` (`crime_record_id`, `crimetime`, `latitude`, `longitude`, `crime_type`, `severity`, `police_station_jurisdiction`, `weather`, `population_density`, `proximity_to_landmark`, `time_of_day`, `day_of_week`, `holiday`, `recurring_crime_location`, `victim_age_group`, `suspect_age_group`, `weapon_involved`, `arrest_made`, `criminal_record_found`, `number_of_victims`, `emergency_response_time`, `crime_recorded_by_cctv`, `witnesses_present`, `area_type`, `economic_status_of_area`, `traffic_density`, `nearby_facilities`, `reporting_time`, `crime_id`) VALUES
(1, '2025-02-11 05:06:00.000000', 9.263513, 76.787535, '1', 'High', 'Adoor', 'Rainy', 56456, 3435, 'Morning', 'Tuesday', 'Non-Holiday', 'TRUE', '26-35', '26-35', 'TRUE', 'FALSE', 'TRUE', 1, 3, 'TRUE', 3, 'Rural', 'Middle-income', 'Medium', 'Train Station', 3, 1),
(2, '2025-02-28 04:05:00.000000', 9.264017, 76.787384, '1', 'Low', 'Adoor', 'Rainy', 3000, 1234, 'Night', 'Friday', 'Holiday', 'FALSE', '26-35', '18-25', 'TRUE', 'TRUE', 'TRUE', 4, 23, 'TRUE', 3, 'Rural', 'Low-income', 'Low', 'Hospital', 4, 2),
(3, '2025-02-27 05:04:00.000000', 9.263936, 76.786998, '1', 'Medium', 'Adoor', 'Rainy', 2343, 34, 'Morning', 'Thursday', 'Holiday', 'TRUE', '18-25', '18-25', 'TRUE', 'TRUE', 'TRUE', 3, 23, 'TRUE', 3, 'Rural', 'Low-income', 'Medium', 'School', 43, 3),
(4, '2025-02-20 04:05:00.000000', 9.265525, 76.785990, '1', 'Medium', 'Adoor', 'Rainy', 3432, 2, 'Night', 'Thursday', 'Non-Holiday', 'TRUE', '26-35', '26-35', 'FALSE', 'FALSE', 'TRUE', 2, 34, 'TRUE', 2, 'Rural', 'Middle-income', 'Medium', 'School', 20, 4),
(5, '2025-02-27 04:05:00.000000', 9.265114, 76.788050, '1', 'Low', 'Pathanamthitta', 'Rainy', 34, 3, 'Night', 'Thursday', 'Holiday', 'TRUE', '26-35', '26-35', 'TRUE', 'TRUE', 'TRUE', 3, 3, 'TRUE', 3, 'Urban', 'Low-income', 'Low', 'Train Station', 3, 5);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_crime_updates`
--

CREATE TABLE `tbl_crime_updates` (
  `crime_updates_id` int(11) NOT NULL,
  `crime_updates` longtext DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `crime_id` int(11) NOT NULL,
  `police_station_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_crime_updates`
--

INSERT INTO `tbl_crime_updates` (`crime_updates_id`, `crime_updates`, `created_at`, `crime_id`, `police_station_id`) VALUES
(1, 'Police reviewed CCTV footage from the house and nearby street cameras.', '2025-02-28 01:59:23.956914', 1, 1),
(4, 'test', '2025-02-28 02:09:16.661052', 2, 1),
(5, 'test', '2025-02-28 02:09:34.397970', 2, 1),
(6, 'test', '2025-02-28 02:09:41.752451', 3, 1),
(7, 'test', '2025-02-28 02:09:50.167585', 4, 1),
(8, 'test', '2025-02-28 02:10:03.645425', 5, 1);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_culprit`
--

CREATE TABLE `tbl_culprit` (
  `culprit_id` int(11) NOT NULL,
  `culprit_name` varchar(255) NOT NULL,
  `culprit_gender` varchar(10) NOT NULL,
  `culprit_dob` date NOT NULL,
  `culprit_address` longtext NOT NULL,
  `culprit_phone` varchar(15) NOT NULL,
  `crime_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_culprit`
--

INSERT INTO `tbl_culprit` (`culprit_id`, `culprit_name`, `culprit_gender`, `culprit_dob`, `culprit_address`, `culprit_phone`, `crime_id`) VALUES
(1, 'Mathew', 'Male', '2025-02-27', 'Mathew Villa', '9865321245', 1);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_district`
--

CREATE TABLE `tbl_district` (
  `district_id` int(11) NOT NULL,
  `district` varchar(50) NOT NULL,
  `state_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_district`
--

INSERT INTO `tbl_district` (`district_id`, `district`, `state_id`) VALUES
(1, 'North and Middle Andaman', 32),
(2, 'South Andaman', 32),
(3, 'Nicobar', 32),
(4, 'Adilabad', 1),
(5, 'Anantapur', 1),
(6, 'Chittoor', 1),
(7, 'East Godavari', 1),
(8, 'Guntur', 1),
(9, 'Hyderabad', 1),
(10, 'Kadapa', 1),
(11, 'Karimnagar', 1),
(12, 'Khammam', 1),
(13, 'Krishna', 1),
(14, 'Kurnool', 1),
(15, 'Mahbubnagar', 1),
(16, 'Medak', 1),
(17, 'Nalgonda', 1),
(18, 'Nellore', 1),
(19, 'Nizamabad', 1),
(20, 'Prakasam', 1),
(21, 'Rangareddi', 1),
(22, 'Srikakulam', 1),
(23, 'Vishakhapatnam', 1),
(24, 'Vizianagaram', 1),
(25, 'Warangal', 1),
(26, 'West Godavari', 1),
(27, 'Anjaw', 3),
(28, 'Changlang', 3),
(29, 'East Kameng', 3),
(30, 'Lohit', 3),
(31, 'Lower Subansiri', 3),
(32, 'Papum Pare', 3),
(33, 'Tirap', 3),
(34, 'Dibang Valley', 3),
(35, 'Upper Subansiri', 3),
(36, 'West Kameng', 3),
(37, 'Barpeta', 2),
(38, 'Bongaigaon', 2),
(39, 'Cachar', 2),
(40, 'Darrang', 2),
(41, 'Dhemaji', 2),
(42, 'Dhubri', 2),
(43, 'Dibrugarh', 2),
(44, 'Goalpara', 2),
(45, 'Golaghat', 2),
(46, 'Hailakandi', 2),
(47, 'Jorhat', 2),
(48, 'Karbi Anglong', 2),
(49, 'Karimganj', 2),
(50, 'Kokrajhar', 2),
(51, 'Lakhimpur', 2),
(52, 'Marigaon', 2),
(53, 'Nagaon', 2),
(54, 'Nalbari', 2),
(55, 'North Cachar Hills', 2),
(56, 'Sibsagar', 2),
(57, 'Sonitpur', 2),
(58, 'Tinsukia', 2),
(59, 'Araria', 4),
(60, 'Aurangabad', 4),
(61, 'Banka', 4),
(62, 'Begusarai', 4),
(63, 'Bhagalpur', 4),
(64, 'Bhojpur', 4),
(65, 'Buxar', 4),
(66, 'Darbhanga', 4),
(67, 'Purba Champaran', 4),
(68, 'Gaya', 4),
(69, 'Gopalganj', 4),
(70, 'Jamui', 4),
(71, 'Jehanabad', 4),
(72, 'Khagaria', 4),
(73, 'Kishanganj', 4),
(74, 'Kaimur', 4),
(75, 'Katihar', 4),
(76, 'Lakhisarai', 4),
(77, 'Madhubani', 4),
(78, 'Munger', 4),
(79, 'Madhepura', 4),
(80, 'Muzaffarpur', 4),
(81, 'Nalanda', 4),
(82, 'Nawada', 4),
(83, 'Patna', 4),
(84, 'Purnia', 4),
(85, 'Rohtas', 4),
(86, 'Saharsa', 4),
(87, 'Samastipur', 4),
(88, 'Sheohar', 4),
(89, 'Sheikhpura', 4),
(90, 'Saran', 4),
(91, 'Sitamarhi', 4),
(92, 'Supaul', 4),
(93, 'Siwan', 4),
(94, 'Vaishali', 4),
(95, 'Pashchim Champaran', 4),
(112, 'Diu', 29),
(113, 'Daman', 29),
(114, 'Central Delhi', 25),
(115, 'East Delhi', 25),
(116, 'New Delhi', 25),
(117, 'North Delhi', 25),
(118, 'North East Delhi', 25),
(119, 'North West Delhi', 25),
(120, 'South Delhi', 25),
(121, 'South West Delhi', 25),
(122, 'West Delhi', 25),
(123, 'North Goa', 26),
(124, 'South Goa', 26),
(125, 'Ahmedabad', 5),
(126, 'Amreli District', 5),
(127, 'Anand', 5),
(128, 'Banaskantha', 5),
(129, 'Bharuch', 5),
(130, 'Bhavnagar', 5),
(131, 'Dahod', 5),
(132, 'The Dangs', 5),
(133, 'Gandhinagar', 5),
(134, 'Jamnagar', 5),
(135, 'Junagadh', 5),
(136, 'Kutch', 5),
(137, 'Kheda', 5),
(138, 'Mehsana', 5),
(139, 'Narmada', 5),
(140, 'Navsari', 5),
(141, 'Patan', 5),
(142, 'Panchmahal', 5),
(143, 'Porbandar', 5),
(144, 'Rajkot', 5),
(145, 'Sabarkantha', 5),
(146, 'Surendranagar', 5),
(147, 'Surat', 5),
(148, 'Vadodara', 5),
(149, 'Valsad', 5),
(150, 'Ambala', 6),
(151, 'Bhiwani', 6),
(152, 'Faridabad', 6),
(153, 'Fatehabad', 6),
(154, 'Gurgaon', 6),
(155, 'Hissar', 6),
(156, 'Jhajjar', 6),
(157, 'Jind', 6),
(158, 'Karnal', 6),
(159, 'Kaithal', 6),
(160, 'Kurukshetra', 6),
(161, 'Mahendragarh', 6),
(162, 'Mewat', 6),
(163, 'Panchkula', 6),
(164, 'Panipat', 6),
(165, 'Rewari', 6),
(166, 'Rohtak', 6),
(167, 'Sirsa', 6),
(168, 'Sonepat', 6),
(169, 'Yamuna Nagar', 6),
(170, 'Palwal', 6),
(171, 'Bilaspur', 7),
(172, 'Chamba', 7),
(173, 'Hamirpur', 7),
(174, 'Kangra', 7),
(175, 'Kinnaur', 7),
(176, 'Kulu', 7),
(177, 'Lahaul and Spiti', 7),
(178, 'Mandi', 7),
(179, 'Shimla', 7),
(180, 'Sirmaur', 7),
(181, 'Solan', 7),
(182, 'Una', 7),
(183, 'Anantnag', 8),
(184, 'Badgam', 8),
(185, 'Bandipore', 8),
(186, 'Baramula', 8),
(187, 'Doda', 8),
(188, 'Jammu', 8),
(189, 'Kargil', 8),
(190, 'Kathua', 8),
(191, 'Kupwara', 8),
(192, 'Leh', 8),
(193, 'Poonch', 8),
(194, 'Pulwama', 8),
(195, 'Rajauri', 8),
(196, 'Srinagar', 8),
(197, 'Samba', 8),
(198, 'Udhampur', 8),
(199, 'Bokaro', 34),
(200, 'Chatra', 34),
(201, 'Deoghar', 34),
(202, 'Dhanbad', 34),
(203, 'Dumka', 34),
(204, 'Purba Singhbhum', 34),
(205, 'Garhwa', 34),
(206, 'Giridih', 34),
(207, 'Godda', 34),
(208, 'Gumla', 34),
(209, 'Hazaribagh', 34),
(210, 'Koderma', 34),
(211, 'Lohardaga', 34),
(212, 'Pakur', 34),
(213, 'Palamu', 34),
(214, 'Ranchi', 34),
(215, 'Sahibganj', 34),
(216, 'Seraikela and Kharsawan', 34),
(217, 'Pashchim Singhbhum', 34),
(218, 'Ramgarh', 34),
(219, 'Bidar', 9),
(220, 'Belgaum', 9),
(221, 'Bijapur', 9),
(222, 'Bagalkot', 9),
(223, 'Bellary', 9),
(224, 'Bangalore Rural District', 9),
(225, 'Bangalore Urban District', 9),
(226, 'Chamarajnagar', 9),
(227, 'Chikmagalur', 9),
(228, 'Chitradurga', 9),
(229, 'Davanagere', 9),
(230, 'Dharwad', 9),
(231, 'Dakshina Kannada', 9),
(232, 'Gadag', 9),
(233, 'Gulbarga', 9),
(234, 'Hassan', 9),
(235, 'Haveri District', 9),
(236, 'Kodagu', 9),
(237, 'Kolar', 9),
(238, 'Koppal', 9),
(239, 'Mandya', 9),
(240, 'Mysore', 9),
(241, 'Raichur', 9),
(242, 'Shimoga', 9),
(243, 'Tumkur', 9),
(244, 'Udupi', 9),
(245, 'Uttara Kannada', 9),
(246, 'Ramanagara', 9),
(247, 'Chikballapur', 9),
(248, 'Yadagiri', 9),
(249, 'Alappuzha', 10),
(250, 'Ernakulam', 10),
(251, 'Idukki', 10),
(252, 'Kollam', 10),
(253, 'Kannur', 10),
(254, 'Kasaragod', 10),
(255, 'Kottayam', 10),
(256, 'Kozhikode', 10),
(257, 'Malappuram', 10),
(258, 'Palakkad', 10),
(259, 'Pathanamthitta', 10),
(260, 'Thrissur', 10),
(261, 'Thiruvananthapuram', 10),
(262, 'Wayanad', 10),
(263, 'Alirajpur', 11),
(264, 'Anuppur', 11),
(265, 'Ashok Nagar', 11),
(266, 'Balaghat', 11),
(267, 'Barwani', 11),
(268, 'Betul', 11),
(269, 'Bhind', 11),
(270, 'Bhopal', 11),
(271, 'Burhanpur', 11),
(272, 'Chhatarpur', 11),
(273, 'Chhindwara', 11),
(274, 'Damoh', 11),
(275, 'Datia', 11),
(276, 'Dewas', 11),
(277, 'Dhar', 11),
(278, 'Dindori', 11),
(279, 'Guna', 11),
(280, 'Gwalior', 11),
(281, 'Harda', 11),
(282, 'Hoshangabad', 11),
(283, 'Indore', 11),
(284, 'Jabalpur', 11),
(285, 'Jhabua', 11),
(286, 'Katni', 11),
(287, 'Khandwa', 11),
(288, 'Khargone', 11),
(289, 'Mandla', 11),
(290, 'Mandsaur', 11),
(291, 'Morena', 11),
(292, 'Narsinghpur', 11),
(293, 'Neemuch', 11),
(294, 'Panna', 11),
(295, 'Rewa', 11),
(296, 'Rajgarh', 11),
(297, 'Ratlam', 11),
(298, 'Raisen', 11),
(299, 'Sagar', 11),
(300, 'Satna', 11),
(301, 'Sehore', 11),
(302, 'Seoni', 11),
(303, 'Shahdol', 11),
(304, 'Shajapur', 11),
(305, 'Sheopur', 11),
(306, 'Shivpuri', 11),
(307, 'Sidhi', 11),
(308, 'Singrauli', 11),
(309, 'Tikamgarh', 11),
(310, 'Ujjain', 11),
(311, 'Umaria', 11),
(312, 'Vidisha', 11),
(313, 'Ahmednagar', 12),
(314, 'Akola', 12),
(315, 'Amrawati', 12),
(316, 'Aurangabad', 12),
(317, 'Bhandara', 12),
(318, 'Beed', 12),
(319, 'Buldhana', 12),
(320, 'Chandrapur', 12),
(321, 'Dhule', 12),
(322, 'Gadchiroli', 12),
(323, 'Gondiya', 12),
(324, 'Hingoli', 12),
(325, 'Jalgaon', 12),
(326, 'Jalna', 12),
(327, 'Kolhapur', 12),
(328, 'Latur', 12),
(329, 'Mumbai City', 12),
(330, 'Mumbai suburban', 12),
(331, 'Nandurbar', 12),
(332, 'Nanded', 12),
(333, 'Nagpur', 12),
(334, 'Nashik', 12),
(335, 'Osmanabad', 12),
(336, 'Parbhani', 12),
(337, 'Pune', 12),
(338, 'Raigad', 12),
(339, 'Ratnagiri', 12),
(340, 'Sindhudurg', 12),
(341, 'Sangli', 12),
(342, 'Solapur', 12),
(343, 'Satara', 12),
(344, 'Thane', 12),
(345, 'Wardha', 12),
(346, 'Washim', 12),
(347, 'Yavatmal', 12),
(348, 'Bishnupur', 13),
(349, 'Churachandpur', 13),
(350, 'Chandel', 13),
(351, 'Imphal East', 13),
(352, 'Senapati', 13),
(353, 'Tamenglong', 13),
(354, 'Thoubal', 13),
(355, 'Ukhrul', 13),
(356, 'Imphal West', 13),
(357, 'East Garo Hills', 14),
(358, 'East Khasi Hills', 14),
(359, 'Jaintia Hills', 14),
(360, 'Ri-Bhoi', 14),
(361, 'South Garo Hills', 14),
(362, 'West Garo Hills', 14),
(363, 'West Khasi Hills', 14),
(364, 'Aizawl', 15),
(365, 'Champhai', 15),
(366, 'Kolasib', 15),
(367, 'Lawngtlai', 15),
(368, 'Lunglei', 15),
(369, 'Mamit', 15),
(370, 'Saiha', 15),
(371, 'Serchhip', 15),
(372, 'Dimapur', 16),
(373, 'Kohima', 16),
(374, 'Mokokchung', 16),
(375, 'Mon', 16),
(376, 'Phek', 16),
(377, 'Tuensang', 16),
(378, 'Wokha', 16),
(379, 'Zunheboto', 16),
(380, 'Angul', 17),
(381, 'Boudh', 17),
(382, 'Bhadrak', 17),
(383, 'Bolangir', 17),
(384, 'Bargarh', 17),
(385, 'Baleswar', 17),
(386, 'Cuttack', 17),
(387, 'Debagarh', 17),
(388, 'Dhenkanal', 17),
(389, 'Ganjam', 17),
(390, 'Gajapati', 17),
(391, 'Jharsuguda', 17),
(392, 'Jajapur', 17),
(393, 'Jagatsinghpur', 17),
(394, 'Khordha', 17),
(395, 'Kendujhar', 17),
(396, 'Kalahandi', 17),
(397, 'Kandhamal', 17),
(398, 'Koraput', 17),
(399, 'Kendrapara', 17),
(400, 'Malkangiri', 17),
(401, 'Mayurbhanj', 17),
(402, 'Nabarangpur', 17),
(403, 'Nuapada', 17),
(404, 'Nayagarh', 17),
(405, 'Puri', 17),
(406, 'Rayagada', 17),
(407, 'Sambalpur', 17),
(408, 'Subarnapur', 17),
(409, 'Sundargarh', 17),
(410, 'Karaikal', 27),
(411, 'Mahe', 27),
(412, 'Puducherry', 27),
(413, 'Yanam', 27),
(414, 'Amritsar', 18),
(415, 'Bathinda', 18),
(416, 'Firozpur', 18),
(417, 'Faridkot', 18),
(418, 'Fatehgarh Sahib', 18),
(419, 'Gurdaspur', 18),
(420, 'Hoshiarpur', 18),
(421, 'Jalandhar', 18),
(422, 'Kapurthala', 18),
(423, 'Ludhiana', 18),
(424, 'Mansa', 18),
(425, 'Moga', 18),
(426, 'Mukatsar', 18),
(427, 'Nawan Shehar', 18),
(428, 'Patiala', 18),
(429, 'Rupnagar', 18),
(430, 'Sangrur', 18),
(431, 'Ajmer', 19),
(432, 'Alwar', 19),
(433, 'Bikaner', 19),
(434, 'Barmer', 19),
(435, 'Banswara', 19),
(436, 'Bharatpur', 19),
(437, 'Baran', 19),
(438, 'Bundi', 19),
(439, 'Bhilwara', 19),
(440, 'Churu', 19),
(441, 'Chittorgarh', 19),
(442, 'Dausa', 19),
(443, 'Dholpur', 19),
(444, 'Dungapur', 19),
(445, 'Ganganagar', 19),
(446, 'Hanumangarh', 19),
(447, 'Juhnjhunun', 19),
(448, 'Jalore', 19),
(449, 'Jodhpur', 19),
(450, 'Jaipur', 19),
(451, 'Jaisalmer', 19),
(452, 'Jhalawar', 19),
(453, 'Karauli', 19),
(454, 'Kota', 19),
(455, 'Nagaur', 19),
(456, 'Pali', 19),
(457, 'Pratapgarh', 19),
(458, 'Rajsamand', 19),
(459, 'Sikar', 19),
(460, 'Sawai Madhopur', 19),
(461, 'Sirohi', 19),
(462, 'Tonk', 19),
(463, 'Udaipur', 19),
(464, 'East Sikkim', 20),
(465, 'North Sikkim', 20),
(466, 'South Sikkim', 20),
(467, 'West Sikkim', 20),
(468, 'Ariyalur', 21),
(469, 'Chennai', 21),
(470, 'Coimbatore', 21),
(471, 'Cuddalore', 21),
(472, 'Dharmapuri', 21),
(473, 'Dindigul', 21),
(474, 'Erode', 21),
(475, 'Kanchipuram', 21),
(476, 'Kanyakumari', 21),
(477, 'Karur', 21),
(478, 'Madurai', 21),
(479, 'Nagapattinam', 21),
(480, 'The Nilgiris', 21),
(481, 'Namakkal', 21),
(482, 'Perambalur', 21),
(483, 'Pudukkottai', 21),
(484, 'Ramanathapuram', 21),
(485, 'Salem', 21),
(486, 'Sivagangai', 21),
(487, 'Tiruppur', 21),
(488, 'Tiruchirappalli', 21),
(489, 'Theni', 21),
(490, 'Tirunelveli', 21),
(491, 'Thanjavur', 21),
(492, 'Thoothukudi', 21),
(493, 'Thiruvallur', 21),
(494, 'Thiruvarur', 21),
(495, 'Tiruvannamalai', 21),
(496, 'Vellore', 21),
(497, 'Villupuram', 21),
(498, 'Dhalai', 22),
(499, 'North Tripura', 22),
(500, 'South Tripura', 22),
(501, 'West Tripura', 22),
(502, 'Almora', 33),
(503, 'Bageshwar', 33),
(504, 'Chamoli', 33),
(505, 'Champawat', 33),
(506, 'Dehradun', 33),
(507, 'Haridwar', 33),
(508, 'Nainital', 33),
(509, 'Pauri Garhwal', 33),
(510, 'Pithoragharh', 33),
(511, 'Rudraprayag', 33),
(512, 'Tehri Garhwal', 33),
(513, 'Udham Singh Nagar', 33),
(514, 'Uttarkashi', 33),
(515, 'Agra', 23),
(516, 'Allahabad', 23),
(517, 'Aligarh', 23),
(518, 'Ambedkar Nagar', 23),
(519, 'Auraiya', 23),
(520, 'Azamgarh', 23),
(521, 'Barabanki', 23),
(522, 'Badaun', 23),
(523, 'Bagpat', 23),
(524, 'Bahraich', 23),
(525, 'Bijnor', 23),
(526, 'Ballia', 23),
(527, 'Banda', 23),
(528, 'Balrampur', 23),
(529, 'Bareilly', 23),
(530, 'Basti', 23),
(531, 'Bulandshahr', 23),
(532, 'Chandauli', 23),
(533, 'Chitrakoot', 23),
(534, 'Deoria', 23),
(535, 'Etah', 23),
(536, 'Kanshiram Nagar', 23),
(537, 'Etawah', 23),
(538, 'Firozabad', 23),
(539, 'Farrukhabad', 23),
(540, 'Fatehpur', 23),
(541, 'Faizabad', 23),
(542, 'Gautam Buddha Nagar', 23),
(543, 'Gonda', 23),
(544, 'Ghazipur', 23),
(545, 'Gorkakhpur', 23),
(546, 'Ghaziabad', 23),
(547, 'Hamirpur', 23),
(548, 'Hardoi', 23),
(549, 'Mahamaya Nagar', 23),
(550, 'Jhansi', 23),
(551, 'Jalaun', 23),
(552, 'Jyotiba Phule Nagar', 23),
(553, 'Jaunpur District', 23),
(554, 'Kanpur Dehat', 23),
(555, 'Kannauj', 23),
(556, 'Kanpur Nagar', 23),
(557, 'Kaushambi', 23),
(558, 'Kushinagar', 23),
(559, 'Lalitpur', 23),
(560, 'Lakhimpur Kheri', 23),
(561, 'Lucknow', 23),
(562, 'Mau', 23),
(563, 'Meerut', 23),
(564, 'Maharajganj', 23),
(565, 'Mahoba', 23),
(566, 'Mirzapur', 23),
(567, 'Moradabad', 23),
(568, 'Mainpuri', 23),
(569, 'Mathura', 23),
(570, 'Muzaffarnagar', 23),
(571, 'Pilibhit', 23),
(572, 'Pratapgarh', 23),
(573, 'Rampur', 23),
(574, 'Rae Bareli', 23),
(575, 'Saharanpur', 23),
(576, 'Sitapur', 23),
(577, 'Shahjahanpur', 23),
(578, 'Sant Kabir Nagar', 23),
(579, 'Siddharthnagar', 23),
(580, 'Sonbhadra', 23),
(581, 'Sant Ravidas Nagar', 23),
(582, 'Sultanpur', 23),
(583, 'Shravasti', 23),
(584, 'Unnao', 23),
(585, 'Varanasi', 23),
(586, 'Birbhum', 24),
(587, 'Bankura', 24),
(588, 'Bardhaman', 24),
(589, 'Darjeeling', 24),
(590, 'Dakshin Dinajpur', 24),
(591, 'Hooghly', 24),
(592, 'Howrah', 24),
(593, 'Jalpaiguri', 24),
(594, 'Cooch Behar', 24),
(595, 'Kolkata', 24),
(596, 'Malda', 24),
(597, 'Midnapore', 24),
(598, 'Murshidabad', 24),
(599, 'Nadia', 24),
(600, 'North 24 Parganas', 24),
(601, 'South 24 Parganas', 24),
(602, 'Purulia', 24),
(603, 'Uttar Dinajpur', 24);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_feedback`
--

CREATE TABLE `tbl_feedback` (
  `feedback_id` int(11) NOT NULL,
  `feedback` varchar(150) NOT NULL,
  `reply` varchar(50) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_feedback`
--

INSERT INTO `tbl_feedback` (`feedback_id`, `feedback`, `reply`, `user_id`) VALUES
(1, 'thank you for you service', 'Test reply', 2),
(2, 'test feedback', NULL, 2);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_login`
--

CREATE TABLE `tbl_login` (
  `login_id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `user_type` varchar(50) NOT NULL,
  `status` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_login`
--

INSERT INTO `tbl_login` (`login_id`, `username`, `password`, `user_type`, `status`) VALUES
(8, 'adoorplc123', 'adoorplc123', 'Police Station', 'Approved'),
(10, 'chinnu123', 'chinnu123', 'User', 'Approved'),
(11, 'athulya123', 'athulya123', 'User', 'Approved'),
(12, 'ram123', 'ram123', 'User', 'Approved'),
(14, 'plcpadm13', 'plcpadm13', 'Police Station', 'Approved');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_police_station`
--

CREATE TABLE `tbl_police_station` (
  `police_station_id` int(11) NOT NULL,
  `place` varchar(50) DEFAULT NULL,
  `address` longtext DEFAULT NULL,
  `phone_number` bigint(20) DEFAULT NULL,
  `mail_id` varchar(50) NOT NULL,
  `district_id` int(11) NOT NULL,
  `login_id` int(11) NOT NULL,
  `latitude` decimal(18,15) DEFAULT NULL,
  `longitude` decimal(18,15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_police_station`
--

INSERT INTO `tbl_police_station` (`police_station_id`, `place`, `address`, `phone_number`, `mail_id`, `district_id`, `login_id`, `latitude`, `longitude`) VALUES
(1, 'Adoor', 'Adoor Near KSRTC', 9876853333, 'phebaebenezer@gmail.com', 259, 8, 26.851622804870605, 80.941163870605000),
(3, 'Pandalam', 'Pandalam', 9844556614, 'phebaebenezer@gmail.com', 259, 14, 9.233943172306860, 76.674914360046390);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_prediction`
--

CREATE TABLE `tbl_prediction` (
  `prediction_id` int(11) NOT NULL,
  `latitude` decimal(12,6) DEFAULT NULL,
  `longitude` decimal(12,6) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `predicted_crime_type` varchar(100) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_prediction`
--

INSERT INTO `tbl_prediction` (`prediction_id`, `latitude`, `longitude`, `created_at`, `predicted_crime_type`, `user_id`) VALUES
(1, 9.265230, 76.787000, '2025-02-18 10:37:41.496930', 'Robbery', 4);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_prediction_police`
--

CREATE TABLE `tbl_prediction_police` (
  `prediction_id` int(11) NOT NULL,
  `latitude` decimal(12,6) DEFAULT NULL,
  `longitude` decimal(12,6) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `predicted_crime_type` varchar(100) DEFAULT NULL,
  `police_station_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_state`
--

CREATE TABLE `tbl_state` (
  `state_id` int(11) NOT NULL,
  `state` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_state`
--

INSERT INTO `tbl_state` (`state_id`, `state`) VALUES
(1, 'ANDHRA PRADESH'),
(2, 'ASSAM'),
(3, 'ARUNACHAL PRADESH'),
(4, 'BIHAR'),
(5, 'GUJRAT'),
(6, 'HARYANA'),
(7, 'HIMACHAL PRADESH'),
(8, 'JAMMU & KASHMIR'),
(9, 'KARNATAKA'),
(10, 'KERALA'),
(11, 'MADHYA PRADESH'),
(12, 'MAHARASHTRA'),
(13, 'MANIPUR'),
(14, 'MEGHALAYA'),
(15, 'MIZORAM'),
(16, 'NAGALAND'),
(17, 'ORISSA'),
(18, 'PUNJAB'),
(19, 'RAJASTHAN'),
(20, 'SIKKIM'),
(21, 'TAMIL NADU'),
(22, 'TRIPURA'),
(23, 'UTTAR PRADESH'),
(24, 'WEST BENGAL'),
(25, 'DELHI'),
(26, 'GOA'),
(27, 'PONDICHERY'),
(28, 'LAKSHDWEEP'),
(29, 'DAMAN & DIU'),
(30, 'DADRA & NAGAR'),
(31, 'CHANDIGARH'),
(32, 'ANDAMAN & NICOBAR'),
(33, 'UTTARANCHAL'),
(34, 'JHARKHAND'),
(35, 'CHATTISGARH');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_user`
--

CREATE TABLE `tbl_user` (
  `user_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `phone_number` varchar(20) NOT NULL,
  `email_id` varchar(254) NOT NULL,
  `dob` date DEFAULT NULL,
  `address` longtext DEFAULT NULL,
  `login_id` int(11) NOT NULL,
  `latitude` decimal(18,15) DEFAULT NULL,
  `longitude` decimal(18,15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_user`
--

INSERT INTO `tbl_user` (`user_id`, `name`, `phone_number`, `email_id`, `dob`, `address`, `login_id`, `latitude`, `longitude`) VALUES
(2, 'Chinnu', '7896857421', 'phebaebenezer@gmail.com', '2025-01-22', 'Chinnu Villa', 10, 26.851622804870605, 80.941163870605000),
(3, 'Athulya', '9874563254', 'phebaebenezertech@gmail.com', '2025-02-06', 'athulya villa', 11, 26.851622804870605, 80.941163870605000),
(4, 'Ram', '8485691221', 'phebaebenezer@gmail.com', '2025-02-06', 'Ram Villa', 12, 9.266693641370656, 76.787534526458740);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Indexes for table `auth_user`
--
ALTER TABLE `auth_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  ADD KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`);

--
-- Indexes for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  ADD KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indexes for table `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- Indexes for table `tbl_category`
--
ALTER TABLE `tbl_category`
  ADD PRIMARY KEY (`category_id`);

--
-- Indexes for table `tbl_crime`
--
ALTER TABLE `tbl_crime`
  ADD PRIMARY KEY (`crime_id`),
  ADD KEY `tbl_crime_category_id_8847fcb8_fk_tbl_category_category_id` (`category_id`),
  ADD KEY `tbl_crime_district_id_bc9eae66_fk_tbl_district_district_id` (`district_id`),
  ADD KEY `tbl_crime_police_station_id_aebbd74e_fk_tbl_polic` (`police_station_id`),
  ADD KEY `tbl_crime_user_id_05076107_fk_tbl_user_user_id` (`user_id`);

--
-- Indexes for table `tbl_crime_hot_spot`
--
ALTER TABLE `tbl_crime_hot_spot`
  ADD PRIMARY KEY (`crim_hotspot_id`),
  ADD KEY `tbl_crime_hot_spot_user_id_fd66934d_fk_tbl_user_user_id` (`user_id`);

--
-- Indexes for table `tbl_crime_hot_spot_police`
--
ALTER TABLE `tbl_crime_hot_spot_police`
  ADD PRIMARY KEY (`crim_hotspot_id`),
  ADD KEY `tbl_crime_hot_spot_p_police_station_id_1d68002f_fk_tbl_polic` (`police_station_id`);

--
-- Indexes for table `tbl_crime_record`
--
ALTER TABLE `tbl_crime_record`
  ADD PRIMARY KEY (`crime_record_id`),
  ADD KEY `tbl_crime_record_crime_id_b1c9cc06_fk_tbl_crime_crime_id` (`crime_id`);

--
-- Indexes for table `tbl_crime_updates`
--
ALTER TABLE `tbl_crime_updates`
  ADD PRIMARY KEY (`crime_updates_id`),
  ADD KEY `tbl_crime_updates_crime_id_faaed32c_fk_tbl_crime_crime_id` (`crime_id`),
  ADD KEY `tbl_crime_updates_police_station_id_b8aada6a_fk_tbl_polic` (`police_station_id`);

--
-- Indexes for table `tbl_culprit`
--
ALTER TABLE `tbl_culprit`
  ADD PRIMARY KEY (`culprit_id`),
  ADD KEY `tbl_culprit_crime_id_a0a14f89_fk_tbl_crime_crime_id` (`crime_id`);

--
-- Indexes for table `tbl_district`
--
ALTER TABLE `tbl_district`
  ADD PRIMARY KEY (`district_id`),
  ADD KEY `tbl_district_state_id_d62f4398_fk_tbl_state_state_id` (`state_id`);

--
-- Indexes for table `tbl_feedback`
--
ALTER TABLE `tbl_feedback`
  ADD PRIMARY KEY (`feedback_id`),
  ADD KEY `tbl_feedback_user_id_3cb0c17a_fk_tbl_user_user_id` (`user_id`);

--
-- Indexes for table `tbl_login`
--
ALTER TABLE `tbl_login`
  ADD PRIMARY KEY (`login_id`);

--
-- Indexes for table `tbl_police_station`
--
ALTER TABLE `tbl_police_station`
  ADD PRIMARY KEY (`police_station_id`),
  ADD KEY `tbl_police_station_district_id_f5f1a54e_fk_tbl_distr` (`district_id`),
  ADD KEY `tbl_police_station_login_id_361602f8_fk_tbl_login_login_id` (`login_id`);

--
-- Indexes for table `tbl_prediction`
--
ALTER TABLE `tbl_prediction`
  ADD PRIMARY KEY (`prediction_id`),
  ADD KEY `tbl_prediction_user_id_b7fdc61d_fk_tbl_user_user_id` (`user_id`);

--
-- Indexes for table `tbl_prediction_police`
--
ALTER TABLE `tbl_prediction_police`
  ADD PRIMARY KEY (`prediction_id`),
  ADD KEY `tbl_prediction_polic_police_station_id_51f4fe24_fk_tbl_polic` (`police_station_id`);

--
-- Indexes for table `tbl_state`
--
ALTER TABLE `tbl_state`
  ADD PRIMARY KEY (`state_id`);

--
-- Indexes for table `tbl_user`
--
ALTER TABLE `tbl_user`
  ADD PRIMARY KEY (`user_id`),
  ADD KEY `tbl_user_login_id_c01ffcaf_fk_tbl_login_login_id` (`login_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=85;

--
-- AUTO_INCREMENT for table `auth_user`
--
ALTER TABLE `auth_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `tbl_category`
--
ALTER TABLE `tbl_category`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tbl_crime`
--
ALTER TABLE `tbl_crime`
  MODIFY `crime_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `tbl_crime_hot_spot`
--
ALTER TABLE `tbl_crime_hot_spot`
  MODIFY `crim_hotspot_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `tbl_crime_hot_spot_police`
--
ALTER TABLE `tbl_crime_hot_spot_police`
  MODIFY `crim_hotspot_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tbl_crime_record`
--
ALTER TABLE `tbl_crime_record`
  MODIFY `crime_record_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `tbl_crime_updates`
--
ALTER TABLE `tbl_crime_updates`
  MODIFY `crime_updates_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `tbl_culprit`
--
ALTER TABLE `tbl_culprit`
  MODIFY `culprit_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tbl_district`
--
ALTER TABLE `tbl_district`
  MODIFY `district_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=604;

--
-- AUTO_INCREMENT for table `tbl_feedback`
--
ALTER TABLE `tbl_feedback`
  MODIFY `feedback_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tbl_login`
--
ALTER TABLE `tbl_login`
  MODIFY `login_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `tbl_police_station`
--
ALTER TABLE `tbl_police_station`
  MODIFY `police_station_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tbl_prediction`
--
ALTER TABLE `tbl_prediction`
  MODIFY `prediction_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tbl_prediction_police`
--
ALTER TABLE `tbl_prediction_police`
  MODIFY `prediction_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_state`
--
ALTER TABLE `tbl_state`
  MODIFY `state_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `tbl_user`
--
ALTER TABLE `tbl_user`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Constraints for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Constraints for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `tbl_crime`
--
ALTER TABLE `tbl_crime`
  ADD CONSTRAINT `tbl_crime_category_id_8847fcb8_fk_tbl_category_category_id` FOREIGN KEY (`category_id`) REFERENCES `tbl_category` (`category_id`),
  ADD CONSTRAINT `tbl_crime_district_id_bc9eae66_fk_tbl_district_district_id` FOREIGN KEY (`district_id`) REFERENCES `tbl_district` (`district_id`),
  ADD CONSTRAINT `tbl_crime_police_station_id_aebbd74e_fk_tbl_polic` FOREIGN KEY (`police_station_id`) REFERENCES `tbl_police_station` (`police_station_id`),
  ADD CONSTRAINT `tbl_crime_user_id_05076107_fk_tbl_user_user_id` FOREIGN KEY (`user_id`) REFERENCES `tbl_user` (`user_id`);

--
-- Constraints for table `tbl_crime_hot_spot`
--
ALTER TABLE `tbl_crime_hot_spot`
  ADD CONSTRAINT `tbl_crime_hot_spot_user_id_fd66934d_fk_tbl_user_user_id` FOREIGN KEY (`user_id`) REFERENCES `tbl_user` (`user_id`);

--
-- Constraints for table `tbl_crime_hot_spot_police`
--
ALTER TABLE `tbl_crime_hot_spot_police`
  ADD CONSTRAINT `tbl_crime_hot_spot_p_police_station_id_1d68002f_fk_tbl_polic` FOREIGN KEY (`police_station_id`) REFERENCES `tbl_police_station` (`police_station_id`);

--
-- Constraints for table `tbl_crime_record`
--
ALTER TABLE `tbl_crime_record`
  ADD CONSTRAINT `tbl_crime_record_crime_id_b1c9cc06_fk_tbl_crime_crime_id` FOREIGN KEY (`crime_id`) REFERENCES `tbl_crime` (`crime_id`);

--
-- Constraints for table `tbl_crime_updates`
--
ALTER TABLE `tbl_crime_updates`
  ADD CONSTRAINT `tbl_crime_updates_crime_id_faaed32c_fk_tbl_crime_crime_id` FOREIGN KEY (`crime_id`) REFERENCES `tbl_crime` (`crime_id`),
  ADD CONSTRAINT `tbl_crime_updates_police_station_id_b8aada6a_fk_tbl_polic` FOREIGN KEY (`police_station_id`) REFERENCES `tbl_police_station` (`police_station_id`);

--
-- Constraints for table `tbl_culprit`
--
ALTER TABLE `tbl_culprit`
  ADD CONSTRAINT `tbl_culprit_crime_id_a0a14f89_fk_tbl_crime_crime_id` FOREIGN KEY (`crime_id`) REFERENCES `tbl_crime` (`crime_id`);

--
-- Constraints for table `tbl_district`
--
ALTER TABLE `tbl_district`
  ADD CONSTRAINT `tbl_district_state_id_d62f4398_fk_tbl_state_state_id` FOREIGN KEY (`state_id`) REFERENCES `tbl_state` (`state_id`);

--
-- Constraints for table `tbl_feedback`
--
ALTER TABLE `tbl_feedback`
  ADD CONSTRAINT `tbl_feedback_user_id_3cb0c17a_fk_tbl_user_user_id` FOREIGN KEY (`user_id`) REFERENCES `tbl_user` (`user_id`);

--
-- Constraints for table `tbl_police_station`
--
ALTER TABLE `tbl_police_station`
  ADD CONSTRAINT `tbl_police_station_district_id_f5f1a54e_fk_tbl_distr` FOREIGN KEY (`district_id`) REFERENCES `tbl_district` (`district_id`),
  ADD CONSTRAINT `tbl_police_station_login_id_361602f8_fk_tbl_login_login_id` FOREIGN KEY (`login_id`) REFERENCES `tbl_login` (`login_id`);

--
-- Constraints for table `tbl_prediction`
--
ALTER TABLE `tbl_prediction`
  ADD CONSTRAINT `tbl_prediction_user_id_b7fdc61d_fk_tbl_user_user_id` FOREIGN KEY (`user_id`) REFERENCES `tbl_user` (`user_id`);

--
-- Constraints for table `tbl_prediction_police`
--
ALTER TABLE `tbl_prediction_police`
  ADD CONSTRAINT `tbl_prediction_polic_police_station_id_51f4fe24_fk_tbl_polic` FOREIGN KEY (`police_station_id`) REFERENCES `tbl_police_station` (`police_station_id`);

--
-- Constraints for table `tbl_user`
--
ALTER TABLE `tbl_user`
  ADD CONSTRAINT `tbl_user_login_id_c01ffcaf_fk_tbl_login_login_id` FOREIGN KEY (`login_id`) REFERENCES `tbl_login` (`login_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
