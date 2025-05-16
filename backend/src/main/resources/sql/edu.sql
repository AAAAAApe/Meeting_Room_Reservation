/*
 Navicat Premium Data Transfer

 Source Server         : local
 Source Server Type    : MySQL
 Source Server Version : 80036 (8.0.36)
 Source Host           : localhost:3306
 Source Schema         : edu

 Target Server Type    : MySQL
 Target Server Version : 80036 (8.0.36)
 File Encoding         : 65001

 Date: 17/05/2025 06:30:23
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for cancellation_request
-- ----------------------------
DROP TABLE IF EXISTS `cancellation_request`;
CREATE TABLE `cancellation_request`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `meeting_room_id` int NOT NULL,
  `customer_id` char(9) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `request_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `status` enum('pending','approved','rejected') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'pending',
  `review_time` datetime NULL DEFAULT NULL,
  `refund_amount` decimal(10, 2) NULL DEFAULT NULL,
  `reason` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_cancellation`(`meeting_room_id` ASC, `customer_id` ASC) USING BTREE,
  CONSTRAINT `fk_cancellation` FOREIGN KEY (`meeting_room_id`, `customer_id`) REFERENCES `meetingroom_selection` (`meeting_room_id`, `customer_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cancellation_request
-- ----------------------------

-- ----------------------------
-- Table structure for customer_info
-- ----------------------------
DROP TABLE IF EXISTS `customer_info`;
CREATE TABLE `customer_info`  (
  `user_id` char(9) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `price_per_hour` decimal(4, 1) NOT NULL DEFAULT 0.0,
  PRIMARY KEY (`user_id`) USING BTREE,
  CONSTRAINT `customer_info_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of customer_info
-- ----------------------------
INSERT INTO `customer_info` VALUES ('202520001', 0.0);
INSERT INTO `customer_info` VALUES ('202520002', 0.0);

-- ----------------------------
-- Table structure for employee_info
-- ----------------------------
DROP TABLE IF EXISTS `employee_info`;
CREATE TABLE `employee_info`  (
  `user_id` char(9) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`user_id`) USING BTREE,
  CONSTRAINT `employee_info_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of employee_info
-- ----------------------------
INSERT INTO `employee_info` VALUES ('202510001');
INSERT INTO `employee_info` VALUES ('202510002');

-- ----------------------------
-- Table structure for meetingroom
-- ----------------------------
DROP TABLE IF EXISTS `meetingroom`;
CREATE TABLE `meetingroom`  (
  `meeting_room_id` int NOT NULL AUTO_INCREMENT,
  `meeting_room_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `price_per_hour` decimal(10, 2) NOT NULL,
  `type` enum('classroom','round_table') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `capacity` int NOT NULL COMMENT '当前状态(空闲/锁定/预定/使用中/维护)',
  `status` enum('available','locked','reserved','in_use','maintenance') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'available',
  `has_projector` tinyint(1) NULL DEFAULT 0,
  `has_audio` tinyint(1) NULL DEFAULT 0,
  `has_network` tinyint(1) NULL DEFAULT 0,
  PRIMARY KEY (`meeting_room_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 460 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of meetingroom
-- ----------------------------
INSERT INTO `meetingroom` VALUES (457, '会议室01', 3.00, 'classroom', 20, 'available', 1, 1, 1);
INSERT INTO `meetingroom` VALUES (458, '02', 100.00, 'round_table', 20, 'available', 1, 0, 0);
INSERT INTO `meetingroom` VALUES (459, '03', 60.00, 'round_table', 100, 'available', 0, 0, 1);

-- ----------------------------
-- Table structure for meetingroom_selection
-- ----------------------------
DROP TABLE IF EXISTS `meetingroom_selection`;
CREATE TABLE `meetingroom_selection`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `meeting_room_id` int NOT NULL,
  `customer_id` char(9) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `selection_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `start_time` datetime NOT NULL,
  `end_time` datetime NOT NULL,
  `attendees_count` int NOT NULL DEFAULT 1,
  `status` enum('pending_payment','confirmed','cancelled','completed') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `total_price` decimal(10, 2) NOT NULL,
  `payment_status` enum('unpaid','paid','refunded','partial_refund') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'unpaid',
  `payment_time` datetime NULL DEFAULT NULL,
  `cancellation_time` datetime NULL DEFAULT NULL,
  `refund_amount` decimal(10, 2) NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idx_room_customer_time`(`meeting_room_id` ASC, `customer_id` ASC, `start_time` ASC, `end_time` ASC) USING BTREE,
  INDEX `student_id`(`customer_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of meetingroom_selection
-- ----------------------------
INSERT INTO `meetingroom_selection` VALUES (8, 457, '202520001', '2025-05-17 04:08:09', '2025-05-18 08:00:00', '2025-05-18 09:00:00', 1, 'confirmed', 3.00, 'paid', '2025-05-17 04:10:53', NULL, NULL, '2025-05-17 04:08:09', '2025-05-17 04:08:09');
INSERT INTO `meetingroom_selection` VALUES (9, 457, '202520002', '2025-05-17 04:15:26', '2025-05-18 08:00:00', '2025-05-18 09:00:00', 1, 'confirmed', 3.00, 'paid', '2025-05-17 04:47:22', NULL, NULL, '2025-05-17 04:15:26', '2025-05-17 04:15:26');
INSERT INTO `meetingroom_selection` VALUES (10, 458, '202520002', '2025-05-17 04:16:46', '2025-05-18 08:00:00', '2025-05-18 09:00:00', 1, 'confirmed', 100.00, 'paid', '2025-05-17 04:48:00', NULL, NULL, '2025-05-17 04:16:46', '2025-05-17 04:16:46');
INSERT INTO `meetingroom_selection` VALUES (11, 457, '202520002', '2025-05-17 04:17:01', '2025-05-19 08:00:00', '2025-05-19 21:00:00', 1, 'confirmed', 39.00, 'paid', '2025-05-17 04:47:44', NULL, NULL, '2025-05-17 04:17:01', '2025-05-17 04:17:01');

-- ----------------------------
-- Table structure for refresh_token
-- ----------------------------
DROP TABLE IF EXISTS `refresh_token`;
CREATE TABLE `refresh_token`  (
  `user_id` char(9) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `token` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `expires_at` datetime NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`) USING BTREE,
  UNIQUE INDEX `token`(`token` ASC) USING BTREE,
  CONSTRAINT `refresh_token_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of refresh_token
-- ----------------------------
INSERT INTO `refresh_token` VALUES ('202520002', 'e304f099-6699-44f0-ae90-ea551ec0c4c0', '2025-06-16 06:02:13', '2025-05-17 06:02:13');

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`  (
  `role_id` tinyint NOT NULL,
  `role_name` enum('admin','customer','employee') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`role_id`) USING BTREE,
  UNIQUE INDEX `role_name`(`role_name` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES (0, 'admin');
INSERT INTO `role` VALUES (2, 'customer');
INSERT INTO `role` VALUES (1, 'employee');

-- ----------------------------
-- Table structure for sequence
-- ----------------------------
DROP TABLE IF EXISTS `sequence`;
CREATE TABLE `sequence`  (
  `year` year NOT NULL,
  `role_id` tinyint NOT NULL,
  `current_value` int NOT NULL,
  PRIMARY KEY (`year`, `role_id`) USING BTREE,
  INDEX `role_id`(`role_id` ASC) USING BTREE,
  CONSTRAINT `sequence_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `role` (`role_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sequence
-- ----------------------------
INSERT INTO `sequence` VALUES (2020, 1, 20);
INSERT INTO `sequence` VALUES (2020, 2, 50);
INSERT INTO `sequence` VALUES (2021, 1, 20);
INSERT INTO `sequence` VALUES (2021, 2, 50);
INSERT INTO `sequence` VALUES (2022, 1, 20);
INSERT INTO `sequence` VALUES (2022, 2, 50);
INSERT INTO `sequence` VALUES (2023, 1, 20);
INSERT INTO `sequence` VALUES (2023, 2, 50);
INSERT INTO `sequence` VALUES (2024, 1, 20);
INSERT INTO `sequence` VALUES (2024, 2, 50);
INSERT INTO `sequence` VALUES (2025, 0, 1);
INSERT INTO `sequence` VALUES (2025, 1, 2);
INSERT INTO `sequence` VALUES (2025, 2, 2);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `user_id` char(9) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `encrypted_password` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `role_id` tinyint NOT NULL,
  PRIMARY KEY (`user_id`) USING BTREE,
  INDEX `role_id`(`role_id` ASC) USING BTREE,
  CONSTRAINT `user_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `role` (`role_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('202500001', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 0);
INSERT INTO `user` VALUES ('202510001', '$2a$10$MhZ5pVcM949OjoJrERLzFumhW.pjdXQTtm3Gn4c8kWkNzVPzmnQ7C', 1);
INSERT INTO `user` VALUES ('202510002', '$2a$10$tfhagpI4H7jiwrWRWVxAnO5Am3xsE97ILzsmUmw4lpDYvCEpVemmG', 1);
INSERT INTO `user` VALUES ('202520001', '$2a$10$1tRdGdvdGNzsNcHiNaqTV.bFkf4tlM21k4Z.heB6fleKjFjwvTqFi', 2);
INSERT INTO `user` VALUES ('202520002', '$2a$10$6cDZr7CNDsDThvyviV6Mo.ZtFlEmiR0gesPaLNp20Q2wzLp3CSvKW', 2);

-- ----------------------------
-- Table structure for user_info
-- ----------------------------
DROP TABLE IF EXISTS `user_info`;
CREATE TABLE `user_info`  (
  `user_id` char(9) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `gender` bit(1) NULL DEFAULT NULL,
  `birthday` date NULL DEFAULT NULL,
  `phone_number` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `start_year` year NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`) USING BTREE,
  CONSTRAINT `user_info_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_info
-- ----------------------------
INSERT INTO `user_info` VALUES ('202510001', '刘世康', b'1', '2025-05-17', NULL, NULL, NULL);
INSERT INTO `user_info` VALUES ('202510002', '罗亦可', b'1', '2025-05-23', NULL, NULL, NULL);
INSERT INTO `user_info` VALUES ('202520001', '林志耀', b'1', '2025-05-23', NULL, NULL, NULL);
INSERT INTO `user_info` VALUES ('202520002', '刘伟杰', b'1', '2025-05-08', NULL, NULL, NULL);

-- ----------------------------
-- View structure for v_customer_info
-- ----------------------------
DROP VIEW IF EXISTS `v_customer_info`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_customer_info` AS select `u`.`user_id` AS `user_id`,`ui`.`name` AS `name`,(case when (`ui`.`gender` is null) then NULL when (`ui`.`gender` = 1) then '男' else '女' end) AS `gender`,`ui`.`birthday` AS `birthday`,`ui`.`phone_number` AS `phone_number`,`ui`.`email` AS `email`,`ui`.`start_year` AS `start_year`,`c`.`price_per_hour` AS `price_per_hour` from (((`user` `u` join `role` `r` on((`u`.`role_id` = `r`.`role_id`))) left join `user_info` `ui` on((`u`.`user_id` = `ui`.`user_id`))) left join `customer_info` `c` on((`u`.`user_id` = `c`.`user_id`))) where (`r`.`role_name` = 'customer');

-- ----------------------------
-- View structure for v_employee_info
-- ----------------------------
DROP VIEW IF EXISTS `v_employee_info`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_employee_info` AS select `u`.`user_id` AS `user_id`,`ui`.`name` AS `name`,(case when (`ui`.`gender` is null) then NULL when (`ui`.`gender` = 1) then '男' else '女' end) AS `gender`,`ui`.`birthday` AS `birthday`,`ui`.`phone_number` AS `phone_number`,`ui`.`email` AS `email`,`ui`.`start_year` AS `start_year` from (((`user` `u` join `role` `r` on((`u`.`role_id` = `r`.`role_id`))) left join `user_info` `ui` on((`u`.`user_id` = `ui`.`user_id`))) left join `employee_info` `ei` on((`u`.`user_id` = `ei`.`user_id`))) where (`r`.`role_name` = 'employee');

-- ----------------------------
-- View structure for v_meetingroom_info
-- ----------------------------
DROP VIEW IF EXISTS `v_meetingroom_info`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_meetingroom_info` AS select `mr`.`meeting_room_id` AS `meeting_room_id`,`mr`.`meeting_room_name` AS `meeting_room_name`,`mr`.`price_per_hour` AS `price_per_hour`,`mr`.`capacity` AS `capacity`,`mr`.`type` AS `type`,`mr`.`status` AS `status`,`mr`.`has_projector` AS `has_projector`,`mr`.`has_audio` AS `has_audio`,`mr`.`has_network` AS `has_network` from `meetingroom` `mr`;

-- ----------------------------
-- View structure for v_meetingroom_selection_info
-- ----------------------------
DROP VIEW IF EXISTS `v_meetingroom_selection_info`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_meetingroom_selection_info` AS select `cs`.`meeting_room_id` AS `meeting_room_id`,`mr`.`meeting_room_name` AS `meeting_room_name`,`mr`.`price_per_hour` AS `price_per_hour`,`mr`.`capacity` AS `capacity`,`mr`.`type` AS `type`,`mr`.`status` AS `room_status`,`mr`.`has_projector` AS `has_projector`,`mr`.`has_audio` AS `has_audio`,`mr`.`has_network` AS `has_network`,`cs`.`customer_id` AS `customer_id`,`ui_customer`.`name` AS `customer_name`,`cs`.`selection_time` AS `selection_time`,`cs`.`start_time` AS `start_time`,`cs`.`end_time` AS `end_time`,`cs`.`attendees_count` AS `attendees_count`,`cs`.`status` AS `order_status`,`cs`.`total_price` AS `total_price`,`cs`.`payment_status` AS `payment_status`,`cs`.`payment_time` AS `payment_time`,`cs`.`cancellation_time` AS `cancellation_time`,`cs`.`refund_amount` AS `refund_amount` from ((`meetingroom_selection` `cs` join `meetingroom` `mr` on((`cs`.`meeting_room_id` = `mr`.`meeting_room_id`))) left join `user_info` `ui_customer` on((`cs`.`customer_id` = `ui_customer`.`user_id`)));

-- ----------------------------
-- View structure for v_user_info
-- ----------------------------
DROP VIEW IF EXISTS `v_user_info`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_user_info` AS select `user`.`user_id` AS `user_id`,`role`.`role_name` AS `role_name` from (`user` join `role` on((`user`.`role_id` = `role`.`role_id`)));

SET FOREIGN_KEY_CHECKS = 1;
