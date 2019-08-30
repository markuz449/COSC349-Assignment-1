-- MariaDB dump 10.17  Distrib 10.4.7-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: nugget
-- ------------------------------------------------------
-- Server version	10.4.7-MariaDB-1:10.4.7+maria~bionic-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `chains`
--

DROP TABLE IF EXISTS `chains`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `chains` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `rating` int(11) NOT NULL DEFAULT 0,
  `nicename` varchar(50) NOT NULL,
  `rating_count` int(11) NOT NULL DEFAULT 0,
  `avg_flavour` int(11) DEFAULT NULL,
  `avg_mouthfeel` int(11) DEFAULT NULL,
  `avg_coating` int(11) DEFAULT NULL,
  `avg_sauce` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `nicename` (`nicename`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `images`
--

DROP TABLE IF EXISTS `images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `images` (
  `webid` varchar(36) COLLATE utf8_unicode_ci DEFAULT NULL,
  `filename` varchar(36) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `locations`
--

DROP TABLE IF EXISTS `locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `locations` (
  `lat` decimal(9,6) NOT NULL,
  `lng` decimal(9,6) NOT NULL,
  `chain` mediumint(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `email` varchar(250) NOT NULL,
  `message` mediumtext NOT NULL,
  `datetime` datetime DEFAULT current_timestamp(),
  `browser` mediumtext DEFAULT NULL,
  `ip` mediumtext DEFAULT NULL,
  `read` tinyint(1) DEFAULT 0,
  `deleted` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `prices`
--

DROP TABLE IF EXISTS `prices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `chain` int(11) NOT NULL,
  `price` float NOT NULL,
  `number` int(11) NOT NULL,
  `date` date NOT NULL,
  `current` tinyint(1) NOT NULL DEFAULT 1,
  `comments` mediumtext DEFAULT NULL,
  `per` float NOT NULL,
  `checked` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reviews` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` text NOT NULL,
  `email` varchar(200) NOT NULL,
  `chain` int(2) NOT NULL DEFAULT 0,
  `comments` mediumtext DEFAULT NULL,
  `flavour` int(1) DEFAULT NULL,
  `mouthfeel` int(1) DEFAULT NULL,
  `coating` int(1) DEFAULT NULL,
  `sauces` int(1) DEFAULT NULL,
  `overall` int(1) NOT NULL DEFAULT 0,
  `date` datetime NOT NULL DEFAULT current_timestamp(),
  `webid` varchar(36) DEFAULT NULL,
  `approved` int(1) NOT NULL DEFAULT 1,
  `featured` int(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `user` (`chain`,`email`),
  KEY `webid` (`webid`)
) ENGINE=InnoDB AUTO_INCREMENT=143 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
ALTER DATABASE `nugget` CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `reviews_after_insert` AFTER INSERT ON `reviews` FOR EACH ROW UPDATE chains 
SET 
	rating = (SELECT AVG(overall) FROM reviews WHERE chain = NEW.chain),
	avg_flavour = (SELECT AVG(flavour) FROM reviews WHERE chain = NEW.chain),
	avg_mouthfeel = (SELECT AVG(mouthfeel) FROM reviews WHERE chain = NEW.chain),
	avg_coating = (SELECT AVG(coating) FROM reviews WHERE chain = NEW.chain),
	avg_sauce = (SELECT AVG(sauces) FROM reviews WHERE chain = NEW.chain),
	rating_count = (SELECT COUNT(id) FROM reviews WHERE chain = NEW.chain)
WHERE id = NEW.chain */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `nugget` CHARACTER SET utf8 COLLATE utf8_unicode_ci ;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tags` (
  `price` int(11) NOT NULL,
  `tag` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `colour` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`price`,`tag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `thumbs`
--

DROP TABLE IF EXISTS `thumbs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `thumbs` (
  `webid` varchar(36) NOT NULL,
  `ip` varchar(39) NOT NULL,
  `agent` mediumtext NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp(),
  `up` tinyint(1) NOT NULL DEFAULT 1,
  KEY `webid` (`webid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(32) NOT NULL,
  `password` char(40) NOT NULL,
  `name` varchar(120) NOT NULL,
  `email` varchar(70) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `active` char(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-08-18 10:09:36

INSERT INTO `chains` VALUES (1,'Burger King',4,'burger-king',10,3,4,4,3),(2,'KFC',2,'kfc',6,3,2,2,2),(3,'McDonald\'s',4,'mcdonalds',13,4,4,4,4),(4,'Wendy\'s',5,'wendys',5,4,5,5,4);
INSERT INTO `images` VALUES ('8b699816-6b90-482e-bba0-65d2a3e99921','d00038c8-6690-4bb1-b031-26570ef27cfa'),('efc75bc4-83e1-490e-a2ae-5315c4ad9ffe','516ab81c-49fa-43c6-abaa-39a018b50d6d'),('8a34a431-7ec7-48d6-be59-229b4df0e856','4a8cf45b-7f71-41df-a02f-9b27f43df308'),('8a34a431-7ec7-48d6-be59-229b4df0e856','d9fba0d9-9018-44ff-a6b2-13c67a980b5f'),('f3fe1f15-4b22-4641-9058-b44e47617b86','66e8e382-486c-40a6-a839-7306d1c37b32'),('3c2c1412-d72c-4eb7-bfb0-67a2567af502','9cb2905e-0ea4-46e5-8298-d7a3114f58ef'),('94f99684-f1f0-49dd-b415-75bea9395486','4c7033f5-3c00-4028-b328-df8e2f464404'),('8bf3a8e2-de27-434b-8e58-ee24152501d6','1bd4dbe5-f740-42bf-b09c-6dc3eb952c49');
INSERT INTO `prices` VALUES (1,3,10,20,'2019-06-11',0,'Nuggies!',0.5,'2019-06-20 05:59:06'),(2,2,6.2,6,'2019-06-12',0,'Aoli, tomato, bbq or sweet chilli',1.03,'2019-06-20 05:59:06'),(3,4,4.5,5,'2019-06-12',1,'',0.9,'2019-08-14 02:03:04'),(4,4,7.6,9,'2019-06-12',1,'',0.84,'2019-08-14 02:03:06'),(5,4,9.9,12,'2019-06-12',1,'',0.83,'2019-08-14 02:03:09'),(6,1,3,9,'2019-06-12',1,'',0.33,'2019-08-15 02:43:55'),(7,3,8.4,10,'2019-06-13',0,'',0.84,'2019-06-20 05:59:06'),(8,3,6.1,6,'2019-06-13',1,'',1.02,'2019-08-14 02:02:53'),(9,1,9.1,10,'2019-06-13',1,'',0.91,'2019-07-26 00:04:15'),(10,1,14.9,20,'2019-06-13',0,'',0.75,'2019-07-13 04:14:19'),(11,2,5.4,6,'2019-06-15',1,'',0.9,'2019-08-14 02:03:00'),(12,3,8.1,10,'2019-06-15',0,'',0.81,'2019-06-20 05:59:06'),(13,3,15.4,20,'2019-06-20',0,'',0.77,'2019-06-20 05:59:06'),(14,3,16.6,20,'2019-06-25',0,'',0.83,'2019-07-31 01:28:00'),(15,3,8.4,10,'2019-06-25',1,'',0.84,'2019-08-14 02:02:55'),(16,2,1,1,'2019-06-28',0,NULL,1,'2019-06-28 05:17:20'),(17,1,15.2,20,'2019-07-26',0,NULL,0.76,'2019-07-26 00:04:41'),(18,1,14.9,20,'2019-07-27',1,NULL,0.75,'2019-07-27 23:42:46'),(19,3,3,6,'2019-07-29',0,NULL,0.5,'2019-07-29 23:16:44'),(20,4,1,1,'2019-07-30',0,NULL,1,'2019-07-30 22:31:50'),(21,4,1,1,'2019-07-30',0,NULL,1,'2019-07-30 22:32:05'),(22,4,1,1,'2019-07-30',0,NULL,1,'2019-07-30 22:32:54'),(23,4,1,1,'2019-07-30',0,NULL,1,'2019-07-30 22:33:16'),(24,4,1,1,'2019-07-30',0,NULL,1,'2019-07-30 22:34:21'),(25,4,1,1,'2019-07-30',0,NULL,1,'2019-07-30 22:36:26'),(26,4,1,1,'2019-07-30',0,NULL,1,'2019-07-30 22:37:36'),(27,4,1,1,'2019-07-31',0,NULL,1,'2019-07-31 01:28:13'),(28,3,10,20,'2019-08-11',0,NULL,0.5,'2019-08-14 02:02:58');
INSERT INTO `reviews` VALUES (2,'anon@41.com','anon@5.com',4,'Decent. The coating was nice. The sweet and sour sauce looks like toothpaste or strawberry jelly',4,4,5,2,4,'2019-06-20 09:24:55','735f9550-b44e-11e9-8bcb-7259707ff18c',1),(3,'Nathan','anon@6.com',2,'The nuggets weren\'t very warm and the flavour was lacking. The coating was as good as McDonalds\r\n\r\nUpdate:\r\nThese nuggets were way warmer and nicer than my previous tasting. You\'ve earned yourself another star, burger king.',4,5,4,5,4,'2019-06-20 09:24:55','735f98c2-b44e-11e9-8bcb-7259707ff18c',1),(4,'Marcus','anon@7.com',1,'The nuggets were bland and weren\'t very tasty',2,4,4,5,3,'2019-06-20 09:24:55','735f9a54-b44e-11e9-8bcb-7259707ff18c',1),(5,'Grace','yesitisibag@gmail.com',1,'Shape: Uninspired\r\n\r\nclassic chicken flavour but not much else\r\n',3,4,5,3,4,'2019-06-20 09:24:55','735f9b88-b44e-11e9-8bcb-7259707ff18c',1),(7,'Mr Nugget','anon@9.com',3,'This is what chicken nuggets should be. The right amount of crunch on the outside and a good mouthfeel on the inside. McDonalds have chiseled these chicken chunks into the bell, the ball, the boot, and the bone and their efforts have not gone unnoticed - this only added to the enjoyment of these nuggets. The sweet and sour sauce is hands down the best sauce. I found the BBQ sauce was lackluster.\r\nHighly recommend',5,5,5,4,5,'2019-08-14 09:24:55','8a34a431-7ec7-48d6-be59-229b4df0e856',1),(8,'Marcus','anon@31.com',2,'Not consistent and quite shit. Buy the popcorn instead',3,2,1,1,2,'2019-06-15 09:24:55','735f9d61-b44e-11e9-8bcb-7259707ff18c',1),(9,'Marcus ','anon@25.com',3,'Very tasty and still the best choice for chicken nuggets ',4,4,5,5,5,'2019-08-14 09:24:55','f3fe1f15-4b22-4641-9058-b44e47617b86',1),(10,'Marcus','anon@32.com',4,'Pretty good, solid coating and solid taste',3,4,5,2,4,'2019-06-20 09:24:55','735f9e93-b44e-11e9-8bcb-7259707ff18c',1),(58,'Nathan','anon@26.com',2,'These weren\'t great. The coating was soft and gross. The chicken inside was a weird texture and did not feel nice to eat. The BBQ sauce was decent but unfortunately they didn\'t have any sweet and sour sauce. The popcorn chicken, however, was good.',2,2,2,2,2,'2019-06-27 08:11:06','735f9f12-b44e-11e9-8bcb-7259707ff18c',1),(106,'Matt','anon@33.com',2,'The nugget had a nice feel although the taste wasn\'t all that great',2,4,1,3,3,'2019-06-28 07:44:48','735f9fd4-b44e-11e9-8bcb-7259707ff18c',1),(108,'James','anon@27.com',3,'The overall taste of my nuggys was good but the lack of sauce, was disappointing I should not have to ask for the sauce and the way it felt in my mouth as I grinded the sweet night in my mouth felt a little rubbery but okay.\r\n',4,3,4,1,4,'2019-07-09 02:57:15','735fa055-b44e-11e9-8bcb-7259707ff18c',1),(109,'Cheyenne ','anon@34.com',3,'',4,4,5,3,4,'2019-07-09 03:10:24','735fa0fb-b44e-11e9-8bcb-7259707ff18c',1),(110,'Jack ','anon@35.com',3,'The nuggets were pretty good just finished doing blow in tha bathroom so idek if i was eating the nuggets but yeah ',3,2,2,4,3,'2019-07-09 03:21:01','735fa184-b44e-11e9-8bcb-7259707ff18c',1),(111,'Maree Morris','anon@36.com',1,'',3,1,4,2,3,'2019-07-09 03:22:51','735fa29a-b44e-11e9-8bcb-7259707ff18c',1),(112,'Charlie McLaren','anon@37.com',3,'',5,4,5,3,5,'2019-07-09 03:46:26','735fa328-b44e-11e9-8bcb-7259707ff18c',1),(113,'Hassen Kadhem','anon@38.com',3,'I like nuggets ',5,5,5,5,5,'2019-07-09 04:12:33','735fa396-b44e-11e9-8bcb-7259707ff18c',1),(114,'Sammie Morris','anon@30.com',3,'They need more sauce !!!',4,3,3,3,4,'2019-07-09 04:17:18','735fa404-b44e-11e9-8bcb-7259707ff18c',1),(115,'The jHonnie','anon@42.com',1,'They overcharged for 20 nuggies by charging two tens rather than a 20 piece. ',2,3,2,3,3,'2019-07-09 04:42:24','735fa474-b44e-11e9-8bcb-7259707ff18c',1),(116,'kyle','anon@16.com',1,'its not a bad time going to BK it is tasty and good ',4,2,4,3,4,'2019-07-09 05:43:17','735fa4fa-b44e-11e9-8bcb-7259707ff18c',1),(117,'Gary ','anon@39.com',1,'Omg they make burgers with the goodness of nuggs in them, I\'m on love OwO',4,5,3,1,5,'2019-07-12 04:47:09','735fa567-b44e-11e9-8bcb-7259707ff18c',1),(118,'Nick','anon@17.com',2,'Not that great tbh over priced to',3,1,2,1,2,'2019-07-19 08:56:46','735fa5d9-b44e-11e9-8bcb-7259707ff18c',1),(119,'Kiri, PhNug','anon@43.com',3,'McDonalds is the epitome of Nug, its texture and balance of crispiness and tenderness is unparalleled. The flavour of Macca\'s Nugs can only be characterised by the sweet intimacy with a loved one on a passionate Valentines Day.\r\n\r\nMcDonalds has perfected the art of the Nug and will forever be held in the pantheon of the Deep Fried, beside Chimichanga and Deep Fried Moro Bars. ',5,5,5,5,5,'2019-07-25 22:30:18','735fa676-b44e-11e9-8bcb-7259707ff18c',1),(120,'Kiri, PhNug','anon@18.com',1,'Burger King has attempted to recreate the perfection that is McDonalds Nug but has come... one short of a six pack.\r\n\r\nBK has admirably been seated on top of Maccas in terms of its selection of sauces, however it is hard to beat Maccas Sweet and Sour.\r\n\r\nBK\'s Nugs are in Laymens terms: something between cardboard and edible. The texture and taste are mediocre and bland, really mirroring the price that you pay for these Nugs.\r\n\r\nOverall, if you have just received your allowance then go to McDonalds. If you are at the end of your week, spent most of your money on booze and vape canisters, and need a snack to tide you over to dinner time... go to BK or honestly, get a frozen bag of Chicken Nuggets from the supermarket...',4,3,2,4,3,'2019-07-25 22:51:35','735fa723-b44e-11e9-8bcb-7259707ff18c',1),(121,'Mitchell Green','anon@44.com',1,'5/5 for the price. Why pay far too much money on better nuggets when you can spend just 3 dollars and get an okay dish to save money. ',4,5,4,3,5,'2019-07-27 09:34:52','735fa846-b44e-11e9-8bcb-7259707ff18c',1),(122,'Ben Benham','anon@19.com',2,'Woof woof woof, inhaled mine in under 30  seconds,  too fast to taste,  woof,  chomp,  sluurp',1,1,1,1,1,'2019-07-26 09:43:09','735fa8d7-b44e-11e9-8bcb-7259707ff18c',1),(123,'Taylor','anon@45.com',2,'Tried out KFC nugs when they did they 20 for $10. Did not regret it as they came with my favourite sauce... AIOLI!!!\r\nNot overly sweet like maccas nugs, a good change up with a true chicken taste.',5,4,4,5,4,'2019-07-26 11:02:49','735fa94b-b44e-11e9-8bcb-7259707ff18c',1),(124,'cum again?','anon@20.com',3,'the savoury feeling of these nugs is of legend, mixed with the delightful music of a poor man out side made these nugs one to remember.',3,4,3,2,4,'2019-07-29 02:00:43','735fa9d7-b44e-11e9-8bcb-7259707ff18c',1),(125,'Haley','anon@46.com',3,'The contrast between the slightly crunchy coating and the soft juicy \"chicken\" makes for the perfect mouthfeel.\r\nIt tastes like actual chicken, unlike the gray/brown nuggets my dad made for dinner yesterday.\r\nI went for the classic sweet and sour sauce, which is the only right option to pair with Mcdonalds nuggs. They could go easy on the sour though. ',4,5,5,4,5,'2019-07-29 14:12:09','735faa90-b44e-11e9-8bcb-7259707ff18c',1),(130,'Sarah','anon@21.com',3,'Delicious and paired with good sauces (BBQ & Sweet/sour). Had a firm crust, and soft centre. Good value for the moneys ',5,5,5,5,5,'2019-08-04 03:38:37','582d070f-b669-11e9-8bcb-7259707ff18c',1),(131,'Mr nuggy ','anon@47.com',4,'Pricing is a bit much but they are by far the best ðŸ˜Š.',5,5,5,5,5,'2019-08-05 08:23:28','4da39cc1-b75a-11e9-8bcb-7259707ff18c',1),(132,'#nugsnotdrugs','anon@22.com',4,'I have had many a nug in my time, but this. This right here is what all nugs should aspire to be. Oh so flavourful with just the right mouthfeel to really get me going. Top it off with the reward of succulent BBQ sauce and call me a winner tonight. \r\n#nugsnotdrugs',5,5,4,5,5,'2019-08-05 20:36:41','bb3e30e1-b7c0-11e9-8bcb-7259707ff18c',1),(141,'Nugget bros ','anon@48.com',3,'Nothing tops a nug on a drunk night out',4,5,5,4,4,'2019-08-14 23:44:13','8bf3a8e2-de27-434b-8e58-ee24152501d6',1),(142,'grace','anon@49.com',1,'shape: uninspired\r\n\r\nclassic chicken flavor but not much else',3,4,4,1,4,'2019-08-15 03:52:49','94f99684-f1f0-49dd-b415-75bea9395486',1);
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `reviews_before_update` BEFORE INSERT ON `reviews` FOR EACH ROW UPDATE reviews
SET featured = 0
WHERE chain = NEW.chain */;;
DELIMITER ;
