-- phpMyAdmin SQL Dump
-- version 4.6.5.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jan 05, 2017 at 01:02 PM
-- Server version: 5.6.35
-- PHP Version: 5.6.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `outbreakmod`
--

-- --------------------------------------------------------

--
-- Table structure for table `object_data`
--

CREATE TABLE `object_data` (
  `id` bigint(20) NOT NULL,
  `class` varchar(50) NOT NULL,
  `position` varchar(500) NOT NULL,
  `dir` varchar(11) NOT NULL,
  `server_name` varchar(30) NOT NULL,
  `created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lifetime` int(11) NOT NULL DEFAULT '0',
  `last_updated` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `inventory` varchar(5000) NOT NULL DEFAULT '[[[],[]],[[],[]],[[],[]],[[],[]]]',
  `hitpoints` varchar(500) NOT NULL DEFAULT '[]',
  `damage` double(13,5) NOT NULL DEFAULT '0.00000',
  `fuel` double(13,5) NOT NULL DEFAULT '1.00000'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `object_lifetimes`
--

CREATE TABLE `object_lifetimes` (
  `id` int(11) NOT NULL,
  `class` varchar(150) NOT NULL,
  `lifetime` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `object_spawns`
--

CREATE TABLE `object_spawns` (
  `id` int(11) NOT NULL,
  `class` varchar(250) NOT NULL,
  `position` text NOT NULL,
  `dir` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `object_spawns`
--

INSERT INTO `object_spawns` (`id`, `class`, `position`, `dir`) VALUES
(2, 'B_G_Van_01_fuel_F', '[4704.69,10204.9,-0.297882]', 123);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `uuid` varchar(50) NOT NULL,
  `inventory` longtext NOT NULL,
  `position` varchar(50) NOT NULL,
  `medical` varchar(100) NOT NULL DEFAULT '[0,6000,6000]'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `object_data`
--
ALTER TABLE `object_data`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `object_spawns`
--
ALTER TABLE `object_spawns`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `object_data`
--
ALTER TABLE `object_data`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `object_spawns`
--
ALTER TABLE `object_spawns`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
