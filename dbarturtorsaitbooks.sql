-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 06, 2023 at 12:33 PM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dbarturtorsaitbooks`
--

-- --------------------------------------------------------

--
-- Table structure for table `authors`
--

CREATE TABLE `authors` (
  `author_id` int(11) NOT NULL,
  `firstname` varchar(100) NOT NULL,
  `lastname` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `authors`
--

INSERT INTO `authors` (`author_id`, `firstname`, `lastname`) VALUES
(1, 'Ben', 'Piper'),
(2, 'David', 'Clinton'),
(3, 'Joe', 'Reis'),
(4, 'Matt', 'Housley'),
(5, 'Bjarne', 'Stroustrup'),
(6, 'Nora', 'Sandler'),
(7, 'Rafal', ' Swidzinski'),
(8, 'Alex ', 'Xu'),
(9, 'Sahn ', 'Lam');

-- --------------------------------------------------------

--
-- Table structure for table `books`
--

CREATE TABLE `books` (
  `book_id` int(11) NOT NULL,
  `title` varchar(200) NOT NULL,
  `total_pages` int(20) DEFAULT NULL,
  `rating` decimal(4,2) DEFAULT NULL,
  `isbn` varchar(13) DEFAULT NULL,
  `publisher_date` date DEFAULT NULL,
  `publisher_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `books`
--

INSERT INTO `books` (`book_id`, `title`, `total_pages`, `rating`, `isbn`, `publisher_date`, `publisher_id`) VALUES
(39, 'AWS Certified Solutions Architect Study Guide with 900 Practice Test Questions: Associate (SAA-C03) Exam', 480, '4.00', '1119982626', '2022-09-16', 1),
(40, 'Ace the Data Science Interview: 201 Real Interview Questions Asked By FAANG, Tech Startups, & Wall Street', 254, '4.50', '11345526', '2022-05-13', 2),
(43, 'Mike Meyers\' CompTIA A+ Core 1 Certification Passport (Exam 220-1101) (The Mike Meyers\' Certification Passport)', 234, '4.20', '12323234', '2023-02-02', 2),
(44, '101 Labs - CompTIA A+: Hands-on Practical Labs for the CompTIA A+ Exams (220-1001 and 220-1002)', 334, '3.70', '156643234', '2023-01-25', 4),
(45, 'Cracking the Coding Interview: 189 Programming Questions and Solutions', 159, '4.30', '17643434', '0000-00-00', 4),
(46, 'How To Be An Agile Business Analyst', 149, '4.00', '17655534', '2022-03-23', 4),
(47, 'Agile Project Management for Beginners 2023: The Ultimate Guide to Start and Run your Project in the best way | Unlock the Power of Agile Project Management to Score a 95% Pass Rate', 559, '4.00', '17655534', '2022-03-23', 5),
(48, 'The Home Distilling Bible: The Definitive Guide to Setting up Your Own Home Distillery | How to Make Your Vodka, Brandy, Whiskey, Rum, Moonshine and More the Safe & Legal Way', 459, '3.70', '14555534', '2022-02-15', 5),
(49, 'The Definitive Guide to TikTok Advertising: How to Access 1 Billion People in 10 Minutes!', 259, '4.70', '146543534', '2022-01-15', 5),
(50, 'The Definitive Guide to TikTok Advertising: How to Access 1 Billion People in 10 Minutes!', 159, '4.20', '14665444', '2022-06-23', 6);

-- --------------------------------------------------------

--
-- Table structure for table `book_author`
--

CREATE TABLE `book_author` (
  `book_id` int(11) NOT NULL,
  `author_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `book_author`
--

INSERT INTO `book_author` (`book_id`, `author_id`) VALUES
(39, 1),
(39, 2),
(40, 1),
(40, 4),
(43, 3),
(44, 1),
(44, 7),
(45, 4),
(45, 8),
(46, 6),
(47, 8),
(47, 9),
(48, 4),
(48, 7),
(49, 1),
(49, 9),
(50, 4),
(50, 5);

-- --------------------------------------------------------

--
-- Table structure for table `book_genres`
--

CREATE TABLE `book_genres` (
  `book_id` int(11) NOT NULL,
  `genre_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `book_genres`
--

INSERT INTO `book_genres` (`book_id`, `genre_id`) VALUES
(39, 1),
(40, 1),
(43, 1),
(44, 2),
(45, 2),
(46, 2),
(47, 3),
(48, 3),
(49, 3),
(50, 4);

-- --------------------------------------------------------

--
-- Table structure for table `genres`
--

CREATE TABLE `genres` (
  `genre_id` int(11) NOT NULL,
  `genre` varchar(200) NOT NULL,
  `parent_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `genres`
--

INSERT INTO `genres` (`genre_id`, `genre`, `parent_id`) VALUES
(1, 'Networking & Cloud Computing', 2),
(2, 'Computers & Technology', NULL),
(3, 'Programming Languages', 2),
(4, 'Web Development & Design', 2);

-- --------------------------------------------------------

--
-- Table structure for table `publishers`
--

CREATE TABLE `publishers` (
  `publisher_id` int(11) NOT NULL,
  `name` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `publishers`
--

INSERT INTO `publishers` (`publisher_id`, `name`) VALUES
(1, 'Sybex'),
(2, 'O\'Reilly Media'),
(4, 'Addison-Wesley Professional'),
(5, 'No Starch Press'),
(6, 'Packt Publishing'),
(7, 'Byte Code LLC');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `authors`
--
ALTER TABLE `authors`
  ADD PRIMARY KEY (`author_id`);

--
-- Indexes for table `books`
--
ALTER TABLE `books`
  ADD PRIMARY KEY (`book_id`),
  ADD KEY `publisher_id` (`publisher_id`);

--
-- Indexes for table `book_author`
--
ALTER TABLE `book_author`
  ADD PRIMARY KEY (`book_id`,`author_id`),
  ADD KEY `author_id` (`author_id`);

--
-- Indexes for table `book_genres`
--
ALTER TABLE `book_genres`
  ADD PRIMARY KEY (`book_id`,`genre_id`),
  ADD KEY `genre_id` (`genre_id`);

--
-- Indexes for table `genres`
--
ALTER TABLE `genres`
  ADD PRIMARY KEY (`genre_id`),
  ADD KEY `parent_id` (`parent_id`);

--
-- Indexes for table `publishers`
--
ALTER TABLE `publishers`
  ADD PRIMARY KEY (`publisher_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `authors`
--
ALTER TABLE `authors`
  MODIFY `author_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `books`
--
ALTER TABLE `books`
  MODIFY `book_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT for table `genres`
--
ALTER TABLE `genres`
  MODIFY `genre_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `publishers`
--
ALTER TABLE `publishers`
  MODIFY `publisher_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `books`
--
ALTER TABLE `books`
  ADD CONSTRAINT `books_ibfk_1` FOREIGN KEY (`publisher_id`) REFERENCES `publishers` (`publisher_id`);

--
-- Constraints for table `book_author`
--
ALTER TABLE `book_author`
  ADD CONSTRAINT `book_author_ibfk_1` FOREIGN KEY (`author_id`) REFERENCES `authors` (`author_id`),
  ADD CONSTRAINT `book_author_ibfk_2` FOREIGN KEY (`book_id`) REFERENCES `books` (`book_id`);

--
-- Constraints for table `book_genres`
--
ALTER TABLE `book_genres`
  ADD CONSTRAINT `book_genres_ibfk_1` FOREIGN KEY (`genre_id`) REFERENCES `genres` (`genre_id`),
  ADD CONSTRAINT `book_genres_ibfk_2` FOREIGN KEY (`book_id`) REFERENCES `books` (`book_id`);

--
-- Constraints for table `genres`
--
ALTER TABLE `genres`
  ADD CONSTRAINT `genres_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `genres` (`genre_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
