/*
 Navicat Premium Data Transfer

 Source Server         : MySQL
 Source Server Type    : MySQL
 Source Server Version : 80300
 Source Host           : localhost:3306
 Source Schema         : sprs

 Target Server Type    : MySQL
 Target Server Version : 80300
 File Encoding         : 65001

 Date: 16/04/2024 18:14:41
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for criteria_list
-- ----------------------------
DROP TABLE IF EXISTS `criteria_list`;
CREATE TABLE `criteria_list`  (
  `c_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  PRIMARY KEY (`c_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_520_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of criteria_list
-- ----------------------------
INSERT INTO `criteria_list` VALUES (1, 'Criteria one', 'bla bla bla');
INSERT INTO `criteria_list` VALUES (2, 'Criteria Two', 'Second Criteria...');
INSERT INTO `criteria_list` VALUES (3, 'Again is number 3  ', 'Regarding updating the criteria_list table:\r\n\r\nThis method (save_criteria_order()) is specifically designed for updating the order_by field based on the order specified in the criteria_id array. It is not intended for updating other fields or performing general updates on the criteria_list table.\r\nIf you need to update other fields or perform different types of updates (e.g., updating the name or description fields), you would need a separate method or modify an existing method accordingly.\r\nIf you need to update fields other than order_by, you might want to create a separate method specifically for updating criteria in the criteria_list table with the necessary functionality to handle those updates.');
INSERT INTO `criteria_list` VALUES (6, 'Edited one. also, prevent SQL injection!', 'No SQL Injection allowed to be submitted...!');
INSERT INTO `criteria_list` VALUES (10, 'THis is pretty new one', 'Newwwwwwwwwwwwwwwww one!');

-- ----------------------------
-- Table structure for grade_ranges
-- ----------------------------
DROP TABLE IF EXISTS `grade_ranges`;
CREATE TABLE `grade_ranges`  (
  `range_id` int NOT NULL AUTO_INCREMENT,
  `criteria_id` int NULL DEFAULT NULL,
  `grade_label` char(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NULL DEFAULT NULL,
  `range_min` int NULL DEFAULT NULL,
  `range_max` int NULL DEFAULT NULL,
  PRIMARY KEY (`range_id`) USING BTREE,
  INDEX `criteria_id`(`criteria_id`) USING BTREE,
  CONSTRAINT `grade_ranges_ibfk_1` FOREIGN KEY (`criteria_id`) REFERENCES `criteria_list` (`c_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_520_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of grade_ranges
-- ----------------------------

-- ----------------------------
-- Table structure for paper_criteria
-- ----------------------------
DROP TABLE IF EXISTS `paper_criteria`;
CREATE TABLE `paper_criteria`  (
  `paper_id` int NOT NULL,
  `criteria_id` int NOT NULL,
  `status` enum('met','not met') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`paper_id`, `criteria_id`) USING BTREE,
  INDEX `paper_criteria_ibfk_2`(`criteria_id`) USING BTREE,
  CONSTRAINT `paper_criteria_ibfk_1` FOREIGN KEY (`paper_id`) REFERENCES `papers` (`paper_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `paper_criteria_ibfk_2` FOREIGN KEY (`criteria_id`) REFERENCES `criteria_list` (`c_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of paper_criteria
-- ----------------------------

-- ----------------------------
-- Table structure for papers
-- ----------------------------
DROP TABLE IF EXISTS `papers`;
CREATE TABLE `papers`  (
  `paper_id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `abstract` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NULL,
  `paperurl` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NULL,
  `key_words` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NULL DEFAULT NULL,
  `share_type` enum('private','public') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NULL DEFAULT NULL,
  `submission_date` datetime NOT NULL,
  `author_id` int NOT NULL,
  `review_deadline` datetime NOT NULL,
  `review_status` enum('In queue','Reviewed') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NULL DEFAULT 'In queue',
  PRIMARY KEY (`paper_id`) USING BTREE,
  INDEX `author_id`(`author_id`) USING BTREE,
  CONSTRAINT `papers_ibfk_1` FOREIGN KEY (`author_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_520_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of papers
-- ----------------------------
INSERT INTO `papers` VALUES (1, 'a review about JBPM', 'this is the abstract', 'null', 'project management', 'public', '2024-04-16 07:09:44', 7, '2024-04-23 07:10:09', 'In queue');

-- ----------------------------
-- Table structure for review_comment
-- ----------------------------
DROP TABLE IF EXISTS `review_comment`;
CREATE TABLE `review_comment`  (
  `commentID` int NOT NULL AUTO_INCREMENT,
  `userID` int NULL DEFAULT NULL,
  `parentCommentID` int NULL DEFAULT NULL,
  `comment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `commentDate` datetime NOT NULL,
  `reviewID` int NOT NULL,
  PRIMARY KEY (`commentID`) USING BTREE,
  INDEX `userID`(`userID`) USING BTREE,
  INDEX `parentCommentID`(`parentCommentID`) USING BTREE,
  INDEX `reviewID`(`reviewID`) USING BTREE,
  CONSTRAINT `review_comment_ibfk_2` FOREIGN KEY (`userID`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `review_comment_ibfk_4` FOREIGN KEY (`reviewID`) REFERENCES `reviews` (`reviewID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `review_comment_ibfk_5` FOREIGN KEY (`parentCommentID`) REFERENCES `review_comment` (`commentID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of review_comment
-- ----------------------------

-- ----------------------------
-- Table structure for review_comment_like
-- ----------------------------
DROP TABLE IF EXISTS `review_comment_like`;
CREATE TABLE `review_comment_like`  (
  `commentID` int NOT NULL,
  `userID` int NOT NULL,
  `likeDate` datetime NOT NULL,
  UNIQUE INDEX `uniq_user_comment_like`(`commentID`, `userID`) USING BTREE,
  INDEX `userID`(`userID`) USING BTREE,
  CONSTRAINT `review_comment_like_ibfk_2` FOREIGN KEY (`userID`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `review_comment_like_ibfk_3` FOREIGN KEY (`commentID`) REFERENCES `review_comment` (`commentID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of review_comment_like
-- ----------------------------

-- ----------------------------
-- Table structure for review_like
-- ----------------------------
DROP TABLE IF EXISTS `review_like`;
CREATE TABLE `review_like`  (
  `reviewid` int NOT NULL,
  `userID` int NOT NULL,
  `likeDate` datetime NULL DEFAULT NULL,
  UNIQUE INDEX `uniq_user_review_like`(`reviewid`, `userID`) USING BTREE,
  INDEX `userID`(`userID`) USING BTREE,
  CONSTRAINT `review_like_ibfk_2` FOREIGN KEY (`userID`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `review_like_ibfk_3` FOREIGN KEY (`reviewid`) REFERENCES `reviews` (`reviewID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of review_like
-- ----------------------------

-- ----------------------------
-- Table structure for review_notification
-- ----------------------------
DROP TABLE IF EXISTS `review_notification`;
CREATE TABLE `review_notification`  (
  `reviewID` int NOT NULL,
  `userID` int NOT NULL,
  `text` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `status` enum('pending','read') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `datetime` datetime NOT NULL,
  UNIQUE INDEX `reviewID`(`reviewID`, `userID`) USING BTREE,
  INDEX `userID`(`userID`) USING BTREE,
  CONSTRAINT `review_notification_ibfk_2` FOREIGN KEY (`userID`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `review_notification_ibfk_3` FOREIGN KEY (`reviewID`) REFERENCES `reviews` (`reviewID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of review_notification
-- ----------------------------

-- ----------------------------
-- Table structure for review_score
-- ----------------------------
DROP TABLE IF EXISTS `review_score`;
CREATE TABLE `review_score`  (
  `reviewID` int NOT NULL,
  `userID` int NOT NULL,
  `score` tinyint NOT NULL,
  `score_date` datetime NOT NULL,
  `total_criteria` int NULL DEFAULT NULL,
  `matched_criteria_count` int NULL DEFAULT NULL,
  UNIQUE INDEX `reviewID`(`reviewID`, `userID`) USING BTREE,
  INDEX `userID`(`userID`) USING BTREE,
  CONSTRAINT `review_score_ibfk_2` FOREIGN KEY (`userID`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `review_score_ibfk_3` FOREIGN KEY (`reviewID`) REFERENCES `reviews` (`reviewID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of review_score
-- ----------------------------

-- ----------------------------
-- Table structure for reviews
-- ----------------------------
DROP TABLE IF EXISTS `reviews`;
CREATE TABLE `reviews`  (
  `reviewID` int NOT NULL AUTO_INCREMENT,
  `reviewerID` int NULL DEFAULT NULL,
  `comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `status` enum('pending','accepted','rejected') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'pending',
  `creationDate` datetime NULL DEFAULT NULL,
  `shareID` int NOT NULL,
  `review_type` enum('anonymus','real') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'real',
  PRIMARY KEY (`reviewID`) USING BTREE,
  UNIQUE INDEX `reviewerID`(`reviewerID`, `shareID`) USING BTREE,
  INDEX `shareID`(`shareID`) USING BTREE,
  CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`reviewerID`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `reviews_ibfk_2` FOREIGN KEY (`shareID`) REFERENCES `shared_paper` (`shareID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reviews
-- ----------------------------

-- ----------------------------
-- Table structure for shared_paper
-- ----------------------------
DROP TABLE IF EXISTS `shared_paper`;
CREATE TABLE `shared_paper`  (
  `shareID` int NOT NULL,
  `paper_id` int NOT NULL,
  `userID` int NULL DEFAULT NULL,
  `authorComment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `shareType` enum('public','private') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`shareID`) USING BTREE,
  UNIQUE INDEX `unique_row`(`paper_id`, `userID`) USING BTREE,
  INDEX `userID`(`userID`) USING BTREE,
  INDEX `paper_id`(`paper_id`) USING BTREE,
  CONSTRAINT `shared_paper_ibfk_2` FOREIGN KEY (`userID`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `shared_paper_ibfk_3` FOREIGN KEY (`paper_id`) REFERENCES `papers` (`paper_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of shared_paper
-- ----------------------------
INSERT INTO `shared_paper` VALUES (1, 1, 7, 'please check it', 'public');

-- ----------------------------
-- Table structure for system_settings
-- ----------------------------
DROP TABLE IF EXISTS `system_settings`;
CREATE TABLE `system_settings`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `email` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `contact` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `address` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `cover_img` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of system_settings
-- ----------------------------
INSERT INTO `system_settings` VALUES (1, 'Student Peer Review System', 'https://www.linkedin.com/in/mjmerzaee', '+6948 8542 623', '2102  Caldwell Road, Rochester, New York, 14608', '');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `firstname` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `lastname` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `email` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `password` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `avatar` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `date_created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` enum('Active','Deactive') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `user_type` tinyint(1) NOT NULL DEFAULT 3,
  `knowledge_areas` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (7, 'Amir', 'Amiri', 'ahmadi@gmail.com', 'ac627ab1ccbdb62ec96e702f07f6425b', NULL, '2024-04-12 19:45:01', 'Active', 3, 'IS and IT, Science and technology');
INSERT INTO `users` VALUES (12, 'Reviewer2', 'of the faculty', 'reviewer2@gmail.com', 'f899139df5e1059396431415e770c6dd', '1713235920_WhatsApp Image 2024-04-16 at 00.57.37_e5b952c8.jpg', '2024-04-13 17:16:21', 'Active', 2, '');
INSERT INTO `users` VALUES (15, 'استاد', ' کشتمند بزرگ', 'admin@admin.com', '21232f297a57a5a743894a0e4a801fc3', '1713087840_n00139960-b.jpg', '2024-04-14 13:48:02', 'Active', 1, 'Administration, Agriculture and something ');
INSERT INTO `users` VALUES (16, 'دکتر جمعه', 'محمدی', 'juma@gmail.com', '38f629170ac3ab74b9d6d2cc411c2f3c', NULL, '2024-04-16 17:03:16', 'Active', 3, '');

-- ----------------------------
-- View structure for paper_review_info
-- ----------------------------
DROP VIEW IF EXISTS `paper_review_info`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `paper_review_info` AS select `p`.`paper_id` AS `paper_id`,`p`.`title` AS `title`,`p`.`review_status` AS `paper_Status`,concat(`u`.`firstname`,' ',`u`.`lastname`) AS `reviewer_name`,concat(`u2`.`firstname`,' ',`u2`.`lastname`) AS `author_name`,`r`.`reviewID` AS `reviewID`,`r`.`status` AS `status`,`rs`.`score` AS `score`,`rs`.`total_criteria` AS `total_criteria`,`rs`.`matched_criteria_count` AS `matched_criteria_count` from (((((`papers` `p` join `shared_paper` `sp` on((`p`.`paper_id` = `sp`.`paper_id`))) left join `reviews` `r` on((`sp`.`shareID` = `r`.`shareID`))) left join `users` `u` on((`r`.`reviewerID` = `u`.`id`))) left join `users` `u2` on((`p`.`author_id` = `u2`.`id`))) left join `review_score` `rs` on((`r`.`reviewID` = `rs`.`reviewID`)));

-- ----------------------------
-- View structure for user_paper_info
-- ----------------------------
DROP VIEW IF EXISTS `user_paper_info`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `user_paper_info` AS select `u`.`id` AS `id`,concat(`u`.`firstname`,' ',`u`.`lastname`) AS `name`,`u`.`user_type` AS `user_type`,`u`.`knowledge_areas` AS `knowledge_areas`,count(distinct `sp`.`paper_id`) AS `papers_shared`,count(distinct `r`.`reviewID`) AS `reviews_made`,sum((case when (`r`.`status` = 'accepted') then 1 else 0 end)) AS `reviews_accepted` from ((`users` `u` left join `shared_paper` `sp` on((`u`.`id` = `sp`.`userID`))) left join `reviews` `r` on((`u`.`id` = `r`.`reviewerID`))) where (`u`.`user_type` in (2,3)) group by `u`.`id`;

SET FOREIGN_KEY_CHECKS = 1;
