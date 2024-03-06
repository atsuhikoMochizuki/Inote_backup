# ************************************************************
# Antares - SQL Client
# Version 0.7.21
# 
# https://antares-sql.app/
# https://github.com/antares-sql/antares
# 
# Host: 127.0.0.1 (MySQL Community Server - GPL 8.2.0)
# Database: inote
# Generation time: 2024-02-03T05:09:24+01:00
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
SET NAMES utf8mb4;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table board
# ------------------------------------------------------------

DROP TABLE IF EXISTS `board`;

CREATE TABLE `board` (
  `id_board` int NOT NULL AUTO_INCREMENT,
  `creation_date` datetime(6) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `id_user` int DEFAULT NULL,
  PRIMARY KEY (`id_board`),
  KEY `FK83ua0fecqqu5u9vbnt4kt9pyo` (`id_user`),
  CONSTRAINT `FK83ua0fecqqu5u9vbnt4kt9pyo` FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;





# Dump of table category
# ------------------------------------------------------------

DROP TABLE IF EXISTS `category`;

CREATE TABLE `category` (
  `id_category` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `id_user` int DEFAULT NULL,
  PRIMARY KEY (`id_category`),
  KEY `FKl6joxjq33rxbtdl1vvlerygvi` (`id_user`),
  CONSTRAINT `FKl6joxjq33rxbtdl1vvlerygvi` FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;





# Dump of table document
# ------------------------------------------------------------

DROP TABLE IF EXISTS `document`;

CREATE TABLE `document` (
  `id_file` int NOT NULL,
  PRIMARY KEY (`id_file`),
  CONSTRAINT `FKb2vglcm2qjn0nyjfv6ha3cm6d` FOREIGN KEY (`id_file`) REFERENCES `file` (`id_file`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;





# Dump of table file
# ------------------------------------------------------------

DROP TABLE IF EXISTS `file`;

CREATE TABLE `file` (
  `file_type` varchar(31) NOT NULL,
  `id_file` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `path` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_file`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;





# Dump of table image
# ------------------------------------------------------------

DROP TABLE IF EXISTS `image`;

CREATE TABLE `image` (
  `id_file` int NOT NULL,
  PRIMARY KEY (`id_file`),
  CONSTRAINT `FKdal6i53if1crlvbpxl7h1up9i` FOREIGN KEY (`id_file`) REFERENCES `file` (`id_file`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;





# Dump of table note
# ------------------------------------------------------------

DROP TABLE IF EXISTS `note`;

CREATE TABLE `note` (
  `id_note` int NOT NULL AUTO_INCREMENT,
  `content` varchar(255) DEFAULT NULL,
  `creation_date` datetime(6) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `is_published` bit(1) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `id_user` int NOT NULL,
  `id_category` int NOT NULL,
  PRIMARY KEY (`id_note`),
  KEY `FK83ep238ikljeapa4b31jadem7` (`id_user`),
  KEY `FK6md1msv4qprtxqlosneocbq03` (`id_category`),
  CONSTRAINT `FK6md1msv4qprtxqlosneocbq03` FOREIGN KEY (`id_category`) REFERENCES `category` (`id_category`),
  CONSTRAINT `FK83ep238ikljeapa4b31jadem7` FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;





# Dump of table note-file
# ------------------------------------------------------------

DROP TABLE IF EXISTS `note-file`;

CREATE TABLE `note-file` (
  `id_note` int NOT NULL,
  `id_file` int NOT NULL,
  PRIMARY KEY (`id_note`,`id_file`),
  KEY `FK3xqtawsja24d5v2oiadfryguw` (`id_file`),
  CONSTRAINT `FK3xqtawsja24d5v2oiadfryguw` FOREIGN KEY (`id_file`) REFERENCES `file` (`id_file`),
  CONSTRAINT `FKlg1bdv24cxe5a8fgxg4rtnbj9` FOREIGN KEY (`id_note`) REFERENCES `note` (`id_note`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;





# Dump of table note_board
# ------------------------------------------------------------

DROP TABLE IF EXISTS `note_board`;

CREATE TABLE `note_board` (
  `id_note` int NOT NULL,
  `id_board` int NOT NULL,
  PRIMARY KEY (`id_note`,`id_board`),
  KEY `FKr0iv5svaowobak3gutrgdkcci` (`id_board`),
  CONSTRAINT `FK5wqx8thyy6qeo1moccb5kamw0` FOREIGN KEY (`id_note`) REFERENCES `note` (`id_note`),
  CONSTRAINT `FKr0iv5svaowobak3gutrgdkcci` FOREIGN KEY (`id_board`) REFERENCES `board` (`id_board`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;





# Dump of table team
# ------------------------------------------------------------

DROP TABLE IF EXISTS `team`;

CREATE TABLE `team` (
  `id_team` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_team`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;





# Dump of table user
# ------------------------------------------------------------

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id_user` int NOT NULL AUTO_INCREMENT,
  `biography` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `role` tinyint DEFAULT NULL,
  PRIMARY KEY (`id_user`),
  CONSTRAINT `user_chk_1` CHECK ((`role` between 0 and 2))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;





# Dump of table user_board
# ------------------------------------------------------------

DROP TABLE IF EXISTS `user_board`;

CREATE TABLE `user_board` (
  `id_user` int NOT NULL,
  `id_board` int NOT NULL,
  PRIMARY KEY (`id_user`,`id_board`),
  KEY `FKjna5k4e3jyxwr5c41ggh52b6p` (`id_board`),
  CONSTRAINT `FKjna5k4e3jyxwr5c41ggh52b6p` FOREIGN KEY (`id_board`) REFERENCES `user_board_sharing` (`id_user_board_sharing`),
  CONSTRAINT `FKsr198j0qsvlwc315ajkjiisq5` FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;





# Dump of table user_board_sharing
# ------------------------------------------------------------

DROP TABLE IF EXISTS `user_board_sharing`;

CREATE TABLE `user_board_sharing` (
  `id_user_board_sharing` int NOT NULL AUTO_INCREMENT,
  `secured_link` varchar(255) DEFAULT NULL,
  `share_date` datetime(6) DEFAULT NULL,
  `shared_boards_id_board` int DEFAULT NULL,
  `user_id_user` int DEFAULT NULL,
  PRIMARY KEY (`id_user_board_sharing`),
  KEY `FKafg726ku1m965vv79uk2cw1i5` (`shared_boards_id_board`),
  KEY `FKjk7pm47mjlbukhivj9o4u4ke` (`user_id_user`),
  CONSTRAINT `FKafg726ku1m965vv79uk2cw1i5` FOREIGN KEY (`shared_boards_id_board`) REFERENCES `board` (`id_board`),
  CONSTRAINT `FKjk7pm47mjlbukhivj9o4u4ke` FOREIGN KEY (`user_id_user`) REFERENCES `user` (`id_user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;





# Dump of table user_board_suscribe
# ------------------------------------------------------------

DROP TABLE IF EXISTS `user_board_suscribe`;

CREATE TABLE `user_board_suscribe` (
  `id_user_board_suscribe` int NOT NULL AUTO_INCREMENT,
  `suscribe_date` datetime(6) DEFAULT NULL,
  `followed_boards_id_board` int DEFAULT NULL,
  `followers_id_user` int DEFAULT NULL,
  PRIMARY KEY (`id_user_board_suscribe`),
  KEY `FKhen8r85iaa0231n5kq6k6rxkh` (`followed_boards_id_board`),
  KEY `FK63lb2olbajray3eunvjxuowe4` (`followers_id_user`),
  CONSTRAINT `FK63lb2olbajray3eunvjxuowe4` FOREIGN KEY (`followers_id_user`) REFERENCES `user` (`id_user`),
  CONSTRAINT `FKhen8r85iaa0231n5kq6k6rxkh` FOREIGN KEY (`followed_boards_id_board`) REFERENCES `board` (`id_board`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;





# Dump of table user_note
# ------------------------------------------------------------

DROP TABLE IF EXISTS `user_note`;

CREATE TABLE `user_note` (
  `id_user` int NOT NULL,
  `id_note` int NOT NULL,
  PRIMARY KEY (`id_user`,`id_note`),
  KEY `FKqc6il5q5k2el8pfjwarnh6xnk` (`id_note`),
  CONSTRAINT `FKem8ro9hnxbrh6rer3fewwrypf` FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`),
  CONSTRAINT `FKqc6il5q5k2el8pfjwarnh6xnk` FOREIGN KEY (`id_note`) REFERENCES `user_note_sharing` (`id_user_note_sharing`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;





# Dump of table user_note_sharing
# ------------------------------------------------------------

DROP TABLE IF EXISTS `user_note_sharing`;

CREATE TABLE `user_note_sharing` (
  `id_user_note_sharing` int NOT NULL AUTO_INCREMENT,
  `secured_link` varchar(255) DEFAULT NULL,
  `share_date` datetime(6) DEFAULT NULL,
  `notes_sharers_id_user` int DEFAULT NULL,
  `shared_notes_id_note` int DEFAULT NULL,
  PRIMARY KEY (`id_user_note_sharing`),
  KEY `FKcjx1kj9ij5mbcka0s99apskjc` (`notes_sharers_id_user`),
  KEY `FKeb8hmxmfyrl3xj7haxywmwpn7` (`shared_notes_id_note`),
  CONSTRAINT `FKcjx1kj9ij5mbcka0s99apskjc` FOREIGN KEY (`notes_sharers_id_user`) REFERENCES `user` (`id_user`),
  CONSTRAINT `FKeb8hmxmfyrl3xj7haxywmwpn7` FOREIGN KEY (`shared_notes_id_note`) REFERENCES `note` (`id_note`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;





# Dump of table user_role_in_team
# ------------------------------------------------------------

DROP TABLE IF EXISTS `user_role_in_team`;

CREATE TABLE `user_role_in_team` (
  `id_team` int NOT NULL AUTO_INCREMENT,
  `role` varchar(255) DEFAULT NULL,
  `role_in_team` enum('ADMIN','MODERATOR','USER') DEFAULT NULL,
  `team_members_id_user` int DEFAULT NULL,
  `teams_of_members_id_team` int DEFAULT NULL,
  PRIMARY KEY (`id_team`),
  KEY `FKan9pf7hswa7njf6ltvrxmg1gl` (`team_members_id_user`),
  KEY `FKyfgml4hrvrrj117xr02dp66l` (`teams_of_members_id_team`),
  CONSTRAINT `FKan9pf7hswa7njf6ltvrxmg1gl` FOREIGN KEY (`team_members_id_user`) REFERENCES `user` (`id_user`),
  CONSTRAINT `FKyfgml4hrvrrj117xr02dp66l` FOREIGN KEY (`teams_of_members_id_team`) REFERENCES `team` (`id_team`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;





# Dump of table user_team
# ------------------------------------------------------------

DROP TABLE IF EXISTS `user_team`;

CREATE TABLE `user_team` (
  `id_user` int NOT NULL,
  `id_team` int NOT NULL,
  PRIMARY KEY (`id_user`,`id_team`),
  KEY `FKhcbngh5kcp9qtugm7bca2yrx5` (`id_team`),
  CONSTRAINT `FK7ttipce8r654i7okybp2d2yt5` FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`),
  CONSTRAINT `FKhcbngh5kcp9qtugm7bca2yrx5` FOREIGN KEY (`id_team`) REFERENCES `user_role_in_team` (`id_team`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;





# Dump of views
# ------------------------------------------------------------

# Creating temporary tables to overcome VIEW dependency errors


/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

# Dump completed on 2024-02-03T05:09:25+01:00
