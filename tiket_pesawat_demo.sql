-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 29, 2021 at 12:52 AM
-- Server version: 10.4.21-MariaDB
-- PHP Version: 8.0.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `tiket_pesawat`
--

-- --------------------------------------------------------

--
-- Table structure for table `airports`
--

CREATE TABLE `airports` (
  `id` int(10) UNSIGNED NOT NULL,
  `code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `city` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `airport_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `airports`
--

INSERT INTO `airports` (`id`, `code`, `city`, `airport_name`, `created_at`, `updated_at`) VALUES
(1, 'EfMYA', 'Samarinda', 'APT. Pranoto Airport', '2021-12-12 00:54:20', '2021-12-12 00:54:20'),
(2, 'eqiU5', 'Tangerang', 'Soekarno-Hatta Airport', '2021-12-12 00:54:20', '2021-12-12 00:54:20'),
(5, 'lo21', 'Makassar', 'Internasional Sultan Hassanudin Airport', '2021-12-22 21:45:59', '2021-12-22 21:45:59'),
(6, 'k4m1', 'Denpasar', 'Internasional Ngurah Rai Airport', '2021-12-22 22:02:17', '2021-12-22 22:02:17'),
(7, 'hk84', 'Siduarjo', 'International Djuanda Airport', '2021-12-23 00:20:39', '2021-12-23 00:20:39');

-- --------------------------------------------------------

--
-- Table structure for table `bank_accounts`
--

CREATE TABLE `bank_accounts` (
  `id` int(10) UNSIGNED NOT NULL,
  `bank` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `account_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `account_number` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `bank_accounts`
--

INSERT INTO `bank_accounts` (`id`, `bank`, `account_name`, `account_number`, `created_at`, `updated_at`) VALUES
(1, 'BCA', 'BankBCA', '30146', '2021-12-12 00:54:17', '2021-12-12 00:54:17'),
(2, 'BRI', 'BankBRI', '76706', '2021-12-12 00:54:17', '2021-12-12 00:54:17'),
(3, 'Mandiri', 'BankMandiri', '30717', '2021-12-12 00:54:17', '2021-12-12 00:54:17');

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

CREATE TABLE `bookings` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `schedule_id` int(11) NOT NULL,
  `booking_code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `vehicle` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `bill` decimal(10,2) NOT NULL,
  `expire` datetime NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `bookings`
--

-- (data `bookings` dihapus untuk versi publik)

--
-- Triggers `bookings`
--
DELIMITER $$
CREATE TRIGGER `restore_booking` BEFORE DELETE ON `bookings` FOR EACH ROW BEGIN
          SET @oldP = (SELECT passenger FROM detail_bookings WHERE booking_id = OLD.id);
          SET @oldC = (SELECT class FROM detail_bookings WHERE booking_id = OLD.id);
          IF old.vehicle = 'plane' THEN
            IF @oldC = 'eco_seat' THEN
              UPDATE plane_schedules SET eco_seat = eco_seat + @oldP WHERE id = OLD.schedule_id;
            ELSEIF @oldC = 'bus_seat' THEN
              UPDATE plane_schedules SET bus_seat = bus_seat + @oldP WHERE id = OLD.schedule_id;
            ELSEIF @oldC = 'first_seat' THEN
              UPDATE plane_schedules SET first_seat = first_seat + @oldP WHERE id = OLD.schedule_id;
            END IF;
          ELSEIF old.vehicle = 'train' THEN
            IF @oldC = 'eco_seat' THEN
              UPDATE train_schedules SET eco_seat = eco_seat + @oldP WHERE id = OLD.schedule_id;
            ELSEIF @oldC = 'bus_seat' THEN
              UPDATE train_schedules SET bus_seat = bus_seat + @oldP WHERE id = OLD.schedule_id;
            ELSEIF @oldC = 'exec_seat' THEN
              UPDATE train_schedules SET exec_seat = exec_seat + @oldP WHERE id = OLD.schedule_id;
            END IF;
          END IF;
        END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `detail_bookings`
--

CREATE TABLE `detail_bookings` (
  `id` int(10) UNSIGNED NOT NULL,
  `booking_id` int(10) UNSIGNED NOT NULL,
  `passenger` int(11) NOT NULL,
  `class` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `detail_bookings`
--

-- (data `detail_bookings` dihapus untuk versi publik)

-- --------------------------------------------------------

--
-- Table structure for table `groups`
--

CREATE TABLE `groups` (
  `id` int(10) UNSIGNED NOT NULL,
  `group` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `groups`
--

INSERT INTO `groups` (`id`, `group`, `created_at`, `updated_at`) VALUES
(1, 'member', '2021-12-12 00:54:15', '2021-12-12 00:54:15'),
(2, 'admin', '2021-12-12 00:54:15', '2021-12-12 00:54:15'),
(8, 'member', '2021-12-22 13:36:10', '2021-12-22 13:36:10'),
(9, 'member', '2021-12-22 13:46:28', '2021-12-22 13:46:28'),
(10, 'member', '2021-12-22 13:47:28', '2021-12-22 13:47:28'),
(11, 'member', '2021-12-22 16:19:41', '2021-12-22 16:19:41'),
(12, 'member', '2021-12-22 21:56:27', '2021-12-22 21:56:27'),
(13, 'member', '2021-12-23 00:24:09', '2021-12-23 00:24:09');

-- --------------------------------------------------------

--
-- Table structure for table `group_user`
--

CREATE TABLE `group_user` (
  `id` int(10) UNSIGNED NOT NULL,
  `group_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `group_user`
--

INSERT INTO `group_user` (`id`, `group_id`, `user_id`, `created_at`, `updated_at`) VALUES
(1, 1, 1, '2021-12-12 00:54:15', '2021-12-12 00:54:15'),
(2, 2, 2, '2021-12-12 00:54:15', '2021-12-12 00:54:15');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2014_10_12_100001_create_groups_table', 1),
(4, '2014_10_12_100002_create_group_user_table', 1),
(5, '2018_01_25_154144_create_bookings_table', 1),
(6, '2018_01_25_154250_create_detail_bookings_table', 1),
(7, '2018_01_25_154251_create_transactions_table', 1),
(8, '2018_01_25_154314_create_passengers_table', 1),
(9, '2018_01_25_154441_create_planes_table', 1),
(10, '2018_01_25_154442_create_plane_fares_table', 1),
(11, '2018_01_25_154443_create_airports_table', 1),
(12, '2018_01_25_154453_create_plane_schedules_table', 1),
(13, '2018_02_11_150535_create_trains_table', 1),
(14, '2018_02_11_150536_create_train_stations', 1),
(15, '2018_02_11_150537_create_train_fares', 1),
(16, '2018_02_11_150620_create_train_schedules', 1),
(17, '2018_02_21_084438_create_bank_accounts_table', 1),
(18, '2018_03_10_210210_create_trigger_booking', 1);

-- --------------------------------------------------------

--
-- Table structure for table `passengers`
--

CREATE TABLE `passengers` (
  `id` int(10) UNSIGNED NOT NULL,
  `detail_booking_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `passengers`
--

-- (data `passengers` dihapus untuk versi publik)

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `password_resets`
--

-- (data `password_resets` dihapus untuk versi publik)

-- --------------------------------------------------------

--
-- Table structure for table `planes`
--

CREATE TABLE `planes` (
  `id` int(10) UNSIGNED NOT NULL,
  `plane_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `eco_seat` int(11) NOT NULL,
  `bus_seat` int(11) NOT NULL,
  `first_seat` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `planes`
--

INSERT INTO `planes` (`id`, `plane_name`, `eco_seat`, `bus_seat`, `first_seat`, `created_at`, `updated_at`) VALUES
(1, 'Garuda Indonesia', 7, 4, 17, '2021-12-12 00:54:19', '2021-12-12 00:54:19'),
(2, 'Citilink', 16, 12, 5, '2021-12-12 00:54:20', '2021-12-12 00:54:20'),
(3, 'Sriwijaya Air', 8, 7, 12, '2021-12-12 00:54:20', '2021-12-12 00:54:20'),
(4, 'Lion Air', 4, 19, 20, '2021-12-12 00:54:20', '2021-12-12 00:54:20'),
(5, 'Batik Air', 10, 2, 20, '2021-12-12 00:54:20', '2021-12-12 00:54:20'),
(8, 'Cardig Air', 20, 34, 12, '2021-12-22 21:49:12', '2021-12-22 21:49:12'),
(9, 'Indonesia Air Transport', 5, 8, 12, '2021-12-22 22:03:25', '2021-12-22 22:03:25'),
(10, 'AirAsia X', 5, 10, 15, '2021-12-23 00:21:30', '2021-12-23 00:21:30');

-- --------------------------------------------------------

--
-- Table structure for table `plane_fares`
--

CREATE TABLE `plane_fares` (
  `id` int(10) UNSIGNED NOT NULL,
  `plane_id` int(10) UNSIGNED NOT NULL,
  `eco_seat` decimal(10,2) NOT NULL,
  `bus_seat` decimal(10,2) NOT NULL,
  `first_seat` decimal(10,2) NOT NULL,
  `unique_code` decimal(10,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `plane_fares`
--

INSERT INTO `plane_fares` (`id`, `plane_id`, `eco_seat`, `bus_seat`, `first_seat`, `unique_code`, `created_at`, `updated_at`) VALUES
(1, 1, '300000.00', '600000.00', '900000.00', '22.00', '2021-12-12 00:54:20', '2021-12-12 11:45:05'),
(2, 2, '200000.00', '400000.00', '600000.00', '948.00', '2021-12-12 00:54:20', '2021-12-12 11:45:32'),
(3, 3, '250000.00', '500000.00', '750000.00', '217.00', '2021-12-12 00:54:20', '2021-12-12 11:45:48'),
(4, 4, '200000.00', '400000.00', '700000.00', '259.00', '2021-12-12 00:54:20', '2021-12-12 11:46:25'),
(5, 5, '250000.00', '350000.00', '550000.00', '475.00', '2021-12-12 00:54:21', '2021-12-12 11:46:52'),
(8, 8, '200000.00', '300000.00', '500000.00', '530.00', '2021-12-22 21:49:12', '2021-12-22 21:49:12'),
(9, 9, '150000.00', '250000.00', '400000.00', '786.00', '2021-12-22 22:03:25', '2021-12-22 22:03:25'),
(10, 10, '200000.00', '400000.00', '500000.00', '512.00', '2021-12-23 00:21:30', '2021-12-23 00:21:30');

-- --------------------------------------------------------

--
-- Table structure for table `plane_schedules`
--

CREATE TABLE `plane_schedules` (
  `id` int(10) UNSIGNED NOT NULL,
  `airport_id` int(10) UNSIGNED NOT NULL,
  `plane_id` int(10) UNSIGNED NOT NULL,
  `from` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `destination` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `from_code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `destination_code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `eco_seat` int(11) NOT NULL,
  `bus_seat` int(11) NOT NULL,
  `first_seat` int(11) NOT NULL,
  `boarding_time` datetime NOT NULL,
  `duration` int(11) NOT NULL,
  `gate` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `plane_schedules`
--

INSERT INTO `plane_schedules` (`id`, `airport_id`, `plane_id`, `from`, `destination`, `from_code`, `destination_code`, `eco_seat`, `bus_seat`, `first_seat`, `boarding_time`, `duration`, `gate`, `created_at`, `updated_at`) VALUES
(21, 1, 1, 'APT. Pranoto Airport', 'Soekarno-Hatta Airport', 'EfMYA', 'eqiU5', 7, 4, 17, '2021-11-25 07:00:00', 1639252800, '60', '2021-12-12 11:51:12', '2021-12-12 11:51:12'),
(22, 1, 3, 'APT. Pranoto Airport', 'Soekarno-Hatta Airport', 'EfMYA', 'eqiU5', 8, 7, 12, '2021-11-25 12:00:00', 1639252800, '96', '2021-12-12 11:57:13', '2021-12-12 11:57:13'),
(23, 1, 4, 'APT. Pranoto Airport', 'Soekarno-Hatta Airport', 'EfMYA', 'eqiU5', 4, 19, 20, '2021-11-24 16:00:00', 1639251000, '55', '2021-12-12 11:58:21', '2021-12-12 11:58:21'),
(24, 2, 1, 'Soekarno-Hatta Airport', 'APT. Pranoto Airport', 'eqiU5', 'EfMYA', 7, 4, 17, '2021-11-25 09:00:00', 1639249200, '68', '2021-12-12 11:58:54', '2021-12-12 11:58:54'),
(25, 2, 3, 'Soekarno-Hatta Airport', 'APT. Pranoto Airport', 'eqiU5', 'EfMYA', 8, 7, 12, '2021-11-25 14:00:00', 1639249800, '45', '2021-12-12 11:59:47', '2021-12-12 11:59:47'),
(26, 1, 2, 'APT. Pranoto Airport', 'Soekarno-Hatta Airport', 'EfMYA', 'eqiU5', 16, 12, 5, '2021-12-01 08:00:00', 1639248900, '32', '2021-12-12 12:00:53', '2021-12-12 12:00:53'),
(27, 1, 5, 'APT. Pranoto Airport', 'Soekarno-Hatta Airport', 'EfMYA', 'eqiU5', 10, 2, 20, '2021-12-01 12:00:00', 1639249200, '50', '2021-12-12 12:01:33', '2021-12-12 12:01:33'),
(28, 2, 5, 'Soekarno-Hatta Airport', 'APT. Pranoto Airport', 'eqiU5', 'EfMYA', 10, 2, 20, '2021-12-01 10:00:00', 1639249200, '58', '2021-12-12 12:02:35', '2021-12-12 12:02:35'),
(29, 1, 1, 'APT. Pranoto Airport', 'Soekarno-Hatta Airport', 'EfMYA', 'eqiU5', 7, 4, 17, '2021-12-07 07:00:00', 1639248600, '85', '2021-12-12 12:03:45', '2021-12-12 12:03:45'),
(30, 1, 3, 'APT. Pranoto Airport', 'Soekarno-Hatta Airport', 'EfMYA', 'eqiU5', 8, 7, 12, '2021-12-07 13:30:00', 1639251900, '74', '2021-12-12 12:04:20', '2021-12-12 12:04:20'),
(31, 2, 1, 'Soekarno-Hatta Airport', 'APT. Pranoto Airport', 'eqiU5', 'EfMYA', 7, 4, 17, '2021-12-07 08:30:00', 1639249200, '90', '2021-12-12 12:05:19', '2021-12-12 12:05:19'),
(32, 2, 4, 'Soekarno-Hatta Airport', 'APT. Pranoto Airport', 'eqiU5', 'EfMYA', 4, 19, 20, '2021-12-07 12:30:00', 1639252800, '99', '2021-12-12 12:06:03', '2021-12-12 12:06:03'),
(33, 1, 1, 'APT. Pranoto Airport', 'Soekarno-Hatta Airport', 'EfMYA', 'eqiU5', 2, 4, 17, '2021-12-16 11:30:00', 1639249200, '48', '2021-12-12 12:06:40', '2021-12-15 05:19:19'),
(34, 2, 1, 'Soekarno-Hatta Airport', 'APT. Pranoto Airport', 'eqiU5', 'EfMYA', 4, 4, 17, '2021-12-16 13:30:00', 1639249200, '49', '2021-12-12 12:07:12', '2021-12-15 05:19:19'),
(37, 1, 1, 'APT. Pranoto Airport', 'Soekarno-Hatta Airport', 'EfMYA', 'eqiU5', 6, 3, 17, '2021-12-18 00:00:00', 1639623600, '25', '2021-12-15 16:17:28', '2021-12-15 19:45:07'),
(38, 1, 1, 'APT. Pranoto Airport', 'Soekarno-Hatta Airport', 'EfMYA', 'eqiU5', 2, 3, 17, '2021-12-25 07:00:00', 1640142000, '65', '2021-12-22 10:44:57', '2021-12-22 16:22:13'),
(39, 1, 3, 'APT. Pranoto Airport', 'Soekarno-Hatta Airport', 'EfMYA', 'eqiU5', 8, 7, 12, '2021-12-27 09:00:00', 1640224800, '21', '2021-12-22 16:32:12', '2021-12-22 16:32:12'),
(40, 2, 2, 'Soekarno-Hatta Airport', 'APT. Pranoto Airport', 'eqiU5', 'EfMYA', 16, 12, 5, '2021-12-31 04:00:00', 1640228400, '24', '2021-12-22 17:57:48', '2021-12-22 17:57:48'),
(41, 1, 5, 'APT. Pranoto Airport', 'Internasional Sultan Hassanudin Airport', 'EfMYA', 'lo21', 10, 2, 20, '2021-12-23 09:00:00', 1640228400, '23', '2021-12-22 21:54:45', '2021-12-22 21:54:45'),
(42, 5, 8, 'Internasional Sultan Hassanudin Airport', 'Soekarno-Hatta Airport', 'lo21', 'eqiU5', 19, 34, 12, '2021-12-26 10:00:00', 1640228400, '5', '2021-12-22 21:55:17', '2021-12-22 21:57:03'),
(43, 6, 9, 'Internasional Ngurah Rai Airport', 'Internasional Sultan Hassanudin Airport', 'k4m1', 'lo21', 5, 8, 12, '2021-12-27 09:00:00', 1640224800, '12', '2021-12-22 22:03:59', '2021-12-22 22:03:59'),
(44, 7, 10, 'International Djuanda Airport', 'Internasional Ngurah Rai Airport', 'hk84', 'k4m1', 3, 10, 15, '2021-12-24 09:00:00', 1640228400, '15', '2021-12-23 00:23:20', '2021-12-23 00:25:34');

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `id` int(10) UNSIGNED NOT NULL,
  `booking_id` int(10) UNSIGNED NOT NULL,
  `bank` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sender_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ammount` decimal(10,2) DEFAULT NULL,
  `receipt` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `transactions`
--

-- (data `transactions` dihapus untuk versi publik)

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `first_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` enum('Tuan','Nyonya','Nona') COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(25) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `verified` tinyint(1) NOT NULL DEFAULT 0,
  `verification_token` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `first_name`, `last_name`, `title`, `phone`, `email`, `password`, `verified`, `verification_token`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Member Old', 'Member', 'Old', 'Tuan', '080000000000', 'member@gmail.com', '$2y$10$O7X9wNmSpCLBBPhxXd4TGOkxzu/lXhzKB9/M0jW2jL04nbf4uUw4m', 1, NULL, NULL, '2021-12-12 00:54:15', '2021-12-12 00:54:15'),
(2, 'Admin Old', 'Admin', 'Old', 'Tuan', '080000000000', 'admin@gmail.com', '$2y$10$sfk4JaxsDeiYYf7EgWxd9.J8/2aZqJoBaMvx7UbrKJeOWQX1AxaP.', 1, NULL, NULL, '2021-12-12 00:54:15', '2021-12-12 00:54:15');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `airports`
--
ALTER TABLE `airports`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `bank_accounts`
--
ALTER TABLE `bank_accounts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `bookings_user_id_foreign` (`user_id`);

--
-- Indexes for table `detail_bookings`
--
ALTER TABLE `detail_bookings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `detail_bookings_booking_id_foreign` (`booking_id`);

--
-- Indexes for table `groups`
--
ALTER TABLE `groups`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `group_user`
--
ALTER TABLE `group_user`
  ADD PRIMARY KEY (`id`),
  ADD KEY `group_user_group_id_foreign` (`group_id`),
  ADD KEY `group_user_user_id_foreign` (`user_id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `passengers`
--
ALTER TABLE `passengers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `passengers_detail_booking_id_foreign` (`detail_booking_id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `planes`
--
ALTER TABLE `planes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `plane_fares`
--
ALTER TABLE `plane_fares`
  ADD PRIMARY KEY (`id`),
  ADD KEY `plane_fares_plane_id_foreign` (`plane_id`);

--
-- Indexes for table `plane_schedules`
--
ALTER TABLE `plane_schedules`
  ADD PRIMARY KEY (`id`),
  ADD KEY `plane_schedules_plane_id_foreign` (`plane_id`),
  ADD KEY `plane_schedules_airport_id_foreign` (`airport_id`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `transactions_booking_id_foreign` (`booking_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `airports`
--
ALTER TABLE `airports`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `bank_accounts`
--
ALTER TABLE `bank_accounts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `bookings`
--
ALTER TABLE `bookings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `detail_bookings`
--
ALTER TABLE `detail_bookings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `groups`
--
ALTER TABLE `groups`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `group_user`
--
ALTER TABLE `group_user`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `passengers`
--
ALTER TABLE `passengers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `planes`
--
ALTER TABLE `planes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `plane_fares`
--
ALTER TABLE `plane_fares`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `plane_schedules`
--
ALTER TABLE `plane_schedules`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bookings`
--
ALTER TABLE `bookings`
  ADD CONSTRAINT `bookings_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `detail_bookings`
--
ALTER TABLE `detail_bookings`
  ADD CONSTRAINT `detail_bookings_booking_id_foreign` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `group_user`
--
ALTER TABLE `group_user`
  ADD CONSTRAINT `group_user_group_id_foreign` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `group_user_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `passengers`
--
ALTER TABLE `passengers`
  ADD CONSTRAINT `passengers_detail_booking_id_foreign` FOREIGN KEY (`detail_booking_id`) REFERENCES `detail_bookings` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `plane_fares`
--
ALTER TABLE `plane_fares`
  ADD CONSTRAINT `plane_fares_plane_id_foreign` FOREIGN KEY (`plane_id`) REFERENCES `planes` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `plane_schedules`
--
ALTER TABLE `plane_schedules`
  ADD CONSTRAINT `plane_schedules_airport_id_foreign` FOREIGN KEY (`airport_id`) REFERENCES `airports` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `plane_schedules_plane_id_foreign` FOREIGN KEY (`plane_id`) REFERENCES `planes` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `transactions`
--
ALTER TABLE `transactions`
  ADD CONSTRAINT `transactions_booking_id_foreign` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
