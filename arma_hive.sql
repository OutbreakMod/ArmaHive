-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Mar 20, 2016 at 01:56 AM
-- Server version: 5.6.17
-- PHP Version: 5.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `arma_hive`
--

-- --------------------------------------------------------

--
-- Table structure for table `loot_building_tags`
--

CREATE TABLE IF NOT EXISTS `loot_building_tags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `class` varchar(50) NOT NULL,
  `loot_respawn` int(11) NOT NULL DEFAULT '300',
  `zombie_type` varchar(50) NOT NULL,
  `loot_tag` tinytext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

--
-- Dumping data for table `loot_building_tags`
--

INSERT INTO `loot_building_tags` (`id`, `class`, `loot_respawn`, `zombie_type`, `loot_tag`) VALUES
(1, 'Land_Farm_Cowshed_a', 300, 'wild', '["GeneralTools", "CivillianFoodStorage", "CivillianMagazines", "Farm"]'),
(2, 'Land_Farm_Cowshed_b', 300, 'wild', '["GeneralTools", "CivillianFoodStorage", "Farm", "CivillianMagazines"]'),
(3, 'Land_Farm_Cowshed_c', 300, 'wild', '["GeneralTools", "CivillianFoodStorage", "Farm", "CivillianMagazines"]'),
(4, 'Land_stodola_old_open', 300, 'wild', '["GeneralTools", "CivillianFoodStorage", "Farm", "CivillianMagazines"]'),
(5, 'Land_stodola_open', 300, 'wild', '["GeneralTools", "CivillianFoodStorage", "Farm", "CivillianMagazines"]'),
(6, 'Land_Misc_deerstand', 600, 'wild', '["GeneralTools", "CivillianFoodStorage", "MiscMedical", "Hunting", "Magazines", "CivillianMagazines"]');

-- --------------------------------------------------------

--
-- Table structure for table `object_data`
--

CREATE TABLE IF NOT EXISTS `object_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `class` varchar(50) NOT NULL,
  `position` varchar(500) NOT NULL,
  `dir` varchar(11) NOT NULL,
  `server_name` varchar(30) NOT NULL,
  `created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_updated` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `inventory` varchar(5000) NOT NULL DEFAULT '[[[],[]],[[],[]],[[],[]],[[],[]]]',
  `hitpoints` varchar(500) NOT NULL DEFAULT '[]',
  `damage` double(13,5) NOT NULL DEFAULT '0.00000',
  `fuel` double(13,5) NOT NULL DEFAULT '1.00000',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

--
-- Dumping data for table `object_data`
--

INSERT INTO `object_data` (`id`, `class`, `position`, `dir`, `server_name`, `created`, `last_updated`, `inventory`, `hitpoints`, `damage`, `fuel`) VALUES
(6, 'B_G_Van_01_fuel_F', '[[4704.69,10204.9,1.56058],[1.38778e-017,0.999988,-0.00484739],[-2.57932e-008,0.00484739,0.999988]]', '123', 'DEV001', '2015-10-30 07:05:02', '2015-10-30 07:05:02', '', '[["wheel_1_1_steering",0.523044],["wheel_1_2_steering",0.513051],["wheel_2_1_steering",0.2986],["wheel_2_2_steering",0.406776],["fueltank",0.409611],["palivo",0.47429],["engine",0.113016],["glass1",0.718815],["glass2",0.486677],["glass3",0.393449],["glass4",0.582348]]', 0.27268, 0.09920),
(7, 'OutbreakTent', '[[4702.4,10206.5,0],[-0.0697564,-0.997564,0],[0,0,1]]', '184', 'DEV001', '2015-11-24 21:25:22', '2015-11-24 21:25:22', '[]', '', 0.00000, 1.00000);

-- --------------------------------------------------------

--
-- Table structure for table `object_spawns`
--

CREATE TABLE IF NOT EXISTS `object_spawns` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `class` varchar(250) NOT NULL,
  `position` text NOT NULL,
  `dir` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `object_spawns`
--

INSERT INTO `object_spawns` (`id`, `class`, `position`, `dir`) VALUES
(2, 'B_G_Van_01_fuel_F', '[4704.69,10204.9,-0.297882]', 123);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `uuid` varchar(50) NOT NULL,
  `inventory` longtext NOT NULL,
  `position` varchar(50) NOT NULL,
  `medical` varchar(100) NOT NULL DEFAULT '[0,6000,6000]',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `uuid`, `inventory`, `position`, `medical`) VALUES
(6, 'Alex', '76561198127078878', '[91,34,34,44,34,34,44,34,85,95,66,95,67,111,109,98,97,116,85,110,105,102,111,114,109,95,109,99,97,109,34,44,91,34,49,51,82,110,100,95,109,97,115,95,57,120,50,49,95,77,97,103,34,44,34,97,120,101,34,44,34,56,82,110,100,95,109,97,115,95,57,120,49,56,95,77,97,103,34,44,34,51,48,82,110,100,95,109,97,115,95,53,53,54,120,52,53,95,84,95,83,116,97,110,97,103,34,93,44,34,34,44,91,93,44,34,66,95,79,117,116,100,111,111,114,80,97,99,107,95,116,97,110,34,44,91,34,111,112,116,105,99,95,109,97,115,95,97,99,111,103,95,101,111,34,44,34,109,111,114,112,104,105,110,101,34,44,34,109,111,114,112,104,105,110,101,34,44,34,53,82,110,100,95,49,50,55,120,49,48,56,95,77,97,103,34,44,34,53,82,110,100,95,49,50,55,120,49,48,56,95,77,97,103,34,44,34,49,54,82,110,100,95,57,120,50,49,95,77,97,103,34,44,34,84,114,105,120,105,101,95,67,90,53,53,48,95,77,97,103,34,44,34,104,97,109,109,101,114,34,44,34,116,111,111,108,98,111,120,34,93,44,34,97,114,105,102,108,101,95,109,97,115,95,109,49,54,34,44,91,34,34,44,34,34,44,34,34,44,34,34,93,44,91,34,51,48,82,110,100,95,53,53,54,120,52,53,95,83,116,97,110,97,103,95,84,114,97,99,101,114,95,71,114,101,101,110,34,93,44,34,34,44,91,34,34,44,34,34,44,34,34,44,34,34,93,44,91,93,44,34,104,103,117,110,95,109,97,115,95,103,114,97,99,104,95,70,34,44,91,34,34,44,34,34,44,34,34,44,34,34,93,44,91,34,49,54,82,110,100,95,57,120,50,49,95,77,97,103,34,93,44,91,34,73,116,101,109,77,97,112,34,44,34,66,105,110,111,99,117,108,97,114,34,93,93]', '[4697.12,10218.8,0.00143433]', '[0,4037.11,6000]');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
