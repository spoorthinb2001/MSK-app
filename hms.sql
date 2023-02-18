-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 22, 2021 at 11:52 AM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.2.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hms`
--

-- --------------------------------------------------------

--
-- Table structure for table `financers`
--

CREATE TABLE `financers` (
  `did` int(11) NOT NULL,
  `email` varchar(50) NOT NULL,
  `financername` varchar(50) NOT NULL,
  `sect` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `financers`
--

INSERT INTO `financers` (`did`, `email`, `financername`, `sect`) VALUES
(1, 'anu@gmail.com', 'anu sharma', 'Health'),
(2, 'amrutha@gmail.com', 'amrutha bhatta', 'Food'),
(3, 'aadithyaa@gmail.com', 'aadithyaa', 'Pharma'),
(4, 'aneesha@gmail', 'aneesh', 'IT'),
(5, 'aneekah@gmail.com', 'aneekha', 'Textile');

-- --------------------------------------------------------

--
-- Table structure for table `mahilas`
--

CREATE TABLE `mahilas` (
  `pid` int(11) NOT NULL,
  `email` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `scheme` varchar(50) NOT NULL,
  `amount` varchar(50) NOT NULL,
  `business` varchar(50) NOT NULL,
  `time` time NOT NULL,
  `date` date NOT NULL,
  `sect` varchar(50) NOT NULL,
  `number` varchar(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `mahilas`
--

INSERT INTO `mahilas` (`pid`, `email`, `name`, `scheme`, `amount`, `business`, `time`, `date`, `sect`, `number`) VALUES
(2, 'anish@gmail.com', 'anish gupta', 'SLCW', '50,000-1,00,000', 'making juices', '21:20:00', '2020-02-02', 'ortho11predict', '9874561110'),
(5, 'patient@gmail.com', 'patien', 'Male', 'morning', 'fevr', '18:06:00', '2020-11-18', 'Cardiologists', '9874563210'),
(7, 'patient@gmail.com', 'anees', 'Male', 'evening', 'cold', '22:18:00', '2020-11-05', 'Dermatologists', '9874563210'),
(8, 'patient@gmail.com', 'anees', 'Male', 'evening', 'cold', '22:18:00', '2020-11-05', 'Dermatologists', '9874563210'),
(9, 'aneesurrehman423@gmail.com', 'anees', 'Male', 'morning', 'cold', '17:27:00', '2020-11-26', 'Anesthesiologists', '9874563210'),
(10, 'anees@gmail.com', 'anees', 'Male', 'evening', 'fever', '16:25:00', '2020-12-09', 'Cardiologists', '9874589654'),
(15, 'khushi@gmail.com', 'khushi', 'Female', 'morning', 'corona', '20:42:00', '2021-01-23', 'Anesthesiologists', '9874563210'),
(16, 'khushi@gmail.com', 'khushi', 'Female', 'evening', 'fever', '15:46:00', '2021-01-31', 'Endocrinologists', '9874587496'),
(17, 'aneeqah@gmail.com', 'aneeqah', 'Female', 'evening', 'fever', '15:48:00', '2021-01-23', 'Endocrinologists', '9874563210');

--
-- Triggers `mahilas`
--
DELIMITER $$
CREATE TRIGGER `MahilaDelete` BEFORE DELETE ON `mahilas` FOR EACH ROW INSERT INTO trigr VALUES(null,OLD.pid,OLD.email,OLD.name,'MAHILA DELETED',NOW())
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `MahilaUpdate` AFTER UPDATE ON `mahilas` FOR EACH ROW INSERT INTO trigr VALUES(null,NEW.pid,NEW.email,NEW.name,'MAHILA UPDATED',NOW())
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `mahilainsertion` AFTER INSERT ON `mahilas` FOR EACH ROW INSERT INTO trigr VALUES(null,NEW.pid,NEW.email,NEW.name,'MAHILA INSERTED',NOW())
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `test`
--

CREATE TABLE `test` (
  `id` int(11) NOT NULL,
  `name` varchar(20) NOT NULL,
  `email` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `test`
--

INSERT INTO `test` (`id`, `name`, `email`) VALUES
(1, 'ANEES', 'ARK@GMAIL.COM'),
(2, 'test', 'test@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `trigr`
--

CREATE TABLE `trigr` (
  `tid` int(11) NOT NULL,
  `pid` int(11) NOT NULL,
  `email` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `action` varchar(50) NOT NULL,
  `timestamp` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `trigr`
--

INSERT INTO `trigr` (`tid`, `pid`, `email`, `name`, `action`, `timestamp`) VALUES
(1, 12, 'anees@gmail.com', 'ANEES', 'MAHILA INSERTED', '2020-12-02 16:35:10'),
(2, 11, 'anees@gmail.com', 'anees', 'MAHILA INSERTED', '2020-12-02 16:37:34'),
(3, 10, 'anees@gmail.com', 'anees', 'MAHILA UPDATED', '2020-12-02 16:38:27'),
(4, 11, 'anees@gmail.com', 'anees', 'MAHILA UPDATED', '2020-12-02 16:38:33'),
(5, 12, 'anees@gmail.com', 'ANEES', 'MAHILA Deleted', '2020-12-02 16:40:40'),
(6, 11, 'anees@gmail.com', 'anees', 'MAHILA DELETED', '2020-12-02 16:41:10'),
(7, 13, 'testing@gmail.com', 'testing', 'MAHILA INSERTED', '2020-12-02 16:50:21'),
(8, 13, 'testing@gmail.com', 'testing', 'MAHILA UPDATED', '2020-12-02 16:50:32'),
(9, 13, 'testing@gmail.com', 'testing', 'MAHILA DELETED', '2020-12-02 16:50:57'),
(10, 14, 'aneeqah@gmail.com', 'aneeqah', 'MAHILA INSERTED', '2021-01-22 15:18:09'),
(11, 14, 'aneeqah@gmail.com', 'aneeqah', 'MAHILA UPDATED', '2021-01-22 15:18:29'),
(12, 14, 'aneeqah@gmail.com', 'aneeqah', 'MAHILA DELETED', '2021-01-22 15:41:48'),
(13, 15, 'khushi@gmail.com', 'khushi', 'MAHILA INSERTED', '2021-01-22 15:43:02'),
(14, 15, 'khushi@gmail.com', 'khushi', 'MAHILA UPDATED', '2021-01-22 15:43:11'),
(15, 16, 'khushi@gmail.com', 'khushi', 'MAHILA INSERTED', '2021-01-22 15:43:37'),
(16, 16, 'khushi@gmail.com', 'khushi', 'MAHILA UPDATED', '2021-01-22 15:43:49'),
(17, 17, 'aneeqah@gmail.com', 'aneeqah', 'MAHILA INSERTED', '2021-01-22 15:44:41'),
(18, 17, 'aneeqah@gmail.com', 'aneeqah', 'MAHILA UPDATED', '2021-01-22 15:44:52'),
(19, 17, 'aneeqah@gmail.com', 'aneeqah', 'MAHILA UPDATED', '2021-01-22 15:44:59');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `usertype` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `username`, `usertype`, `email`, `password`) VALUES
(13, 'anees', 'Financer', 'anees@gmail.com', 'pbkdf2:sha256:150000$xAKZCiJG$4c7a7e704708f86659d730565ff92e8327b01be5c49a6b1ef8afdf1c531fa5c3'),
(14, 'aneeqah', 'Mahila', 'aneeqah@gmail.com', 'pbkdf2:sha256:150000$Yf51ilDC$028cff81a536ed9d477f9e45efcd9e53a9717d0ab5171d75334c397716d581b8'),
(15, 'khushi', 'Mahila', 'khushi@gmail.com', 'pbkdf2:sha256:150000$BeSHeRKV$a8b27379ce9b2499d4caef21d9d387260b3e4ba9f7311168b6e180a00db91f22');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `financers`
--
ALTER TABLE `financers`
  ADD PRIMARY KEY (`did`);

--
-- Indexes for table `mahilas`
--
ALTER TABLE `mahilas`
  ADD PRIMARY KEY (`pid`);

--
-- Indexes for table `test`
--
ALTER TABLE `test`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `trigr`
--
ALTER TABLE `trigr`
  ADD PRIMARY KEY (`tid`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `financers`
--
ALTER TABLE `financers`
  MODIFY `did` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `mahilas`
--
ALTER TABLE `mahilas`
  MODIFY `pid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `test`
--
ALTER TABLE `test`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `trigr`
--
ALTER TABLE `trigr`
  MODIFY `tid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
