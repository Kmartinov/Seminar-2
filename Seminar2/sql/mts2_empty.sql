-- phpMyAdmin SQL Dump
-- version 3.4.11.1deb2
-- http://www.phpmyadmin.net
--
-- Računalo: localhost
-- Vrijeme generiranja: Lip 13, 2014 u 02:42 PM
-- Verzija poslužitelja: 5.5.35
-- PHP verzija: 5.5.10-1~dotdeb.1

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Baza podataka: `mts2`
--

-- --------------------------------------------------------

--
-- Tablična struktura za tablicu `s2_categories`
--

CREATE TABLE IF NOT EXISTS `s2_categories` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `category_title` varchar(255) NOT NULL,
  `category_desc` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`category_id`),
  UNIQUE KEY `category_id_UNIQUE` (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Tablična struktura za tablicu `s2_comments`
--

CREATE TABLE IF NOT EXISTS `s2_comments` (
  `comment_id` int(11) NOT NULL AUTO_INCREMENT,
  `comment_lid` int(11) NOT NULL,
  `comment_author` int(11) NOT NULL,
  `comment_text` text NOT NULL,
  `comment_date` datetime DEFAULT NULL,
  PRIMARY KEY (`comment_id`),
  UNIQUE KEY `comment_id_UNIQUE` (`comment_id`),
  KEY `comment_location_idx` (`comment_lid`),
  KEY `comment_authorid_idx` (`comment_author`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Tablična struktura za tablicu `s2_locations`
--

CREATE TABLE IF NOT EXISTS `s2_locations` (
  `location_id` int(11) NOT NULL AUTO_INCREMENT,
  `location_name` varchar(255) NOT NULL,
  `location_desc` varchar(255) DEFAULT NULL,
  `location_text` text NOT NULL,
  `location_cat` int(11) NOT NULL,
  `location_author` int(11) NOT NULL,
  `location_rating` float(3,2) DEFAULT '0.00',
  `location_image` varchar(255) DEFAULT NULL,
  `location_lat` decimal(10,8) DEFAULT NULL,
  `location_lng` decimal(11,8) DEFAULT NULL,
  PRIMARY KEY (`location_id`),
  UNIQUE KEY `page_id_UNIQUE` (`location_id`),
  KEY `location_owner_idx` (`location_author`),
  KEY `location_category_idx` (`location_cat`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Tablična struktura za tablicu `s2_ratings`
--

CREATE TABLE IF NOT EXISTS `s2_ratings` (
  `rating_id` int(11) NOT NULL AUTO_INCREMENT,
  `rating_lid` int(11) NOT NULL,
  `rating_uid` int(11) NOT NULL,
  `rating_vote` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`rating_id`),
  UNIQUE KEY `rating_id_UNIQUE` (`rating_id`),
  KEY `rating_location_idx` (`rating_lid`),
  KEY `rating_ratedby_idx` (`rating_uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Tablična struktura za tablicu `s2_roles`
--

CREATE TABLE IF NOT EXISTS `s2_roles` (
  `role_id` int(11) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(45) NOT NULL,
  `role_desc` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`role_id`),
  UNIQUE KEY `role_id_UNIQUE` (`role_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Izbacivanje podataka za tablicu `s2_roles`
--

INSERT INTO `s2_roles` (`role_id`, `role_name`, `role_desc`) VALUES
(1, 'ADMIN', 'Administrator stranice'),
(2, 'USER', 'Korisnik stranice');

-- --------------------------------------------------------

--
-- Tablična struktura za tablicu `s2_users`
--

CREATE TABLE IF NOT EXISTS `s2_users` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(45) NOT NULL,
  `user_password` varchar(255) NOT NULL,
  `user_email` varchar(255) NOT NULL,
  `user_role` int(11) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `user_id_UNIQUE` (`user_id`),
  UNIQUE KEY `user_name_UNIQUE` (`user_name`),
  UNIQUE KEY `user_email_UNIQUE` (`user_email`),
  KEY `user_auth_idx` (`user_role`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Izbacivanje podataka za tablicu `s2_users`
--

INSERT INTO `s2_users` (`user_id`, `user_name`, `user_password`, `user_email`, `user_role`) VALUES
(1, 'admin', '5f4dcc3b5aa765d61d8327deb882cf99', 'atomasevi@tvz.hr', 1);

--
-- Ograničenja za izbačene tablice
--

--
-- Ograničenja za tablicu `s2_comments`
--
ALTER TABLE `s2_comments`
  ADD CONSTRAINT `comment_authorid` FOREIGN KEY (`comment_author`) REFERENCES `s2_users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `comment_location` FOREIGN KEY (`comment_lid`) REFERENCES `s2_locations` (`location_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Ograničenja za tablicu `s2_locations`
--
ALTER TABLE `s2_locations`
  ADD CONSTRAINT `location_category` FOREIGN KEY (`location_cat`) REFERENCES `s2_categories` (`category_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `location_owner` FOREIGN KEY (`location_author`) REFERENCES `s2_users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Ograničenja za tablicu `s2_ratings`
--
ALTER TABLE `s2_ratings`
  ADD CONSTRAINT `rating_location` FOREIGN KEY (`rating_lid`) REFERENCES `s2_locations` (`location_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `rating_ratedby` FOREIGN KEY (`rating_uid`) REFERENCES `s2_users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Ograničenja za tablicu `s2_users`
--
ALTER TABLE `s2_users`
  ADD CONSTRAINT `user_auth` FOREIGN KEY (`user_role`) REFERENCES `s2_roles` (`role_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
