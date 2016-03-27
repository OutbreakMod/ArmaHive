-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Mar 27, 2016 at 08:20 AM
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
-- Table structure for table `object_data`
--

CREATE TABLE IF NOT EXISTS `object_data` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=157541 ;

--
-- Dumping data for table `object_data`
--

INSERT INTO `object_data` (`id`, `class`, `position`, `dir`, `server_name`, `created`, `last_updated`, `inventory`, `hitpoints`, `damage`, `fuel`) VALUES
(149098, 'B_G_Van_01_fuel_F', '[[4704.69,10204.9,1.56058],[0.838671,-0.544639,0],[0,0,1]]', '123', 'DEV001', '2016-03-26 18:33:20', '2016-03-26 18:33:20', '', '[["wheel_1_1_steering",0.892196],["wheel_1_2_steering",0.597936],["wheel_2_1_steering",0.715314],["wheel_2_2_steering",0.274693],["fueltank",0.137539],["palivo",0.43694],["engine",0.578222],["glass1",0.540138],["glass2",0.516945],["glass3",0.621186],["glass4",0.613622]]', 0.16689, 0.68549),
(149112, 'B_G_Van_01_fuel_F', '[[4704.69,10204.9,1.56058],[0.838671,-0.544639,0],[0,0,1]]', '123', 'DEV001', '2016-03-26 22:15:05', '2016-03-26 22:15:05', '', '[["wheel_1_1_steering",0.130993],["wheel_1_2_steering",0.577294],["wheel_2_1_steering",0.701638],["wheel_2_2_steering",0.187354],["fueltank",0.375227],["palivo",0.451785],["engine",0.295017],["glass1",0.211286],["glass2",0.646227],["glass3",0.699879],["glass4",0.159692]]', 0.49800, 0.16033),
(157540, 'B_G_Quadbike_01_F', '[[2056.68,10971.6,-0.0286865],[0.592957,-0.803291,0.0559082],[-0.06731,0.019742,0.997537]]', '144', 'DEV001', '2016-03-26 18:33:50', '2016-03-26 19:26:00', '[[[],[]],[[],[]],[[],[]],[["FirstAidKit"],[8]]]', '[["motor",0.665354],["palivo",0.665354],["wheel_1_1_steering",0.665354],["wheel_1_2_steering",0.665354],["wheel_2_1_steering",0.665354],["wheel_2_2_steering",0.665354]]', 0.66535, 0.87570);

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=34 ;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `uuid`, `inventory`, `position`, `medical`) VALUES
(33, 'AmazingAussie', '76561198127078878', '["","G_Aviator","U_C_Poloshirt_stripped",["axe"],"",[],"B_Kitbag_mcamo",["7Rnd_45ACP_M","CUP_30Rnd_556x45_Stanag","CUP_30Rnd_556x45_Stanag","CUP_30Rnd_762x39_AK47_M","CUP_30Rnd_762x39_AK47_M","CUP_30Rnd_762x39_AK47_M","CUP_10Rnd_762x54_SVD_M"],"CUP_srifle_SVD_pso",["","","CUP_optic_PSO_1",""],["CUP_10Rnd_762x54_SVD_M"],"",["","","",""],[],"CUP_hgun_M9",["","","",""],["CUP_15Rnd_9x19_M9"],["ItemMap"]]', '[13190.6,14928.2,0.000961304]', '[0,6000,6000]');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
