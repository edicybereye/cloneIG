-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: May 21, 2020 at 09:51 AM
-- Server version: 10.4.6-MariaDB
-- PHP Version: 7.3.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `clone_instagram`
--

-- --------------------------------------------------------

--
-- Table structure for table `commentPost`
--

CREATE TABLE `commentPost` (
  `id` int(11) NOT NULL,
  `idPost` int(11) DEFAULT NULL,
  `createdDate` datetime DEFAULT NULL,
  `comments` text DEFAULT NULL,
  `idUsers` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `followers`
--

CREATE TABLE `followers` (
  `id` int(11) NOT NULL,
  `idUsers` int(11) DEFAULT NULL,
  `idFollowers` int(11) DEFAULT NULL,
  `createdDate` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `lovePost`
--

CREATE TABLE `lovePost` (
  `id` int(11) NOT NULL,
  `idPost` int(11) DEFAULT NULL,
  `createdDate` datetime DEFAULT NULL,
  `idUsers` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `post`
--

CREATE TABLE `post` (
  `id` int(11) NOT NULL,
  `createdDate` datetime DEFAULT NULL,
  `idUsers` int(11) DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `love` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `post`
--

INSERT INTO `post` (`id`, `createdDate`, `idUsers`, `description`, `love`) VALUES
(1, '2020-05-21 06:17:11', 2, 'Test', 0),
(2, '2020-05-21 06:18:00', 2, 'Satu Gambar', 0),
(3, '2020-05-21 07:10:09', 2, 'Gambar Tiga Buah', 0),
(4, '2020-05-21 07:42:33', 2, '', 0);

-- --------------------------------------------------------

--
-- Table structure for table `PostDetail`
--

CREATE TABLE `PostDetail` (
  `id` int(11) NOT NULL,
  `idPost` int(11) DEFAULT NULL,
  `detail` longtext DEFAULT NULL,
  `tipe` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `PostDetail`
--

INSERT INTO `PostDetail` (`id`, `idPost`, `detail`, `tipe`) VALUES
(1, 1, '21052020080215image_picker2318608802153863517.jpg', 1),
(2, 1, '21052020080509image_picker7607979385531378639.jpg', 1),
(3, 2, '21052020081752image_picker5839987850416873182.jpg', 1),
(4, 3, '21052020090955image_picker211084917752057629.jpg', 1),
(5, 3, '21052020090958image_picker2340010109730330250.jpg', 1),
(6, 3, '21052020091001image_picker3552326229184933222.jpg', 1),
(7, 4, '21052020094220image_picker2564922997157961911.jpg', 1);

-- --------------------------------------------------------

--
-- Table structure for table `story`
--

CREATE TABLE `story` (
  `id` int(11) NOT NULL,
  `idUsers` int(11) DEFAULT NULL,
  `story` longtext DEFAULT NULL,
  `createdDate` datetime DEFAULT NULL,
  `tipe` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `tmpPost`
--

CREATE TABLE `tmpPost` (
  `id` int(11) NOT NULL,
  `idUsers` int(11) DEFAULT NULL,
  `file` text DEFAULT NULL,
  `createdDate` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `email` text DEFAULT NULL,
  `username` text DEFAULT NULL,
  `name` text DEFAULT NULL,
  `createdDate` datetime DEFAULT NULL,
  `password` text DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `level` int(11) DEFAULT NULL,
  `photo` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `email`, `username`, `name`, `createdDate`, `password`, `status`, `level`, `photo`) VALUES
(2, 'edi.cybereye@gmail.com', 'edi.cybereye', 'Edi Kurniawan', '2020-05-16 07:21:43', 'ae2b1fca515949e5d54fb22b8ed95575', 1, 1, 'default.png'),
(3, 'cybereye@gmail.com', 'cybereyecommunity', 'Cybereye', '2020-05-16 07:33:10', '6b47eb626ba6a929686e23134c7c21ab', 1, 1, 'default.png'),
(5, 'edi@gmail.com', 'edi', 'Edi', '2020-05-16 07:57:50', '6b47eb626ba6a929686e23134c7c21ab', 1, 1, 'default.png'),
(6, 'e@gmail.com', 'edi.cybereyecommunity', 'Edi', '2020-05-21 07:39:18', 'ae2b1fca515949e5d54fb22b8ed95575', 1, 1, 'default.png');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `commentPost`
--
ALTER TABLE `commentPost`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idPost` (`idPost`),
  ADD KEY `idUsers` (`idUsers`);

--
-- Indexes for table `followers`
--
ALTER TABLE `followers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idUsers` (`idUsers`),
  ADD KEY `idFollowers` (`idFollowers`);

--
-- Indexes for table `lovePost`
--
ALTER TABLE `lovePost`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idPost` (`idPost`),
  ADD KEY `idUsers` (`idUsers`);

--
-- Indexes for table `post`
--
ALTER TABLE `post`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idUsers` (`idUsers`);

--
-- Indexes for table `PostDetail`
--
ALTER TABLE `PostDetail`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idPost` (`idPost`);

--
-- Indexes for table `story`
--
ALTER TABLE `story`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idUsers` (`idUsers`);

--
-- Indexes for table `tmpPost`
--
ALTER TABLE `tmpPost`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idUsers` (`idUsers`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `commentPost`
--
ALTER TABLE `commentPost`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `followers`
--
ALTER TABLE `followers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `lovePost`
--
ALTER TABLE `lovePost`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `post`
--
ALTER TABLE `post`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `PostDetail`
--
ALTER TABLE `PostDetail`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `story`
--
ALTER TABLE `story`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tmpPost`
--
ALTER TABLE `tmpPost`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `commentPost`
--
ALTER TABLE `commentPost`
  ADD CONSTRAINT `commentPost_ibfk_1` FOREIGN KEY (`idPost`) REFERENCES `post` (`id`),
  ADD CONSTRAINT `commentPost_ibfk_2` FOREIGN KEY (`idUsers`) REFERENCES `users` (`id`);

--
-- Constraints for table `followers`
--
ALTER TABLE `followers`
  ADD CONSTRAINT `followers_ibfk_1` FOREIGN KEY (`idUsers`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `followers_ibfk_2` FOREIGN KEY (`idFollowers`) REFERENCES `users` (`id`);

--
-- Constraints for table `lovePost`
--
ALTER TABLE `lovePost`
  ADD CONSTRAINT `lovePost_ibfk_1` FOREIGN KEY (`idPost`) REFERENCES `post` (`id`),
  ADD CONSTRAINT `lovePost_ibfk_2` FOREIGN KEY (`idUsers`) REFERENCES `users` (`id`);

--
-- Constraints for table `post`
--
ALTER TABLE `post`
  ADD CONSTRAINT `post_ibfk_1` FOREIGN KEY (`idUsers`) REFERENCES `users` (`id`);

--
-- Constraints for table `PostDetail`
--
ALTER TABLE `PostDetail`
  ADD CONSTRAINT `PostDetail_ibfk_1` FOREIGN KEY (`idPost`) REFERENCES `post` (`id`);

--
-- Constraints for table `story`
--
ALTER TABLE `story`
  ADD CONSTRAINT `story_ibfk_1` FOREIGN KEY (`idUsers`) REFERENCES `users` (`id`);

--
-- Constraints for table `tmpPost`
--
ALTER TABLE `tmpPost`
  ADD CONSTRAINT `tmpPost_ibfk_1` FOREIGN KEY (`idUsers`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
