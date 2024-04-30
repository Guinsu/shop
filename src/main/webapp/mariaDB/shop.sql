-- --------------------------------------------------------
-- 호스트:                          127.0.0.1
-- 서버 버전:                        10.4.33-MariaDB - mariadb.org binary distribution
-- 서버 OS:                        Win64
-- HeidiSQL 버전:                  12.6.0.6765
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- shop 데이터베이스 구조 내보내기
CREATE DATABASE IF NOT EXISTS `shop` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci */;
USE `shop`;

-- 테이블 shop.category 구조 내보내기
CREATE TABLE IF NOT EXISTS `category` (
  `category` varchar(50) NOT NULL,
  `create_date` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`category`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 shop.category:~4 rows (대략적) 내보내기
INSERT IGNORE INTO `category` (`category`, `create_date`) VALUES
	('로열 티니핑(시즌2)', '2024-04-08 17:31:04'),
	('로열 티니핑(시즌3)', '2024-04-08 17:31:22'),
	('로열 티니핑(시즌4)', '2024-04-08 17:31:55'),
	('티니핑(시즌1)', '2024-04-08 17:30:52');

-- 테이블 shop.comment 구조 내보내기
CREATE TABLE IF NOT EXISTS `comment` (
  `comment_no` int(11) NOT NULL AUTO_INCREMENT,
  `order_no` int(11) NOT NULL,
  `goods_no` int(11) NOT NULL,
  `email` varchar(50) NOT NULL,
  `score` int(11) NOT NULL,
  `content` text NOT NULL,
  `update_date` datetime NOT NULL,
  `create_date` datetime NOT NULL,
  PRIMARY KEY (`comment_no`),
  KEY `FK_comment_orders` (`order_no`),
  KEY `FK_comment_goods` (`goods_no`),
  KEY `FK_comment_customer` (`email`),
  CONSTRAINT `FK_comment_customer` FOREIGN KEY (`email`) REFERENCES `customer` (`email`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_comment_goods` FOREIGN KEY (`goods_no`) REFERENCES `goods` (`goods_no`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_comment_orders` FOREIGN KEY (`order_no`) REFERENCES `orders` (`order_no`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 shop.comment:~1 rows (대략적) 내보내기
INSERT IGNORE INTO `comment` (`comment_no`, `order_no`, `goods_no`, `email`, `score`, `content`, `update_date`, `create_date`) VALUES
	(17, 31, 549, '123123', 4, '테스트입니다', '2024-04-30 10:30:55', '2024-04-30 10:30:55');

-- 테이블 shop.customer 구조 내보내기
CREATE TABLE IF NOT EXISTS `customer` (
  `email` varchar(50) NOT NULL,
  `pw` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `birth` date NOT NULL,
  `gender` enum('남','여') NOT NULL DEFAULT '여',
  `update_date` datetime NOT NULL DEFAULT current_timestamp(),
  `create_date` datetime NOT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 shop.customer:~2 rows (대략적) 내보내기
INSERT IGNORE INTO `customer` (`email`, `pw`, `name`, `birth`, `gender`, `update_date`, `create_date`) VALUES
	('123123', '*E56A114692FE0DE073F9A1DD68A00EEB9703F3F1', '1', '2024-03-01', '남', '2024-04-22 12:37:23', '2024-04-11 13:23:46'),
	('321321', '*4160291B4C8CC2573CC94951203FFBC858754907', '321321', '2024-04-18', '남', '2024-04-30 10:08:13', '2024-04-30 10:08:13');

-- 테이블 shop.emp 구조 내보내기
CREATE TABLE IF NOT EXISTS `emp` (
  `emp_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `grade` int(11) NOT NULL DEFAULT 0,
  `emp_pw` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `emp_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `emp_job` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `hire_date` date NOT NULL,
  `update_date` date NOT NULL DEFAULT current_timestamp(),
  `create_date` date NOT NULL DEFAULT current_timestamp(),
  `active` enum('ON','OFF') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'OFF',
  PRIMARY KEY (`emp_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- 테이블 데이터 shop.emp:~104 rows (대략적) 내보내기
INSERT IGNORE INTO `emp` (`emp_id`, `grade`, `emp_pw`, `emp_name`, `emp_job`, `hire_date`, `update_date`, `create_date`, `active`) VALUES
	('abahde20@yandex.ru', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Aili', '영업', '2023-09-30', '2024-04-02', '2024-04-02', 'OFF'),
	('acrakem@de.vu', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Angelico', '영업', '2023-04-11', '2024-04-02', '2024-04-02', 'OFF'),
	('adellascalai@cnbc.com', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Alameda', '영업', '2024-03-24', '2024-04-02', '2024-04-02', 'OFF'),
	('admin', 1, '*A4B6157319038724E3560894F7F932C8886EBFCF', '구디', '팀장', '2024-01-01', '2024-04-01', '2024-04-01', 'ON'),
	('admin2', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', '루피', '사원', '2024-01-01', '2024-04-01', '2024-04-01', 'OFF'),
	('admin3', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', '조로', '사원', '2024-01-01', '2024-04-01', '2024-04-01', 'OFF'),
	('admin4', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', '나미', '사원', '2024-01-01', '2024-04-01', '2024-04-01', 'OFF'),
	('adorrancel@dailymail.co.uk', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Amabel', '마케팅', '2023-09-25', '2024-04-02', '2024-04-02', 'OFF'),
	('amcsorley2a@go.com', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Abbott', '인사', '2024-02-22', '2024-04-02', '2024-04-02', 'OFF'),
	('anapper1m@de.vu', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Alfons', '마케팅', '2024-02-12', '2024-04-02', '2024-04-02', 'OFF'),
	('aranaghan24@dmoz.org', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Adriena', '마케팅', '2024-03-23', '2024-04-02', '2024-04-02', 'OFF'),
	('astubs14@aboutads.info', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Aguistin', '마케팅', '2023-06-22', '2024-04-02', '2024-04-02', 'OFF'),
	('awestphal0@businesswire.com', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Alia', '영업', '2023-10-07', '2024-04-02', '2024-04-02', 'OFF'),
	('awithropf@dailymail.co.uk', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Avery', '마케팅', '2024-01-23', '2024-04-02', '2024-04-02', 'OFF'),
	('baggliot@nifty.com', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Boris', '마케팅', '2023-09-01', '2024-04-02', '2024-04-02', 'OFF'),
	('bbliven18@angelfire.com', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Brandtr', '개발', '2023-12-12', '2024-04-02', '2024-04-02', 'OFF'),
	('bcellone16@geocities.com', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Buckie', '인사', '2023-05-30', '2024-04-02', '2024-04-02', 'OFF'),
	('bdoerrling2c@zdnet.com', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Brian', '영업', '2023-08-11', '2024-04-02', '2024-04-02', 'OFF'),
	('bgabbatiss26@telegraph.co.uk', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Bailie', '개발', '2023-05-28', '2024-04-02', '2024-04-02', 'OFF'),
	('bgrote7@auda.org.au', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Bone', '인사', '2023-05-19', '2024-04-02', '2024-04-02', 'OFF'),
	('bmccaskill21@tumblr.com', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Bernardine', '인사', '2023-08-22', '2024-04-02', '2024-04-02', 'OFF'),
	('bnowak5@friendfeed.com', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Bobby', '개발', '2024-01-23', '2024-04-02', '2024-04-02', 'OFF'),
	('brustmane@squarespace.com', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Batholomew', '마케팅', '2023-10-21', '2024-04-02', '2024-04-02', 'OFF'),
	('bshillingtonx@washington.edu', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Brigg', '개발', '2023-09-30', '2024-04-02', '2024-04-02', 'OFF'),
	('btorald1e@bbb.org', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Brendan', '영업', '2023-04-08', '2024-04-02', '2024-04-02', 'OFF'),
	('cbernth1t@tripadvisor.com', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Caryl', '개발', '2024-01-23', '2024-04-02', '2024-04-02', 'ON'),
	('ccarlile27@irs.gov', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Carlotta', '마케팅', '2023-05-20', '2024-04-02', '2024-04-02', 'OFF'),
	('ccristoforo1c@bluehost.com', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Cozmo', '마케팅', '2023-09-18', '2024-04-02', '2024-04-02', 'OFF'),
	('cdollen17@comcast.net', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Carree', '마케팅', '2023-06-05', '2024-04-02', '2024-04-02', 'OFF'),
	('cmcnamara2r@unicef.org', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Celisse', '마케팅', '2023-05-21', '2024-04-02', '2024-04-02', 'OFF'),
	('cmeiklam12@wsj.com', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Cristine', '개발', '2023-08-07', '2024-04-02', '2024-04-02', 'OFF'),
	('coconnolly2q@bravesites.com', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Cyb', '마케팅', '2023-04-06', '2024-04-02', '2024-04-02', 'OFF'),
	('crawcliffn@nbcnews.com', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Clarinda', '마케팅', '2023-09-08', '2024-04-02', '2024-04-02', 'OFF'),
	('cscarfe28@vk.com', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Chery', '인사', '2023-10-20', '2024-04-02', '2024-04-02', 'OFF'),
	('ctitley4@virginia.edu', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Chantalle', '인사', '2024-02-20', '2024-04-02', '2024-04-02', 'OFF'),
	('dgooble2g@google.fr', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Dunn', '영업', '2024-03-25', '2024-04-02', '2024-04-02', 'OFF'),
	('dkleinsteinw@last.fm', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Daren', '영업', '2023-10-26', '2024-04-02', '2024-04-02', 'OFF'),
	('dvaarq@fastcompany.com', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Daniel', '영업', '2023-05-09', '2024-04-02', '2024-04-02', 'OFF'),
	('ealdwick1n@dedecms.com', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Eugene', '인사', '2023-06-08', '2024-04-02', '2024-04-02', 'OFF'),
	('egalliard8@paginegialle.it', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Ermanno', '마케팅', '2023-06-07', '2024-04-02', '2024-04-02', 'OFF'),
	('esymers2e@networksolutions.com', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Emalee', '인사', '2023-09-22', '2024-04-02', '2024-04-02', 'OFF'),
	('ethackray1u@netscape.com', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Ellen', '마케팅', '2023-05-16', '2024-04-02', '2024-04-02', 'OFF'),
	('fblaasch2m@cam.ac.uk', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Farr', '개발', '2023-05-17', '2024-04-02', '2024-04-02', 'OFF'),
	('fpockettz@hugedomains.com', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Fremont', '인사', '2023-12-09', '2024-04-02', '2024-04-02', 'OFF'),
	('fritmeier3@fda.gov', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Fleurette', '개발', '2023-08-12', '2024-04-02', '2024-04-02', 'OFF'),
	('gjukesr@tamu.edu', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Gretchen', '마케팅', '2023-09-23', '2024-04-02', '2024-04-02', 'OFF'),
	('grubinshtein1f@yellowpages.com', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Giustino', '개발', '2023-09-19', '2024-04-02', '2024-04-02', 'OFF'),
	('hbrave15@bing.com', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Hoyt', '개발', '2024-01-14', '2024-04-02', '2024-04-02', 'OFF'),
	('hkeddles@cargocollective.com', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Hillier', '인사', '2023-08-27', '2024-04-02', '2024-04-02', 'OFF'),
	('hkemery2i@unicef.org', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Haskel', '마케팅', '2024-03-05', '2024-04-02', '2024-04-02', 'OFF'),
	('hlombardo11@so-net.ne.jp', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Hart', '마케팅', '2023-10-21', '2024-04-02', '2024-04-02', 'OFF'),
	('hmedina1w@printfriendly.com', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Halli', '마케팅', '2023-08-04', '2024-04-02', '2024-04-02', 'OFF'),
	('hwanne2@mit.edu', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Hal', '마케팅', '2023-08-21', '2024-04-02', '2024-04-02', 'OFF'),
	('istrowther1g@tuttocitta.it', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Ira', '마케팅', '2023-05-20', '2024-04-02', '2024-04-02', 'OFF'),
	('ivielp@gnu.org', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Ilysa', '영업', '2023-06-03', '2024-04-02', '2024-04-02', 'OFF'),
	('jallner2n@intel.com', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Jacinta', '인사', '2023-09-15', '2024-04-02', '2024-04-02', 'OFF'),
	('jdunbabin1@omniture.com', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Jethro', '영업', '2023-11-08', '2024-04-02', '2024-04-02', 'OFF'),
	('jjaszczak23@fotki.com', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Jinny', '인사', '2024-02-12', '2024-04-02', '2024-04-02', 'OFF'),
	('jmiddlemist1q@opensource.org', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Juieta', '마케팅', '2023-12-28', '2024-04-02', '2024-04-02', 'OFF'),
	('jplowman1y@google.com.br', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Jessalyn', '마케팅', '2023-09-13', '2024-04-02', '2024-04-02', 'OFF'),
	('jquogan2j@sogou.com', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Jacky', '마케팅', '2024-03-30', '2024-04-02', '2024-04-02', 'OFF'),
	('jromke1h@aboutads.info', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Joseito', '영업', '2023-12-13', '2024-04-02', '2024-04-02', 'OFF'),
	('kannandalev@stumbleupon.com', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Kale', '영업', '2023-08-30', '2024-04-02', '2024-04-02', 'OFF'),
	('kmccaghan1i@meetup.com', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Kitty', '마케팅', '2024-03-29', '2024-04-02', '2024-04-02', 'OFF'),
	('kmckirtonu@xinhuanet.com', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Korey', '개발', '2023-05-23', '2024-04-02', '2024-04-02', 'OFF'),
	('kpriorg@live.com', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Klarrisa', '인사', '2023-07-27', '2024-04-02', '2024-04-02', 'OFF'),
	('lbritoj@google.es', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Latrina', '마케팅', '2023-09-03', '2024-04-02', '2024-04-02', 'OFF'),
	('ldillaway2b@hatena.ne.jp', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Lucian', '마케팅', '2023-06-16', '2024-04-02', '2024-04-02', 'OFF'),
	('lfancutt13@blogs.com', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Louisa', '인사', '2024-03-30', '2024-04-02', '2024-04-02', 'OFF'),
	('lgenders1s@hatena.ne.jp', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Laurianne', '마케팅', '2024-03-01', '2024-04-02', '2024-04-02', 'OFF'),
	('lgladdish1v@loc.gov', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Lucina', '영업', '2023-05-09', '2024-04-02', '2024-04-02', 'OFF'),
	('lgrishin1l@admin.ch', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Lek', '개발', '2023-04-02', '2024-04-02', '2024-04-02', 'OFF'),
	('lnellea@shareasale.com', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Lian', '마케팅', '2023-08-11', '2024-04-02', '2024-04-02', 'OFF'),
	('lstansfield2h@squarespace.com', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Lottie', '인사', '2024-03-25', '2024-04-02', '2024-04-02', 'OFF'),
	('mdowngate1r@arstechnica.com', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Madelina', '마케팅', '2024-01-25', '2024-04-02', '2024-04-02', 'OFF'),
	('mjanicek6@webmd.com', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Mattie', '개발', '2024-03-01', '2024-04-02', '2024-04-02', 'OFF'),
	('mklee1z@dailymail.co.uk', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Meredithe', '마케팅', '2023-05-06', '2024-04-02', '2024-04-02', 'OFF'),
	('mmcilory2o@umich.edu', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Madelena', '인사', '2023-05-30', '2024-04-02', '2024-04-02', 'OFF'),
	('mscad2l@weather.com', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Myra', '마케팅', '2023-08-24', '2024-04-02', '2024-04-02', 'OFF'),
	('oerswell1x@bing.com', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Odella', '마케팅', '2023-06-09', '2024-04-02', '2024-04-02', 'OFF'),
	('pbaudassoc@meetup.com', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Pall', '마케팅', '2023-08-27', '2024-04-02', '2024-04-02', 'OFF'),
	('phadwick1a@ucla.edu', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Parnell', '인사', '2024-02-11', '2024-04-02', '2024-04-02', 'OFF'),
	('pmattingly19@wufoo.com', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Pammi', '영업', '2023-09-26', '2024-04-02', '2024-04-02', 'OFF'),
	('pmoulton1b@alibaba.com', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Pavel', '인사', '2023-08-02', '2024-04-02', '2024-04-02', 'OFF'),
	('pswine2k@walmart.com', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Pauline', '인사', '2023-06-23', '2024-04-02', '2024-04-02', 'OFF'),
	('rbrazil2p@typepad.com', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Renado', '개발', '2023-09-15', '2024-04-02', '2024-04-02', 'OFF'),
	('rbroune29@ed.gov', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Raquela', '마케팅', '2024-02-02', '2024-04-02', '2024-04-02', 'OFF'),
	('rdilliwayh@ifeng.com', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Rodney', '인사', '2023-09-09', '2024-04-02', '2024-04-02', 'OFF'),
	('rdoale2d@bloglines.com', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Raphaela', '마케팅', '2023-10-29', '2024-04-02', '2024-04-02', 'OFF'),
	('rkennealy1p@discovery.com', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Ramona', '영업', '2023-10-29', '2024-04-02', '2024-04-02', 'OFF'),
	('rpidler1k@seattletimes.com', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Rafa', '마케팅', '2023-12-26', '2024-04-02', '2024-04-02', 'OFF'),
	('sdoxsey22@t-online.de', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Stanly', '마케팅', '2023-12-30', '2024-04-02', '2024-04-02', 'OFF'),
	('sgentric10@prweb.com', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Saleem', '인사', '2024-03-29', '2024-04-02', '2024-04-02', 'OFF'),
	('spauleitb@altervista.org', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Sheryl', '마케팅', '2023-09-01', '2024-04-02', '2024-04-02', 'OFF'),
	('srabjohns25@nature.com', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Silvester', '마케팅', '2023-09-28', '2024-04-02', '2024-04-02', 'OFF'),
	('strimmingo@histats.com', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Sib', '영업', '2023-04-24', '2024-04-02', '2024-04-02', 'OFF'),
	('tcaushd@scribd.com', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Tomkin', '영업', '2023-06-15', '2024-04-02', '2024-04-02', 'OFF'),
	('tgavey2f@about.me', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Torey', '마케팅', '2023-11-17', '2024-04-02', '2024-04-02', 'OFF'),
	('thullbrook9@yellowbook.com', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Tymon', '마케팅', '2023-05-08', '2024-04-02', '2024-04-02', 'OFF'),
	('tlomenk@over-blog.com', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Thane', '영업', '2023-10-01', '2024-04-02', '2024-04-02', 'OFF'),
	('tmartins1j@wikia.com', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Trip', '영업', '2024-03-04', '2024-04-02', '2024-04-02', 'OFF'),
	('wplank1o@tumblr.com', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Wolf', '마케팅', '2023-06-06', '2024-04-02', '2024-04-02', 'OFF'),
	('xcullrfordy@phoca.cz', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Xenia', '개발', '2023-09-27', '2024-04-02', '2024-04-02', 'OFF'),
	('zdoniso1d@nationalgeographic.com', 0, '*A4B6157319038724E3560894F7F932C8886EBFCF', 'Zorine', '영업', '2023-07-16', '2024-04-02', '2024-04-02', 'OFF');

-- 테이블 shop.goods 구조 내보내기
CREATE TABLE IF NOT EXISTS `goods` (
  `goods_no` int(11) NOT NULL AUTO_INCREMENT,
  `category` varchar(50) NOT NULL,
  `emp_id` varchar(50) NOT NULL,
  `goods_title` text NOT NULL,
  `filename` text NOT NULL DEFAULT 'default.jpg',
  `goods_content` text NOT NULL,
  `goods_price` int(11) NOT NULL,
  `goods_amount` int(11) NOT NULL,
  `update_date` datetime NOT NULL DEFAULT current_timestamp(),
  `create_date` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`goods_no`),
  KEY `FK_goods_category` (`category`),
  CONSTRAINT `FK_goods_category` FOREIGN KEY (`category`) REFERENCES `category` (`category`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=554 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 shop.goods:~31 rows (대략적) 내보내기
INSERT IGNORE INTO `goods` (`goods_no`, `category`, `emp_id`, `goods_title`, `filename`, `goods_content`, `goods_price`, `goods_amount`, `update_date`, `create_date`) VALUES
	(518, '티니핑(시즌1)', '구디', '시러핑', 'bc02f28d70b54ae6bb36081a9987b1cb.png', '아이들이 좋아하는 캐치티니핑 시즌1 시러핑 피규어 티니핑 입니다.', 8900, 50, '2024-04-08 17:36:05', '2024-04-08 17:36:05'),
	(519, '티니핑(시즌1)', '구디', '그림핑', 'd0bf29403a984ba78ebdefaf33fab94c.png', '아이들이 좋아하는 캐치티니핑 시즌1 그림핑 피규어 티니핑', 8900, 50, '2024-04-08 17:38:34', '2024-04-08 17:38:34'),
	(520, '티니핑(시즌1)', '구디', '홀로핑', '8c86f361fcaf4e4d85e21c4ec6c4c20c.png', '아이들이 좋아하는 캐치티니핑 시즌1 홀로핑 피규어 티니핑\r\n', 8900, 50, '2024-04-08 17:39:08', '2024-04-08 17:39:08'),
	(521, '티니핑(시즌1)', '구디', '노라핑', '26b81d9c558a4ccea91847ffb61b8822.png', '아이들이 좋아하는 캐치티니핑 시즌1 노라핑 피규어 티니핑 입니다', 8900, 50, '2024-04-08 17:43:06', '2024-04-08 17:43:06'),
	(522, '로열 티니핑(시즌2)', '구디', '주네핑', 'e5044920532e42e88ce7430841c1ec5e.png', '아이들이 좋아하는 캐치티니핑 시즌2 주네핑 피규어 티니핑 입니다', 7900, 50, '2024-04-11 09:06:14', '2024-04-11 09:06:14'),
	(523, '로열 티니핑(시즌2)', '구디', '짝짝핑 ', '6996ee610f8e455eafcbb7216e82b0c9.png', '아이들이 좋아하는 캐치티니핑 시즌2 짝짝핑 피규어 티니핑 입니다', 7900, 50, '2024-04-11 09:06:55', '2024-04-11 09:06:55'),
	(524, '로열 티니핑(시즌2)', '구디', '뚝딱핑 ', '3c97aa95b8c84960b44fbc4286108e1f.png', '아이들이 좋아하는 캐치티니핑 시즌2 뚝딱핑 피규어 티니핑 입니다', 7900, 50, '2024-04-11 09:07:39', '2024-04-11 09:07:39'),
	(525, '로열 티니핑(시즌2)', '구디', '싹싹핑', '7b735850814f48cd8c4a416c9acea807.png', '아이들이 좋아하는 캐치티니핑 시즌2 싹싹핑 피규어 티니핑 입니다', 7900, 50, '2024-04-11 09:08:10', '2024-04-11 09:08:10'),
	(526, '로열 티니핑(시즌2)', '구디', '쪼꼼핑 ', 'b87f7664167344138119652ca8c14b72.png', '아이들이 좋아하는 캐치티니핑 시즌2 쪼꼼핑 피규어 티니핑 입니다', 7900, 50, '2024-04-11 09:08:35', '2024-04-11 09:08:35'),
	(527, '로열 티니핑(시즌2)', '구디', '티니핑스쿨', 'ba49b259c00d43cb868e0490db014632.png', '아이들이 좋아하는 캐치티니핑 시즌2 티니핑스쿨 피규어 입니다', 12000, 50, '2024-04-11 09:09:44', '2024-04-11 09:09:44'),
	(528, '로열 티니핑(시즌3)', '구디', '고쳐핑', 'be10ab467e0b48a0ae357709d89bce65.png', '아이들이 좋아하는 캐치티니핑 시즌3 고쳐핑 피규어 티니핑 입니다', 7900, 50, '2024-04-11 09:17:26', '2024-04-11 09:17:26'),
	(529, '로열 티니핑(시즌3)', '구디', '나나핑', '4e0a52459e6e42e7aeb71f4045587b38.png', '아이들이 좋아하는 캐치티니핑 시즌3 나나핑 피규어 티니핑 입니다', 7900, 50, '2024-04-11 09:18:00', '2024-04-11 09:18:00'),
	(530, '로열 티니핑(시즌3)', '구디', '패션핑', '570bd7cea6b643868e999e62e7b64f8e.png', '아이들이 좋아하는 캐치티니핑 시즌3 패션핑 피규어 티니핑 입니다', 7900, 50, '2024-04-11 09:18:31', '2024-04-11 09:18:31'),
	(533, '로열 티니핑(시즌3)', '구디', '뜨거핑', 'aab8b1788f72409aaa70b4fee2c3e5e9.png', '아이들이 좋아하는 캐치티니핑 시즌3 뜨거핑 피규어 티니핑 입니다', 7900, 50, '2024-04-11 09:19:17', '2024-04-11 09:19:17'),
	(534, '로열 티니핑(시즌3)', '구디', '빨리핑', 'faa199f56d444f85bd1a720d6c3633f6.png', '아이들이 좋아하는 캐치티니핑 시즌3 빨리핑 피규어 티니핑 입니다', 7900, 50, '2024-04-11 09:19:40', '2024-04-11 09:19:40'),
	(535, '로열 티니핑(시즌3)', '구디', '얌얌핑', '547a4f871e9d4c9b96c6116e53e707ba.png', '아이들이 좋아하는 캐치티니핑 시즌3 얌얌핑 피규어 티니핑 입니다', 7900, 50, '2024-04-11 09:19:55', '2024-04-11 09:19:55'),
	(536, '로열 티니핑(시즌3)', '구디', '큐티스틱스 큐티리필팩', '85790828deb94a109fa8452e40395feb.png', '아이들이 좋아하는 캐치티니핑 시즌3 큐티스틱스 큐티리필팩 입니다.', 19000, 50, '2024-04-11 09:21:18', '2024-04-11 09:21:18'),
	(537, '로열 티니핑(시즌3)', '구디', '큐티스틱스 하츄핑 컴팩트 악세사리 DIY  세트', 'b79ed47a690f4beb9f6c0d0404a17993.png', ' 아이들이 좋아하는 캐치티니핑 시즌3 큐티스틱스 하츄핑 컴팩트 악세사리 DIY  세트 입니다.', 22000, 50, '2024-04-11 09:21:48', '2024-04-11 09:21:48'),
	(538, '로열 티니핑(시즌3)', '구디', '큐티스틱스 나나핑 컴팩트 악세사리 DIY 세트 ', 'af71e2d62cc641fa8d4ad17de760e297.png', ' 아이들이 좋아하는 캐치티니핑 시즌3 큐티스틱스 나나핑 컴팩트 악세사리 DIY 세트 입니다.', 22000, 50, '2024-04-11 09:22:58', '2024-04-11 09:22:58'),
	(539, '로열 티니핑(시즌4)', '구디', '말랑핑', 'e0215b1f3ff0422695fa79fd24986c75.png', '아이들이 좋아하는 캐치티니핑 시즌4 말랑핑 봉제인형 티니핑 입니다', 20000, 50, '2024-04-11 09:36:43', '2024-04-11 09:36:43'),
	(540, '로열 티니핑(시즌4)', '구디', '포실핑', 'cd6a848c424342768ddc052df1f086e6.png', '아이들이 좋아하는 캐치티니핑 시즌4 포실핑 봉제인형 티니핑 입니다', 20000, 50, '2024-04-11 09:37:40', '2024-04-11 09:37:40'),
	(541, '로열 티니핑(시즌4)', '구디', '샤샤핑', '8e078e2ce46f46c8bd4d121d43e93b91.png', '아이들이 좋아하는 캐치티니핑 시즌4 샤샤핑 봉제인형 티니핑 입니다', 20000, 50, '2024-04-11 09:38:05', '2024-04-11 09:38:05'),
	(542, '로열 티니핑(시즌4)', '구디', '하츄핑', '969787df51cc4b04ba7e07893419dc1c.png', '아이들이 좋아하는 캐치티니핑 시즌4 하츄핑 봉제인형 티니핑 입니다', 20000, 50, '2024-04-11 09:38:27', '2024-04-11 09:38:27'),
	(543, '로열 티니핑(시즌4)', '구디', '눈꽃핑', '75279ea956b34696808edf4f955ef956.png', '아이들이 좋아하는 캐치티니핑 시즌4 눈꽃핑 피규어 티니핑', 13000, 50, '2024-04-11 09:40:14', '2024-04-11 09:40:14'),
	(544, '로열 티니핑(시즌4)', '구디', '쪼꼬핑', 'dbb2ac328f4a42978ab16b26d4025d6e.png', '아이들이 좋아하는 캐치티니핑 시즌4 쪼꼬핑 피규어 티니핑', 13000, 50, '2024-04-11 09:41:16', '2024-04-11 09:41:16'),
	(545, '로열 티니핑(시즌4)', '구디', '커핑머핑', '67c43ab3e39b479fb15187c0aebdd192.png', '아이들이 좋아하는 캐치티니핑 시즌4 커핑머핑 피규어 티니핑', 13000, 50, '2024-04-11 09:42:00', '2024-04-11 09:42:00'),
	(546, '로열 티니핑(시즌4)', '구디', '멜로핑', '0fd57442a22d49aea5aacb6ba9f43535.png', '아이들이 좋아하는 캐치티니핑 시즌4 멜로핑 피규어 티니핑', 13000, 50, '2024-04-11 09:42:23', '2024-04-11 09:42:23'),
	(547, '로열 티니핑(시즌4)', '구디', '요거핑', '60f7c3304e1e4a2691cadb6cf577d90e.png', '아이들이 좋아하는 캐치티니핑 시즌4 요거핑 피규어 티니핑', 13000, 50, '2024-04-11 09:42:43', '2024-04-11 09:42:43'),
	(548, '로열 티니핑(시즌4)', '구디', '캔디핑', '8ae05170c3a645aa9029332b612477a8.png', '아이들이 좋아하는 캐치티니핑 시즌4 캔디핑 피규어 티니핑', 13000, 50, '2024-04-11 09:43:20', '2024-04-11 09:43:20'),
	(549, '로열 티니핑(시즌4)', '구디', '와플핑', '5a5cba47ba234b978246306a473e8165.png', '아이들이 좋아하는 캐치티니핑 시즌4 와플핑 피규어 티니핑', 13000, 50, '2024-04-11 09:44:13', '2024-04-11 09:44:13'),
	(550, '로열 티니핑(시즌4)', '구디', '샌드핑', '5284b84f1a854899a4b2d28d488bb3cc.png', '아이들이 좋아하는 캐치티니핑 시즌4 샌드핑 피규어 티니핑', 13000, 50, '2024-04-11 09:44:31', '2024-04-11 09:44:31'),
	(551, '로열 티니핑(시즌4)', '구디', '마카핑', 'eb1af0877bbb48298a507fcf57889c57.png', '아이들이 좋아하는 캐치티니핑 시즌4 마카핑 피규어 티니핑', 13000, 50, '2024-04-11 09:44:54', '2024-04-11 09:44:54');

-- 테이블 shop.orders 구조 내보내기
CREATE TABLE IF NOT EXISTS `orders` (
  `order_no` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(50) NOT NULL,
  `goods_no` int(11) NOT NULL,
  `goods_title` varchar(50) NOT NULL,
  `price` int(11) NOT NULL,
  `total_amount` int(11) NOT NULL,
  `address` varchar(500) NOT NULL,
  `state` enum('결제대기','결제완료','배송중','배송완료') NOT NULL,
  `comment_state` enum('N','Y') NOT NULL DEFAULT 'N',
  `update_date` datetime NOT NULL,
  `create_date` datetime NOT NULL,
  PRIMARY KEY (`order_no`) USING BTREE,
  KEY `FK_orders_customer` (`email`),
  CONSTRAINT `FK_orders_customer` FOREIGN KEY (`email`) REFERENCES `customer` (`email`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 shop.orders:~35 rows (대략적) 내보내기
INSERT IGNORE INTO `orders` (`order_no`, `email`, `goods_no`, `goods_title`, `price`, `total_amount`, `address`, `state`, `comment_state`, `update_date`, `create_date`) VALUES
	(10, '123123', 550, '샌드핑', 13000, 50, '경기도 시흥', '결제완료', 'N', '2024-04-23 15:49:14', '2024-04-23 15:05:21'),
	(11, '123123', 549, '와플핑', 13000, 50, '경기도 시흥', '결제완료', 'N', '2024-04-23 15:49:14', '2024-04-23 15:05:27'),
	(12, '123123', 550, '샌드핑', 13000, 50, '경기도 시흥', '결제완료', 'N', '2024-04-23 15:49:14', '2024-04-23 15:22:22'),
	(13, '123123', 549, '와플핑', 13000, 50, '경기도 시흥', '결제완료', 'N', '2024-04-23 15:49:14', '2024-04-23 15:46:54'),
	(14, '123123', 551, '마카핑', 13000, 50, '경기도 시흥', '결제완료', 'N', '2024-04-23 15:49:14', '2024-04-23 15:48:36'),
	(15, '123123', 550, '샌드핑', 13000, 50, '이천시', '결제완료', 'N', '2024-04-23 16:11:46', '2024-04-23 15:56:49'),
	(16, '123123', 549, '와플핑', 13000, 50, '이천시', '결제완료', 'N', '2024-04-23 16:11:46', '2024-04-23 15:56:50'),
	(17, '123123', 551, '마카핑', 13000, 50, '우리집', '결제완료', 'N', '2024-04-23 16:15:51', '2024-04-23 16:15:34'),
	(18, '123123', 551, '마카핑', 13000, 50, '우리집', '결제완료', 'N', '2024-04-23 16:15:51', '2024-04-23 16:15:35'),
	(19, '123123', 551, '마카핑', 13000, 50, '우리집', '결제완료', 'N', '2024-04-23 16:15:51', '2024-04-23 16:15:35'),
	(20, '123123', 551, '마카핑', 13000, 49, '우리집', '배송완료', 'N', '2024-04-24 15:49:34', '2024-04-23 16:15:35'),
	(21, '123123', 551, '마카핑', 13000, 49, '우리집', '배송중', 'N', '2024-04-24 15:49:33', '2024-04-23 16:15:38'),
	(22, '123123', 549, '와플핑', 13000, 49, '우리집', '배송완료', 'N', '2024-04-24 15:49:31', '2024-04-23 16:15:40'),
	(23, '123123', 549, '와플핑', 13000, 49, '결제하겠습니다. ', '배송완료', 'Y', '2024-04-24 15:49:26', '2024-04-23 16:17:07'),
	(24, '123123', 551, '마카핑', 13000, 49, '결제하겠습니다. ', '배송중', 'N', '2024-04-24 15:49:19', '2024-04-23 16:17:12'),
	(25, '123123', 519, '그림핑', 8900, 49, '경기도 이천', '배송완료', 'N', '2024-04-25 16:48:36', '2024-04-24 17:03:16'),
	(26, '123123', 549, '와플핑', 13000, 49, '경기도 이천', '배송완료', 'N', '2024-04-25 16:48:33', '2024-04-25 16:47:55'),
	(27, '123123', 549, '와플핑', 13000, 49, '경기도 이천', '배송완료', 'N', '2024-04-25 16:48:32', '2024-04-25 16:47:55'),
	(28, '123123', 549, '와플핑', 13000, 49, '경기도 이천', '배송완료', 'N', '2024-04-25 16:48:31', '2024-04-25 16:47:55'),
	(29, '123123', 549, '와플핑', 13000, 49, '경기도 이천', '배송완료', 'Y', '2024-04-25 16:48:28', '2024-04-25 16:47:55'),
	(30, '123123', 549, '와플핑', 13000, 49, '테스트', '배송완료', 'Y', '2024-04-25 17:17:19', '2024-04-25 16:54:10'),
	(31, '123123', 549, '와플핑', 13000, 49, '집으로 ', '배송완료', 'Y', '2024-04-26 16:21:32', '2024-04-26 16:21:09'),
	(32, '123123', 549, '와플핑', 13000, 49, '집으로 ', '배송완료', 'Y', '2024-04-26 16:21:33', '2024-04-26 16:21:09'),
	(33, '123123', 549, '와플핑', 13000, 49, '집으로 ', '배송완료', 'Y', '2024-04-26 16:21:34', '2024-04-26 16:21:09'),
	(34, '123123', 549, '와플핑', 13000, 49, '집으로 ', '배송완료', 'Y', '2024-04-26 16:21:36', '2024-04-26 16:21:09'),
	(35, '123123', 549, '와플핑', 13000, 49, '집으로 ', '배송완료', 'Y', '2024-04-26 16:21:38', '2024-04-26 16:21:09'),
	(36, '123123', 549, '와플핑', 13000, 49, '집으로 ', '배송완료', 'Y', '2024-04-26 16:21:40', '2024-04-26 16:21:09'),
	(37, '123123', 549, '와플핑', 13000, 49, '집으로 ', '배송완료', 'Y', '2024-04-26 16:21:41', '2024-04-26 16:21:09'),
	(38, '123123', 549, '와플핑', 13000, 49, '집으로 ', '배송완료', 'Y', '2024-04-26 16:21:43', '2024-04-26 16:21:09'),
	(39, '123123', 549, '와플핑', 13000, 49, '집으로 ', '배송완료', 'Y', '2024-04-26 16:21:45', '2024-04-26 16:21:10'),
	(40, '123123', 549, '와플핑', 13000, 49, '집으로 ', '배송완료', 'Y', '2024-04-26 16:25:44', '2024-04-26 16:25:19'),
	(41, '123123', 549, '와플핑', 13000, 49, '집으로 ', '배송완료', 'Y', '2024-04-26 16:25:43', '2024-04-26 16:25:19'),
	(42, '123123', 549, '와플핑', 13000, 49, '집으로 ', '배송완료', 'Y', '2024-04-26 16:25:42', '2024-04-26 16:25:19'),
	(43, '123123', 549, '와플핑', 13000, 49, '집으로 ', '배송완료', 'Y', '2024-04-26 16:25:40', '2024-04-26 16:25:19'),
	(44, '123123', 549, '와플핑', 13000, 50, '입력대기', '결제대기', 'N', '2024-04-30 11:39:42', '2024-04-30 11:39:42');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
