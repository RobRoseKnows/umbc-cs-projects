-- phpMyAdmin SQL Dump
-- version 4.0.10.17
-- https://www.phpmyadmin.net
--
-- Host: studentdb-maria.gl.umbc.edu
-- Generation Time: Nov 09, 2016 at 01:03 AM
-- Server version: 10.1.18-MariaDB
-- PHP Version: 5.4.44

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `eversam1`
--

-- --------------------------------------------------------

--
-- Table structure for table `advisors`
--

CREATE TABLE IF NOT EXISTS `advisors` (
  `Username` text NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fullName` text NOT NULL,
  `Office` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=39 ;

--
-- Dumping data for table `advisors`
--

INSERT INTO `advisors` (`Username`, `id`, `fullName`, `Office`) VALUES
('sLupoli1', 21, 'Shawn Lupoli', 'ITE 123'),
('Yolo', 22, 'yoloween', 'chem 432'),
('kGibson1', 23, 'Katy Gibson', 'ITE 789'),
('notoriousPIG', 24, 'Yo Mama', '30 Rock'),
('sBranham1', 25, 'Stacy Branham', 'PHYS 101'),
('Chupacabra', 26, 'Chupa Cabra', 'Mexico'),
('IWasLIkeBabyBabyBabyOh', 27, 'Justin Beiber', 'Canada'),
('ravensRule', 28, 'john Harbaugh', 'M&T Bank'),
('gwash123', 29, 'George Washington', 'The White House'),
('hhogan1', 30, 'Hulk Hogan', 'the ring'),
('tjeff', 31, 'Thomas Jefferson', 'Virginia'),
('gbush123', 32, 'George Bush', 'The White House'),
('mbrand33', 38, 'Marlon Brando', 'sicily');

-- --------------------------------------------------------

--
-- Table structure for table `appointments`
--

CREATE TABLE IF NOT EXISTS `appointments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `Advisor` text NOT NULL,
  `NumStudents` tinyint(4) NOT NULL,
  `Date` varchar(10) NOT NULL,
  `Time` varchar(5) NOT NULL,
  `isGroup` tinyint(1) NOT NULL,
  `isFull` tinyint(1) NOT NULL,
  `Location` text NOT NULL,
  `AdvisorUsername` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=76 ;

--
-- Dumping data for table `appointments`
--

INSERT INTO `appointments` (`id`, `Advisor`, `NumStudents`, `Date`, `Time`, `isGroup`, `isFull`, `Location`, `AdvisorUsername`) VALUES
(33, 'Chupa Cabra', 0, '1982-03-10', '11:00', 1, 0, 'Sheep Farm', 'Chupacabra'),
(34, 'Chupa Cabra', 0, '2016-10-06', '08:00', 1, 0, 'j', 'Chupacabra'),
(35, 'Justin Beiber', 0, '3052-10-05', '08:00', 1, 0, 'Space', 'IWasLIkeBabyBabyBabyOh'),
(37, 'john Harbaugh', 10, '2016-11-09', '08:00', 1, 1, 'ITE 340', 'ravensRule'),
(40, 'john Harbaugh', 0, '2016-10-31', '08:00', 1, 0, 'ENGR 333', 'ravensRule'),
(41, 'john Harbaugh', 0, '2016-11-03', '08:00', 1, 0, 'Cleveland', 'ravensRule'),
(43, 'john Harbaugh', 0, '2016-11-23', '08:00', 0, 0, 'CHEM 333', 'ravensRule'),
(45, 'George Washington', 1, '2016-11-03', '08:00', 0, 1, 'The White House', 'gwash123'),
(47, 'Hulk Hogan', 1, '2016-11-01', '11:00', 1, 0, 'ITE 200', 'hhogan1'),
(48, 'Hulk Hogan', 0, '2016-11-14', '11:30', 0, 0, 'The Ring', 'hhogan1'),
(51, 'Thomas Jefferson', 0, '2016-11-02', '08:00', 0, 0, 'ITE 240', 'tjeff'),
(52, 'Thomas Jefferson', 0, '2016-11-03', '08:00', 1, 0, 'ENGR 123', 'tjeff'),
(53, 'George Bush', 0, '2016-11-02', '08:00', 0, 0, 'ITE 289', 'gbush123'),
(54, 'George Bush', 0, '2016-11-03', '09:00', 1, 0, 'ENGR 544', 'gbush123'),
(64, 'Yo Mama', 0, '2016-11-09', '08:00', 1, 0, 'my office', 'notoriousPIG'),
(65, 'Yo Mama', 0, '2016-11-10', '08:00', 1, 0, 'Stables', 'notoriousPIG'),
(74, 'Marlon Brando', 0, '2016-11-10', '10:00', 1, 0, 'my daughter''s wedding', 'mbrand33');

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE IF NOT EXISTS `students` (
  `Username` text NOT NULL,
  `email` text NOT NULL,
  `Major` text NOT NULL,
  `Appt` int(11) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `firstName` text NOT NULL,
  `lastName` text NOT NULL,
  `studentID` varchar(9) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=63 ;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`Username`, `email`, `Major`, `Appt`, `id`, `firstName`, `lastName`, `studentID`) VALUES
('hben1', 'hben1@umbc.edu', 'Biological Sciences BS', NULL, 29, 'Ben', 'Hazlett', 'tt444444'),
('eversam1', 'eversam1@umbc.edu', 'Biological Sciences BA', 50, 30, 'sam', 'everett', 'yyeee33'),
('jzito1', 'zeetoe@umbc.edu', 'Biology Education BA', NULL, 31, 'jesse', 'zito', 'jz33333'),
('Chewbacca', 'aaaaaa@umbc.udu', 'Chemistry BA', 31, 32, 'Chewie', 'AAAAAAA', 'AL13n'),
('coffeeCup1', 'coffeeCup1@umbc.edu', 'Biological Sciences BA', 37, 33, 'Miranda', 'Cosgrove', 'YU99900'),
('kBone1', 'Kbone@umbc.edu', 'Chemistry BS', 37, 35, 'Ken', 'Bone', 'kb33344'),
('KevinBacon', 'bringmethebacon@umbc.edu', 'Biological Sciences BS', 29, 36, 'Kevin', 'Bacon', 'kb111111'),
('BringMeSolo', 'therealhut@umbc.edu', 'Biological Sciences BA', 37, 37, 'jabba', 'the hut', 'jh33333'),
('abc123', 'thejzxon@umbc.edu', 'Biological Sciences BA', 37, 38, 'michael', 'jackson', 'jd3333'),
('trumpRules', 'goldtoilet@umbc.edu', 'Bioinformatics & Computational Biology BS', 37, 39, 'donald', 'trump', 'dt33333'),
('eversamOne', 'ude.cbmu.1masreve', 'Biological Sciences BA', 45, 40, 'mas', 'ttereve', 'tw222222'),
('tjeffers3', 'jeffsers@umbc.edu', 'Biological Sciences BA', 47, 41, 'thomas', 'jeffers', 'yy111111'),
('SJohan3', 'sjohan@umbc.edu', 'Biological Sciences BA', 49, 42, 'Scarlett', 'Johansen', 'yy334444'),
('tcruise5', 'stuff@place.com', 'Biological Sciences BA', 46, 43, 'Tom', 'Cruise', 'uu9999'),
('micJagger3', '19nervous@breakdown.com', 'Biological Sciences BA', 37, 44, 'Mic', 'Jagger', 'uu888888'),
('ladyGaGa', 'gagarumamaaa@umbc.edu', 'Bioinformatics & Computational Biology BS', 37, 45, 'lady', 'gaga', 'uu55555'),
('Ke$ha', 'thekesh@umbc.edu', 'Chemistry BA', 28, 46, 'kesha', '$$$$$', '66#$$$'),
('wWonka33', 'Willie@Wonka.com', 'Biological Sciences BA', NULL, 47, 'Wilie', 'Wonka', 'uu333333'),
('sconnery77', 'therealconnery@place.net', 'Biology Education BA', 36, 48, 'Sean', 'Connery', 'gh00000'),
('ASDF', 'ghjk@qwer.com', 'Biological Sciences BA', 46, 49, 'as', 'df', 'we33333'),
('CookieMonster77', 'cookies@cookies.net', 'Biological Sciences BA', 31, 50, 'cookie', 'monster', 'yo105'),
('newStudent', 'oldsutdne@umbc.edu', 'Biology Education BA', 36, 51, 'old', 'student', 'old8888'),
('jflacco4', 'asdf@umbc.edu', 'Biology Education BA', 44, 52, 'Joe', 'Flacco', 'yy77777'),
('abc123', 'abc123@umbc.edu', 'Biological Sciences BA', 37, 53, 'Michael', 'Jackson', 'jx333333'),
('angel123', 'angel123@umbc.edu', 'Bioinformatics & Computational Biology BS', 30, 54, 'Angel', 'Olsen', 'tt12345'),
('JAdams555', 'JAdams555@umbc.edu', 'Biochemistry & Molecular Biology BS', 37, 55, 'John', 'Adams', 'ye9999'),
('rsanchez1', 'rsanchez1@umbc.edu', 'Biological Sciences BS', NULL, 56, 'Rick', 'Sanchez', 'rs123123'),
('hsolo6', 'hsolo6@umbc.edu', 'Biochemistry & Molecular Biology BS', 37, 57, 'Han', 'Solo', 'tr987'),
('apacino22', 'apacino22@umbc.edu', 'Bioinformatics & Computational Biology BS', NULL, 62, 'Al', 'Pacino', 'asd2333');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
