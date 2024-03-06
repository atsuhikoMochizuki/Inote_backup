# ************************************************************
# Antares - SQL Client
# Version 0.7.21
# 
# https://antares-sql.app/
# https://github.com/antares-sql/antares
# 
# Host: 127.0.0.1 (MySQL Community Server - GPL 8.2.0)
# Database: inote
# Generation time: 2024-02-05T02:08:45+01:00
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
SET NAMES utf8mb4;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table attachedfile
# ------------------------------------------------------------

CREATE TABLE `attachedfile` (
  `id_file` int NOT NULL,
  `id_note` int NOT NULL,
  PRIMARY KEY (`id_file`,`id_note`),
  KEY `FK5fflq0fh79plajkd0cljkjnv6` (`id_note`),
  CONSTRAINT `FK5fflq0fh79plajkd0cljkjnv6` FOREIGN KEY (`id_note`) REFERENCES `note` (`id_note`),
  CONSTRAINT `FKp9kvims5djjp3xcadjrlnjtxm` FOREIGN KEY (`id_file`) REFERENCES `file` (`id_file`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



# Dump of table board
# ------------------------------------------------------------

CREATE TABLE `board` (
  `id_board` int NOT NULL AUTO_INCREMENT,
  `id_user` int DEFAULT NULL,
  `creation_date` datetime(6) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_board`),
  KEY `FK83ua0fecqqu5u9vbnt4kt9pyo` (`id_user`),
  CONSTRAINT `FK83ua0fecqqu5u9vbnt4kt9pyo` FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`)
) ENGINE=InnoDB AUTO_INCREMENT=99 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



# Dump of table board_following
# ------------------------------------------------------------

CREATE TABLE `board_following` (
  `board_id_board` int DEFAULT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id_user` int DEFAULT NULL,
  `subscription_date` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKls3tekg15ym5uobaxin1ghuw5` (`board_id_board`),
  KEY `FK6hljq053vidt6sy6x2jrj6j1` (`user_id_user`),
  CONSTRAINT `FK6hljq053vidt6sy6x2jrj6j1` FOREIGN KEY (`user_id_user`) REFERENCES `user` (`id_user`),
  CONSTRAINT `FKls3tekg15ym5uobaxin1ghuw5` FOREIGN KEY (`board_id_board`) REFERENCES `board` (`id_board`)
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



# Dump of table board_sharing
# ------------------------------------------------------------

CREATE TABLE `board_sharing` (
  `board_id_board` int DEFAULT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id_user` int DEFAULT NULL,
  `share_date` datetime(6) DEFAULT NULL,
  `securited_link` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK6eq00mnaumr077c42gu13i5i8` (`board_id_board`),
  KEY `FKffo05w0nv671rcwafxi8m3hs7` (`user_id_user`),
  CONSTRAINT `FK6eq00mnaumr077c42gu13i5i8` FOREIGN KEY (`board_id_board`) REFERENCES `board` (`id_board`),
  CONSTRAINT `FKffo05w0nv671rcwafxi8m3hs7` FOREIGN KEY (`user_id_user`) REFERENCES `user` (`id_user`)
) ENGINE=InnoDB AUTO_INCREMENT=79 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



# Dump of table category
# ------------------------------------------------------------

CREATE TABLE `category` (
  `id_category` int NOT NULL AUTO_INCREMENT,
  `id_user` int DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_category`),
  KEY `FKl6joxjq33rxbtdl1vvlerygvi` (`id_user`),
  CONSTRAINT `FKl6joxjq33rxbtdl1vvlerygvi` FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



# Dump of table file
# ------------------------------------------------------------

CREATE TABLE `file` (
  `id_file` int NOT NULL AUTO_INCREMENT,
  `file_type` varchar(31) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `path` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_file`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



# Dump of table note
# ------------------------------------------------------------

CREATE TABLE `note` (
  `id_category` int NOT NULL,
  `id_note` int NOT NULL AUTO_INCREMENT,
  `id_user` int NOT NULL,
  `is_published` bit(1) NOT NULL,
  `creation_date` datetime(6) DEFAULT NULL,
  `content` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_note`),
  KEY `FK83ep238ikljeapa4b31jadem7` (`id_user`),
  KEY `FK6md1msv4qprtxqlosneocbq03` (`id_category`),
  CONSTRAINT `FK6md1msv4qprtxqlosneocbq03` FOREIGN KEY (`id_category`) REFERENCES `category` (`id_category`),
  CONSTRAINT `FK83ep238ikljeapa4b31jadem7` FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`)
) ENGINE=InnoDB AUTO_INCREMENT=301 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



# Dump of table note_board
# ------------------------------------------------------------

CREATE TABLE `note_board` (
  `id_board` int NOT NULL,
  `id_note` int NOT NULL,
  PRIMARY KEY (`id_board`,`id_note`),
  KEY `FK5wqx8thyy6qeo1moccb5kamw0` (`id_note`),
  CONSTRAINT `FK5wqx8thyy6qeo1moccb5kamw0` FOREIGN KEY (`id_note`) REFERENCES `note` (`id_note`),
  CONSTRAINT `FKr0iv5svaowobak3gutrgdkcci` FOREIGN KEY (`id_board`) REFERENCES `board` (`id_board`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



# Dump of table note_sharing
# ------------------------------------------------------------

CREATE TABLE `note_sharing` (
  `id` int NOT NULL AUTO_INCREMENT,
  `note_id_note` int DEFAULT NULL,
  `user_id_user` int DEFAULT NULL,
  `share_date` datetime(6) DEFAULT NULL,
  `securited_link` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKecqrpeko2iddlvmk838hxyski` (`note_id_note`),
  KEY `FKhgl6f12hfo0tf7ett387pmkts` (`user_id_user`),
  CONSTRAINT `FKecqrpeko2iddlvmk838hxyski` FOREIGN KEY (`note_id_note`) REFERENCES `note` (`id_note`),
  CONSTRAINT `FKhgl6f12hfo0tf7ett387pmkts` FOREIGN KEY (`user_id_user`) REFERENCES `user` (`id_user`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



# Dump of table team
# ------------------------------------------------------------

CREATE TABLE `team` (
  `id_team` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_team`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



# Dump of table team_member
# ------------------------------------------------------------

CREATE TABLE `team_member` (
  `id` int NOT NULL AUTO_INCREMENT,
  `is_initiator` bit(1) NOT NULL,
  `member_id_user` int DEFAULT NULL,
  `team_id_team` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKk8mm1mcdsjkk2mc17cyovldm` (`member_id_user`),
  KEY `FK9nv4pae756md7bm1hdg536uul` (`team_id_team`),
  CONSTRAINT `FK9nv4pae756md7bm1hdg536uul` FOREIGN KEY (`team_id_team`) REFERENCES `team` (`id_team`),
  CONSTRAINT `FKk8mm1mcdsjkk2mc17cyovldm` FOREIGN KEY (`member_id_user`) REFERENCES `user` (`id_user`)
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



# Dump of table user
# ------------------------------------------------------------

CREATE TABLE `user` (
  `id_file` int NOT NULL,
  `id_user` int NOT NULL AUTO_INCREMENT,
  `biography` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `role` enum('ADMIN','USER') DEFAULT NULL,
  PRIMARY KEY (`id_user`),
  KEY `FKi5mf424jqldikewp41twse1u1` (`id_file`),
  CONSTRAINT `FKi5mf424jqldikewp41twse1u1` FOREIGN KEY (`id_file`) REFERENCES `file` (`id_file`)
) ENGINE=InnoDB AUTO_INCREMENT=151 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

# Dump completed on 2024-02-05T02:08:45+01:00
