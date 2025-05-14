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

 Date: 15/05/2025 05:18:55
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
INSERT INTO `cancellation_request` VALUES (1, 5, '202020001', '2025-05-15 04:28:05', 'pending', NULL, NULL, NULL);
INSERT INTO `cancellation_request` VALUES (2, 1, '202020001', '2025-05-15 05:18:29', 'pending', NULL, NULL, NULL);

-- ----------------------------
-- Table structure for customer_info
-- ----------------------------
DROP TABLE IF EXISTS `customer_info`;
CREATE TABLE `customer_info`  (
  `user_id` char(9) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `major_id` char(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `price_per_hour` decimal(4, 1) NOT NULL DEFAULT 0.0,
  PRIMARY KEY (`user_id`) USING BTREE,
  INDEX `major_id`(`major_id` ASC) USING BTREE,
  CONSTRAINT `customer_info_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `customer_info_ibfk_2` FOREIGN KEY (`major_id`) REFERENCES `major` (`major_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of customer_info
-- ----------------------------
INSERT INTO `customer_info` VALUES ('202020001', '0007', 0.0);
INSERT INTO `customer_info` VALUES ('202020002', '0007', 0.0);
INSERT INTO `customer_info` VALUES ('202020003', '0015', 0.0);
INSERT INTO `customer_info` VALUES ('202020004', '0054', 0.0);
INSERT INTO `customer_info` VALUES ('202020005', '0071', 0.0);
INSERT INTO `customer_info` VALUES ('202020006', '0042', 0.0);
INSERT INTO `customer_info` VALUES ('202020007', '0071', 0.0);
INSERT INTO `customer_info` VALUES ('202020008', '0075', 0.0);
INSERT INTO `customer_info` VALUES ('202020009', '0010', 0.0);
INSERT INTO `customer_info` VALUES ('202020010', '0055', 0.0);
INSERT INTO `customer_info` VALUES ('202020011', '0013', 0.0);
INSERT INTO `customer_info` VALUES ('202020012', '0054', 0.0);
INSERT INTO `customer_info` VALUES ('202020013', '0001', 0.0);
INSERT INTO `customer_info` VALUES ('202020014', '0072', 0.0);
INSERT INTO `customer_info` VALUES ('202020032', '0064', 0.0);
INSERT INTO `customer_info` VALUES ('202020033', '0076', 0.0);
INSERT INTO `customer_info` VALUES ('202020034', '0038', 0.0);

-- ----------------------------
-- Table structure for department
-- ----------------------------
DROP TABLE IF EXISTS `department`;
CREATE TABLE `department`  (
  `department_id` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `department_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`department_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of department
-- ----------------------------
INSERT INTO `department` VALUES ('01', '哲学系');
INSERT INTO `department` VALUES ('02', '经济与金融学院');
INSERT INTO `department` VALUES ('03', '法学院');
INSERT INTO `department` VALUES ('04', '社会学与人类学学院');
INSERT INTO `department` VALUES ('05', '马克思主义学院');
INSERT INTO `department` VALUES ('06', '中国语言文学系');
INSERT INTO `department` VALUES ('07', '外国语学院');
INSERT INTO `department` VALUES ('08', '新闻与传播学院');
INSERT INTO `department` VALUES ('09', '历史系');
INSERT INTO `department` VALUES ('10', '数学与信息学院');
INSERT INTO `department` VALUES ('11', '物理系');
INSERT INTO `department` VALUES ('12', '化学系');
INSERT INTO `department` VALUES ('13', '工程学院');
INSERT INTO `department` VALUES ('14', '计算机学院');
INSERT INTO `department` VALUES ('15', '管理学院');
INSERT INTO `department` VALUES ('16', '医学院');
INSERT INTO `department` VALUES ('17', '艺术学院');

-- ----------------------------
-- Table structure for employee_info
-- ----------------------------
DROP TABLE IF EXISTS `employee_info`;
CREATE TABLE `employee_info`  (
  `user_id` char(9) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `title_id` tinyint NULL DEFAULT NULL,
  `department_id` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`) USING BTREE,
  INDEX `department_id`(`department_id` ASC) USING BTREE,
  INDEX `title_id`(`title_id` ASC) USING BTREE,
  CONSTRAINT `employee_info_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `employee_info_ibfk_2` FOREIGN KEY (`department_id`) REFERENCES `department` (`department_id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `employee_info_ibfk_3` FOREIGN KEY (`title_id`) REFERENCES `title` (`title_id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of employee_info
-- ----------------------------
INSERT INTO `employee_info` VALUES ('202010001', 2, '17');
INSERT INTO `employee_info` VALUES ('202010002', 3, '04');
INSERT INTO `employee_info` VALUES ('202010003', 1, '11');
INSERT INTO `employee_info` VALUES ('202010004', 4, '15');
INSERT INTO `employee_info` VALUES ('202010005', 2, '10');
INSERT INTO `employee_info` VALUES ('202010006', 3, '02');
INSERT INTO `employee_info` VALUES ('202010007', 4, '14');
INSERT INTO `employee_info` VALUES ('202010008', 3, '12');
INSERT INTO `employee_info` VALUES ('202010009', 2, '08');
INSERT INTO `employee_info` VALUES ('202010010', 4, '12');
INSERT INTO `employee_info` VALUES ('202010011', 4, '04');
INSERT INTO `employee_info` VALUES ('202010012', 3, '02');
INSERT INTO `employee_info` VALUES ('202010013', 4, '13');
INSERT INTO `employee_info` VALUES ('202010014', 2, '05');
INSERT INTO `employee_info` VALUES ('202010015', 2, '07');
INSERT INTO `employee_info` VALUES ('202010016', 3, '14');
INSERT INTO `employee_info` VALUES ('202010017', 1, '15');
INSERT INTO `employee_info` VALUES ('202010018', 2, '10');
INSERT INTO `employee_info` VALUES ('202010019', 2, '14');
INSERT INTO `employee_info` VALUES ('202010020', 2, '02');
INSERT INTO `employee_info` VALUES ('202110001', 2, '13');
INSERT INTO `employee_info` VALUES ('202110002', 3, '03');

-- ----------------------------
-- Table structure for major
-- ----------------------------
DROP TABLE IF EXISTS `major`;
CREATE TABLE `major`  (
  `major_id` char(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `major_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `department_id` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`major_id`) USING BTREE,
  INDEX `department_id`(`department_id` ASC) USING BTREE,
  CONSTRAINT `major_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `department` (`department_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of major
-- ----------------------------
INSERT INTO `major` VALUES ('0001', '哲学', '01');
INSERT INTO `major` VALUES ('0002', '逻辑学', '01');
INSERT INTO `major` VALUES ('0003', '宗教学', '01');
INSERT INTO `major` VALUES ('0004', '伦理学', '01');
INSERT INTO `major` VALUES ('0005', '经济学', '02');
INSERT INTO `major` VALUES ('0006', '经济统计学', '02');
INSERT INTO `major` VALUES ('0007', '商务经济学', '02');
INSERT INTO `major` VALUES ('0008', '经济工程', '02');
INSERT INTO `major` VALUES ('0009', '财政学', '02');
INSERT INTO `major` VALUES ('0010', '金融学', '02');
INSERT INTO `major` VALUES ('0011', '金融工程', '02');
INSERT INTO `major` VALUES ('0012', '投资学', '02');
INSERT INTO `major` VALUES ('0013', '法学', '03');
INSERT INTO `major` VALUES ('0014', '知识产权', '03');
INSERT INTO `major` VALUES ('0015', '监狱学', '03');
INSERT INTO `major` VALUES ('0016', '社会学', '04');
INSERT INTO `major` VALUES ('0017', '人类学', '04');
INSERT INTO `major` VALUES ('0018', '社会政策', '04');
INSERT INTO `major` VALUES ('0019', '马克思主义理论', '05');
INSERT INTO `major` VALUES ('0020', '科学社会主义', '05');
INSERT INTO `major` VALUES ('0021', '中国共产党历史', '05');
INSERT INTO `major` VALUES ('0022', '汉语言文学', '06');
INSERT INTO `major` VALUES ('0023', '古典文献学', '06');
INSERT INTO `major` VALUES ('0024', '应用语言学', '06');
INSERT INTO `major` VALUES ('0025', '秘书学', '06');
INSERT INTO `major` VALUES ('0026', '英语', '07');
INSERT INTO `major` VALUES ('0027', '日语', '07');
INSERT INTO `major` VALUES ('0028', '法语', '07');
INSERT INTO `major` VALUES ('0029', '德语', '07');
INSERT INTO `major` VALUES ('0030', '商务英语', '07');
INSERT INTO `major` VALUES ('0031', '翻译', '07');
INSERT INTO `major` VALUES ('0032', '新闻学', '08');
INSERT INTO `major` VALUES ('0033', '传播学', '08');
INSERT INTO `major` VALUES ('0034', '广告学', '08');
INSERT INTO `major` VALUES ('0035', '历史学', '09');
INSERT INTO `major` VALUES ('0036', '世界史', '09');
INSERT INTO `major` VALUES ('0037', '考古学', '09');
INSERT INTO `major` VALUES ('0038', '外国语言与外国历史', '09');
INSERT INTO `major` VALUES ('0039', '文物保护技术', '09');
INSERT INTO `major` VALUES ('0040', '数学', '10');
INSERT INTO `major` VALUES ('0041', '信息与计算科学', '10');
INSERT INTO `major` VALUES ('0042', '统计学', '10');
INSERT INTO `major` VALUES ('0043', '物理学', '11');
INSERT INTO `major` VALUES ('0044', '应用物理学', '11');
INSERT INTO `major` VALUES ('0045', '核物理', '11');
INSERT INTO `major` VALUES ('0046', '量子信息科学', '11');
INSERT INTO `major` VALUES ('0047', '化学', '12');
INSERT INTO `major` VALUES ('0048', '应用化学', '12');
INSERT INTO `major` VALUES ('0049', '化学生物学', '12');
INSERT INTO `major` VALUES ('0050', '机械工程', '13');
INSERT INTO `major` VALUES ('0051', '工程力学', '13');
INSERT INTO `major` VALUES ('0052', '材料科学与工程', '13');
INSERT INTO `major` VALUES ('0053', '电气工程及其自动化', '13');
INSERT INTO `major` VALUES ('0054', '工业设计', '13');
INSERT INTO `major` VALUES ('0055', '计算机科学与技术', '14');
INSERT INTO `major` VALUES ('0056', '软件工程', '14');
INSERT INTO `major` VALUES ('0057', '网络工程', '14');
INSERT INTO `major` VALUES ('0058', '区块链技术', '14');
INSERT INTO `major` VALUES ('0059', '人力资源管理', '15');
INSERT INTO `major` VALUES ('0060', '工商管理', '15');
INSERT INTO `major` VALUES ('0061', '会计学', '15');
INSERT INTO `major` VALUES ('0062', '市场营销', '15');
INSERT INTO `major` VALUES ('0063', '国际商务', '15');
INSERT INTO `major` VALUES ('0064', '公共管理', '15');
INSERT INTO `major` VALUES ('0065', '临床医学', '16');
INSERT INTO `major` VALUES ('0066', '药学', '16');
INSERT INTO `major` VALUES ('0067', '中药学', '16');
INSERT INTO `major` VALUES ('0068', '公共卫生', '16');
INSERT INTO `major` VALUES ('0069', '生物医学工程', '16');
INSERT INTO `major` VALUES ('0070', '美术学', '17');
INSERT INTO `major` VALUES ('0071', '设计学', '17');
INSERT INTO `major` VALUES ('0072', '音乐学', '17');
INSERT INTO `major` VALUES ('0073', '舞蹈学', '17');
INSERT INTO `major` VALUES ('0074', '戏剧学', '17');
INSERT INTO `major` VALUES ('0075', '影视学', '17');
INSERT INTO `major` VALUES ('0076', '摄影学', '17');

-- ----------------------------
-- Table structure for meetingroom
-- ----------------------------
DROP TABLE IF EXISTS `meetingroom`;
CREATE TABLE `meetingroom`  (
  `meeting_room_id` int NOT NULL AUTO_INCREMENT,
  `meeting_room_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `creator_id` char(9) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `department_id` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `price_per_hour` decimal(10, 2) NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `type` enum('classroom','round_table') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `capacity` int NOT NULL COMMENT '当前状态(空闲/锁定/预定/使用中/维护)',
  `status` enum('available','locked','reserved','in_use','maintenance') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'available',
  `has_projector` tinyint(1) NULL DEFAULT 0,
  `has_audio` tinyint(1) NULL DEFAULT 0,
  `has_network` tinyint(1) NULL DEFAULT 0,
  PRIMARY KEY (`meeting_room_id`) USING BTREE,
  INDEX `creator_id`(`creator_id` ASC) USING BTREE,
  INDEX `department_id`(`department_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 457 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of meetingroom
-- ----------------------------
INSERT INTO `meetingroom` VALUES (1, '西方哲学史', '202500001', '01', 3.00, '系统介绍西方哲学从古希腊到现代的发展历程', 'classroom', 100, 'available', 1, 1, 0);
INSERT INTO `meetingroom` VALUES (2, '中国哲学史', '202500001', '01', 3.00, '探讨中国哲学思想从先秦到近代的演变', NULL, 0, 'available', NULL, 0, 0);
INSERT INTO `meetingroom` VALUES (3, '伦理学基础', '202500001', '01', 2.50, '研究道德哲学的基本理论和应用', NULL, 0, 'available', NULL, 0, 0);
INSERT INTO `meetingroom` VALUES (4, '逻辑学', '202500001', '01', 3.00, '学习形式逻辑的基本原理和方法', NULL, 0, 'available', NULL, 0, 0);
INSERT INTO `meetingroom` VALUES (5, '形而上学', '202500001', '01', 3.50, '探讨存在的本质和现实的基本结构', NULL, 0, 'available', NULL, 0, 0);
INSERT INTO `meetingroom` VALUES (6, '认识论', '202500001', '01', 3.00, '研究知识的本质、起源和限度', NULL, 0, 'available', NULL, 0, 0);
INSERT INTO `meetingroom` VALUES (7, '美学原理', '202500001', '01', 2.00, '探讨艺术和美的哲学基础', NULL, 0, 'available', NULL, 0, 0);
INSERT INTO `meetingroom` VALUES (8, '科学哲学', '202500001', '01', 3.00, '分析科学知识的性质和科学方法', NULL, 0, 'available', NULL, 0, 0);
INSERT INTO `meetingroom` VALUES (9, '政治哲学', '202500001', '01', 3.00, '研究政治权力、正义和国家的哲学基础', NULL, 0, 'available', NULL, 0, 0);
INSERT INTO `meetingroom` VALUES (10, '宗教哲学', '202500001', '01', 2.50, '探讨宗教现象和信仰的哲学问题', NULL, 0, 'available', NULL, 0, 0);
INSERT INTO `meetingroom` VALUES (11, '现象学', '202500001', '01', 3.00, '研究意识和经验的本质结构', NULL, 0, 'available', NULL, 0, 0);
INSERT INTO `meetingroom` VALUES (12, '分析哲学', '202500001', '01', 3.00, '探讨语言、思维与实在的关系', NULL, 0, 'available', NULL, 0, 0);
INSERT INTO `meetingroom` VALUES (13, '东方哲学', '202500001', '01', 2.50, '研究印度、日本等东方哲学传统', NULL, 0, 'available', NULL, 0, 0);
INSERT INTO `meetingroom` VALUES (14, '环境哲学', '202500001', '01', 2.00, '探讨人与自然的哲学关系', NULL, 0, 'available', NULL, 0, 0);
INSERT INTO `meetingroom` VALUES (15, '数理逻辑', '202500001', '01', 3.50, '研究形式化逻辑系统和数学基础', NULL, 0, 'available', NULL, 0, 0);
INSERT INTO `meetingroom` VALUES (16, '模态逻辑', '202500001', '01', 3.00, '探讨必然性和可能性的逻辑理论', NULL, 0, 'available', NULL, 0, 0);
INSERT INTO `meetingroom` VALUES (17, '归纳逻辑', '202500001', '01', 2.50, '研究科学推理和概率推断方法', NULL, 0, 'available', NULL, 0, 0);
INSERT INTO `meetingroom` VALUES (18, '逻辑史', '202500001', '01', 2.00, '探讨逻辑学的历史发展', NULL, 0, 'available', NULL, 0, 0);
INSERT INTO `meetingroom` VALUES (19, '比较宗教学', '202500001', '01', 3.00, '比较研究世界主要宗教传统', NULL, 0, 'available', NULL, 0, 0);
INSERT INTO `meetingroom` VALUES (20, '宗教人类学', '202500001', '01', 2.50, '从人类学角度研究宗教现象', NULL, 0, 'available', NULL, 0, 0);
INSERT INTO `meetingroom` VALUES (21, '宗教社会学', '202500001', '01', 2.50, '探讨宗教与社会的互动关系', NULL, 0, 'available', NULL, 0, 0);

-- ----------------------------
-- Table structure for meetingroom_selection
-- ----------------------------
DROP TABLE IF EXISTS `meetingroom_selection`;
CREATE TABLE `meetingroom_selection`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `meeting_room_id` int NOT NULL,
  `customer_id` char(9) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `selection_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `score` decimal(4, 1) NOT NULL,
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
  INDEX `student_id`(`customer_id` ASC) USING BTREE,
  UNIQUE INDEX `idx_room_customer_time`(`meeting_room_id` ASC, `customer_id` ASC, `start_time` ASC, `end_time` ASC) USING BTREE,
  CONSTRAINT `meetingroom_selection_chk_1` CHECK (`score` between 0 and 100)
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of meetingroom_selection
-- ----------------------------
INSERT INTO `meetingroom_selection` VALUES (1, 1, '202020001', '2025-05-14 18:14:04', 0.0, '2025-05-15 08:00:00', '2025-05-15 09:00:00', 1, 'cancelled', 100.00, 'unpaid', NULL, '2025-05-15 02:50:00', NULL, '2025-05-15 02:50:00', '2025-05-15 02:50:00');
INSERT INTO `meetingroom_selection` VALUES (2, 2, '202020001', '2025-05-15 02:21:28', 0.0, '2025-05-16 08:00:00', '2025-05-16 09:00:00', 1, 'cancelled', 100.00, 'unpaid', NULL, '2025-05-15 02:55:00', NULL, '2025-05-15 02:55:00', '2025-05-15 02:55:00');
INSERT INTO `meetingroom_selection` VALUES (3, 6, '202020001', '2025-05-15 03:35:58', 0.0, '2025-05-16 08:00:00', '2025-05-16 09:00:00', 1, 'cancelled', 3.00, 'unpaid', NULL, '2025-05-15 04:10:00', NULL, '2025-05-15 04:10:00', '2025-05-15 04:10:00');
INSERT INTO `meetingroom_selection` VALUES (4, 9, '202020001', '2025-05-15 02:11:47', 0.0, '2025-05-16 08:00:00', '2025-05-16 09:00:00', 1, 'cancelled', 100.00, 'unpaid', NULL, '2025-05-15 02:50:00', NULL, '2025-05-15 02:50:00', '2025-05-15 02:50:00');
INSERT INTO `meetingroom_selection` VALUES (5, 1, '202020001', '2025-05-15 04:00:33', 0.0, '2025-05-16 10:00:00', '2025-05-16 11:00:00', 1, 'cancelled', 3.00, 'unpaid', NULL, '2025-05-15 04:35:00', NULL, '2025-05-15 04:35:00', '2025-05-15 04:35:00');
INSERT INTO `meetingroom_selection` VALUES (6, 5, '202020001', '2025-05-15 04:23:33', 0.0, '2025-05-30 08:00:00', '2025-05-30 09:00:00', 1, 'confirmed', 3.50, 'paid', NULL, NULL, NULL, '2025-05-15 04:51:48', '2025-05-15 04:51:48');
INSERT INTO `meetingroom_selection` VALUES (7, 1, '202020001', '2025-05-15 05:00:39', 0.0, '2025-05-31 08:00:00', '2025-05-31 09:00:00', 1, 'confirmed', 3.00, 'paid', '2025-05-15 05:18:08', NULL, NULL, '2025-05-15 05:00:39', '2025-05-15 05:00:39');

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
INSERT INTO `refresh_token` VALUES ('202020001', '8606621a-81aa-453b-8206-721802659364', '2025-06-14 05:00:30', '2025-05-15 05:00:30');

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

-- ----------------------------
-- Table structure for title
-- ----------------------------
DROP TABLE IF EXISTS `title`;
CREATE TABLE `title`  (
  `title_id` tinyint NOT NULL,
  `title_name` enum('professor','associate_professor','senior_lecturer','lecturer') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`title_id`) USING BTREE,
  UNIQUE INDEX `title_name`(`title_name` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of title
-- ----------------------------
INSERT INTO `title` VALUES (1, 'professor');
INSERT INTO `title` VALUES (2, 'associate_professor');
INSERT INTO `title` VALUES (3, 'senior_lecturer');
INSERT INTO `title` VALUES (4, 'lecturer');

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
INSERT INTO `user` VALUES ('202010001', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202010002', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202010003', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202010004', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202010005', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202010006', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202010007', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202010008', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202010009', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202010010', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202010011', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202010012', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202010013', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202010014', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202010015', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202010016', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202010017', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202010018', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202010019', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202010020', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202020001', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202020002', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202020003', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202020004', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202020005', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202020006', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202020007', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202020008', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202020009', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202020010', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202020011', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202020012', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202020013', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202020014', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202020015', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202020016', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202020017', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202020018', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202020019', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202020020', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202020021', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202020022', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202020023', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202020024', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202020025', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202020026', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202020027', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202020028', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202020029', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202020030', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202020031', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202020032', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202020033', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202020034', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202020035', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202020036', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202020037', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202020038', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202020039', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202020040', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202020041', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202020042', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202020043', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202020044', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202020045', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202020046', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202020047', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202020048', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202020049', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202020050', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202110001', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202110002', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202110003', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202110004', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202110005', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202110006', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202110007', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202110008', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202110009', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202110010', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202110011', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202110012', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202110013', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202110014', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202110015', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202110016', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202110017', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202110018', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202110019', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202110020', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202120001', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202120002', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202120003', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202120004', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202120005', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202120006', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202120007', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202120008', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202120009', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202120010', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202120011', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202120012', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202120013', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202120014', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202120015', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202120016', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202120017', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202120018', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202120019', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202120020', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202120021', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202120022', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202120023', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202120024', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202120025', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202120026', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202120027', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202120028', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202120029', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202120030', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202120031', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202120032', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202120033', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202120034', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202120035', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202120036', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202120037', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202120038', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202120039', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202120040', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202120041', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202120042', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202120043', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202120044', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202120045', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202120046', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202120047', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202120048', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202120049', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202120050', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202210001', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202210002', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202210003', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202210004', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202210005', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202210006', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202210007', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202210008', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202210009', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202210010', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202210011', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202210012', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202210013', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202210014', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202210015', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202210016', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202210017', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202210018', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202210019', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202210020', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202220001', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202220002', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202220003', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202220004', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202220005', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202220006', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202220007', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202220008', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202220009', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202220010', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202220011', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202220012', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202220013', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202220014', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202220015', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202220016', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202220017', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202220018', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202220019', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202220020', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202220021', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202220022', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202220023', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202220024', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202220025', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202220026', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202220027', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202220028', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202220029', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202220030', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202220031', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202220032', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202220033', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202220034', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202220035', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202220036', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202220037', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202220038', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202220039', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202220040', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202220041', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202220042', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202220043', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202220044', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202220045', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202220046', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202220047', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202220048', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202220049', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202220050', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202310001', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202310002', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202310003', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202310004', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202310005', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202310006', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202310007', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202310008', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202310009', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202310010', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202310011', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202310012', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202310013', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202310014', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202310015', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202310016', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202310017', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202310018', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202310019', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202310020', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202320001', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202320002', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202320003', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202320004', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202320005', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202320006', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202320007', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202320008', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202320009', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202320010', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202320011', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202320012', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202320013', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202320014', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202320015', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202320016', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202320017', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202320018', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202320019', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202320020', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202320021', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202320022', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202320023', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202320024', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202320025', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202320026', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202320027', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202320028', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202320029', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202320030', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202320031', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202320032', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202320033', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202320034', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202320035', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202320036', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202320037', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202320038', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202320039', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202320040', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202320041', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202320042', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202320043', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202320044', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202320045', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202320046', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202320047', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202320048', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202320049', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202320050', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202410001', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202410002', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202410003', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202410004', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202410005', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202410006', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202410007', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202410008', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202410009', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202410010', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202410011', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202410012', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202410013', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202410014', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202410015', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202410016', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202410017', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202410018', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202410019', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202410020', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1);
INSERT INTO `user` VALUES ('202420001', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202420002', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202420003', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202420004', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202420005', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202420006', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202420007', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202420008', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202420009', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202420010', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202420011', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202420012', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202420013', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202420014', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202420015', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202420016', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202420017', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202420018', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202420019', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202420020', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202420021', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202420022', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202420023', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202420024', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202420025', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202420026', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202420027', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202420028', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202420029', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202420030', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202420031', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202420032', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202420033', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202420034', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202420035', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202420036', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202420037', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202420038', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202420039', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202420040', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202420041', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202420042', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202420043', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202420044', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202420045', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202420046', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202420047', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202420048', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202420049', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202420050', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);
INSERT INTO `user` VALUES ('202500001', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 0);

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
INSERT INTO `user_info` VALUES ('202010001', '雷军', b'1', '1969-12-16', '13720100406', 'leijun@xiaomi.com', 2020);
INSERT INTO `user_info` VALUES ('202010002', '马化腾', b'1', '1971-10-29', '13720100408', 'pony@tencent.com', 2020);
INSERT INTO `user_info` VALUES ('202010003', '招梓玥', b'0', '1982-02-26', '13720100409', 'zhaoziyue@edu.cn', 2020);
INSERT INTO `user_info` VALUES ('202010004', '函哲新', b'1', '1975-07-18', '13720100410', 'hanzhexin@edu.cn', 2020);
INSERT INTO `user_info` VALUES ('202010005', '书丽芳', b'0', '1980-04-12', '13720100411', 'shulifang@edu.cn', 2020);
INSERT INTO `user_info` VALUES ('202010006', '张志远', b'1', '1985-03-15', '13720100412', 'zhangzhiyuan@edu.cn', 2020);
INSERT INTO `user_info` VALUES ('202010007', '王雅琪', b'0', '1988-06-22', '13720100413', 'wangyaqi@edu.cn', 2020);
INSERT INTO `user_info` VALUES ('202010008', '李天宇', b'1', '1982-09-30', '13720100414', 'litianyu@edu.cn', 2020);
INSERT INTO `user_info` VALUES ('202010009', '陈思颖', b'0', '1987-11-05', '13720100415', 'chensiying@edu.cn', 2020);
INSERT INTO `user_info` VALUES ('202010010', '刘俊杰', b'1', '1984-04-18', '13720100416', 'liujunjie@edu.cn', 2020);
INSERT INTO `user_info` VALUES ('202010011', '赵梦琳', b'0', '1986-07-25', '13720100417', 'zhaomenglin@edu.cn', 2020);
INSERT INTO `user_info` VALUES ('202010012', '杨子轩', b'1', '1983-12-08', '13720100418', 'yangzixuan@edu.cn', 2020);
INSERT INTO `user_info` VALUES ('202010013', '周雨婷', b'0', '1989-02-14', '13720100419', 'zhouyuting@edu.cn', 2020);
INSERT INTO `user_info` VALUES ('202010014', '吴浩然', b'1', '1981-05-20', '13720100420', 'wuhaoran@edu.cn', 2020);
INSERT INTO `user_info` VALUES ('202010015', '孙语嫣', b'0', '1984-08-27', '13720100421', 'sunyuyan@edu.cn', 2020);
INSERT INTO `user_info` VALUES ('202010016', '郑博文', b'1', '1987-01-03', '13720100422', 'zhengbowen@edu.cn', 2020);
INSERT INTO `user_info` VALUES ('202010017', '黄诗雨', b'0', '1982-04-09', '13720100423', 'huangshiyu@edu.cn', 2020);
INSERT INTO `user_info` VALUES ('202010018', '马晨阳', b'1', '1985-07-16', '13720100424', 'machenyang@edu.cn', 2020);
INSERT INTO `user_info` VALUES ('202010019', '朱欣怡', b'0', '1988-10-23', '13720100425', 'zhuxinyi@edu.cn', 2020);
INSERT INTO `user_info` VALUES ('202010020', '胡宇轩', b'1', '1983-01-29', '13720100426', 'huyuxuan@edu.cn', 2020);
INSERT INTO `user_info` VALUES ('202020001', '李晓彤', b'0', '2002-06-10', '13872291900', 'lixiaotong@stu.edu.cn', 2020);
INSERT INTO `user_info` VALUES ('202020002', '王雪梅', b'0', '2002-09-19', '13619891012', 'wangxuemei@stu.edu.cn', 2020);
INSERT INTO `user_info` VALUES ('202020003', '张雅婷', b'0', '2003-03-06', '18667734176', 'zhangyating@stu.edu.cn', 2020);
INSERT INTO `user_info` VALUES ('202020004', '陈思琪', b'0', '2002-06-11', '13286329104', 'chensiqi@stu.edu.cn', 2020);
INSERT INTO `user_info` VALUES ('202020005', '刘子豪', b'1', '2002-05-15', '13912345678', 'liuzihao@stu.edu.cn', 2020);
INSERT INTO `user_info` VALUES ('202020006', '赵雨欣', b'0', '2002-07-23', '13823456789', 'zhaoyuxin@stu.edu.cn', 2020);
INSERT INTO `user_info` VALUES ('202020007', '孙浩然', b'1', '2002-01-30', '13734567890', 'sunhaoran@stu.edu.cn', 2020);
INSERT INTO `user_info` VALUES ('202020008', '周佳怡', b'0', '2002-11-12', '13645678901', 'zhoujiayi@stu.edu.cn', 2020);
INSERT INTO `user_info` VALUES ('202020009', '吴宇航', b'1', '2002-08-05', '13556789012', 'wuyuhang@stu.edu.cn', 2020);
INSERT INTO `user_info` VALUES ('202020010', '郑雨菲', b'0', '2002-04-18', '13467890123', 'zhengyufei@stu.edu.cn', 2020);
INSERT INTO `user_info` VALUES ('202020011', '王博文', b'1', '2002-12-25', '13378901234', 'wangbowen@stu.edu.cn', 2020);
INSERT INTO `user_info` VALUES ('202020012', '李梦瑶', b'0', '2002-02-14', '13289012345', 'limengyao@stu.edu.cn', 2020);
INSERT INTO `user_info` VALUES ('202020013', '张天宇', b'1', '2002-10-08', '13190123456', 'zhangtianyu@stu.edu.cn', 2020);
INSERT INTO `user_info` VALUES ('202020014', '陈雅静', b'0', '2002-06-30', '13901234567', 'chenyajing@stu.edu.cn', 2020);
INSERT INTO `user_info` VALUES ('202020015', '刘志强', b'1', '2002-03-22', '13812345678', 'liuzhiqiang@stu.edu.cn', 2020);
INSERT INTO `user_info` VALUES ('202020016', '王雨晴', b'0', '2002-09-11', '13723456789', 'wangyuqing@stu.edu.cn', 2020);
INSERT INTO `user_info` VALUES ('202020017', '李俊杰', b'1', '2002-07-19', '13634567890', 'lijunjie@stu.edu.cn', 2020);
INSERT INTO `user_info` VALUES ('202020018', '张雪梅', b'0', '2002-01-05', '13545678901', 'zhangxuemei@stu.edu.cn', 2020);
INSERT INTO `user_info` VALUES ('202020019', '陈子轩', b'1', '2002-11-28', '13456789012', 'chenzixuan@stu.edu.cn', 2020);
INSERT INTO `user_info` VALUES ('202020020', '李雅婷', b'0', '2002-04-03', '13367890123', 'liyating@stu.edu.cn', 2020);
INSERT INTO `user_info` VALUES ('202020021', '王天佑', b'1', '2002-08-17', '13278901234', 'wangtianyou@stu.edu.cn', 2020);
INSERT INTO `user_info` VALUES ('202020022', '张雨菲', b'0', '2002-05-29', '13189012345', 'zhangyufei@stu.edu.cn', 2020);
INSERT INTO `user_info` VALUES ('202020023', '李博文', b'1', '2002-02-08', '13890123456', 'libowen@stu.edu.cn', 2020);
INSERT INTO `user_info` VALUES ('202020024', '陈佳怡', b'0', '2002-10-14', '13701234567', 'chenjiayi@stu.edu.cn', 2020);
INSERT INTO `user_info` VALUES ('202020025', '刘宇航', b'1', '2002-12-01', '13612345678', 'liuyuhang@stu.edu.cn', 2020);
INSERT INTO `user_info` VALUES ('202020026', '王梦瑶', b'0', '2002-07-26', '13523456789', 'wangmengyao@stu.edu.cn', 2020);
INSERT INTO `user_info` VALUES ('202020027', '张志强', b'1', '2002-03-13', '13434567890', 'zhangzhiqiang@stu.edu.cn', 2020);
INSERT INTO `user_info` VALUES ('202020028', '李雅静', b'0', '2001-09-30', '13345678901', 'liyajing@stu.edu.cn', 2020);
INSERT INTO `user_info` VALUES ('202020029', '王俊杰', b'1', '2002-06-07', '13256789012', 'wangjunjie@stu.edu.cn', 2020);
INSERT INTO `user_info` VALUES ('202020030', '张雪婷', b'0', '2002-01-24', '13167890123', 'zhangxueting@stu.edu.cn', 2020);
INSERT INTO `user_info` VALUES ('202020031', '陈天佑', b'1', '2001-11-09', '13078901234', 'chentianyou@stu.edu.cn', 2020);
INSERT INTO `user_info` VALUES ('202020032', '李雨菲', b'0', '2002-04-21', '13989012345', 'liyufei@stu.edu.cn', 2020);
INSERT INTO `user_info` VALUES ('202020033', '王子豪', b'1', '2002-08-03', '13890123456', 'wangzihao@stu.edu.cn', 2020);
INSERT INTO `user_info` VALUES ('202020034', '张佳怡', b'0', '2002-05-16', '13701234567', 'zhangjiayi@stu.edu.cn', 2020);
INSERT INTO `user_info` VALUES ('202020035', '李宇航', b'1', '2002-02-27', '13612345678', 'liyuhang@stu.edu.cn', 2020);
INSERT INTO `user_info` VALUES ('202020036', '王雅婷', b'0', '2002-10-10', '13523456789', 'wangyating@stu.edu.cn', 2020);
INSERT INTO `user_info` VALUES ('202020037', '张博文', b'1', '2002-07-02', '13434567890', 'zhangbowen@stu.edu.cn', 2020);
INSERT INTO `user_info` VALUES ('202020038', '李梦瑶', b'0', '2002-03-25', '13345678901', 'limengyao@stu.edu.cn', 2020);
INSERT INTO `user_info` VALUES ('202020039', '王天宇', b'1', '2002-12-18', '13256789012', 'wangtianyu@stu.edu.cn', 2020);
INSERT INTO `user_info` VALUES ('202020040', '陈雨菲', b'0', '2002-09-05', '13167890123', 'chenyufei@stu.edu.cn', 2020);
INSERT INTO `user_info` VALUES ('202020041', '李志强', b'1', '2002-06-22', '13078901234', 'lizhiqiang@stu.edu.cn', 2020);
INSERT INTO `user_info` VALUES ('202020042', '张雅静', b'0', '2002-01-15', '13989012345', 'zhangyajing@stu.edu.cn', 2020);
INSERT INTO `user_info` VALUES ('202020043', '王俊杰', b'1', '2002-08-28', '13890123456', 'wangjunjie@stu.edu.cn', 2020);
INSERT INTO `user_info` VALUES ('202020044', '李佳怡', b'0', '2002-04-11', '13701234567', 'lijiayi@stu.edu.cn', 2020);
INSERT INTO `user_info` VALUES ('202020045', '陈宇航', b'1', '2001-11-24', '13612345678', 'chenyuhang@stu.edu.cn', 2020);
INSERT INTO `user_info` VALUES ('202020046', '王雪梅', b'0', '2002-07-07', '13523456789', 'wangxuemei@stu.edu.cn', 2020);
INSERT INTO `user_info` VALUES ('202020047', '刘明宇', b'1', '2002-03-18', '13434567890', 'liumingyu@stu.edu.cn', 2020);
INSERT INTO `user_info` VALUES ('202020048', '张婷婷', b'0', '2002-10-30', '13345678901', 'zhangtingting@stu.edu.cn', 2020);
INSERT INTO `user_info` VALUES ('202020049', '李浩然', b'1', '2002-05-25', '13256789012', 'lihaoran@stu.edu.cn', 2020);
INSERT INTO `user_info` VALUES ('202020050', '陈梦琪', b'0', '2002-12-15', '13167890123', 'chenmengqi@stu.edu.cn', 2020);
INSERT INTO `user_info` VALUES ('202110001', '林晓明', b'1', '1972-03-15', '13721100406', 'linxiaoming@edu.cn', 2021);
INSERT INTO `user_info` VALUES ('202110002', '陈静怡', b'0', '1983-08-21', '13721100407', 'chenjingyi@edu.cn', 2021);
INSERT INTO `user_info` VALUES ('202110003', '王建国', b'1', '1976-11-30', '13721100408', 'wangjianguo@edu.cn', 2021);
INSERT INTO `user_info` VALUES ('202110004', '张美玲', b'0', '1981-05-25', '13721100409', 'zhangmeiling@edu.cn', 2021);
INSERT INTO `user_info` VALUES ('202110005', '李志强', b'1', '1986-09-14', '13721100410', 'lizhiqiang@edu.cn', 2021);
INSERT INTO `user_info` VALUES ('202110006', '刘雨欣', b'0', '1989-12-03', '13721100411', 'liuyuxin@edu.cn', 2021);
INSERT INTO `user_info` VALUES ('202110007', '赵阳', b'1', '1983-04-18', '13721100412', 'zhaoyang@edu.cn', 2021);
INSERT INTO `user_info` VALUES ('202110008', '孙婷婷', b'0', '1988-07-27', '13721100413', 'suntingting@edu.cn', 2021);
INSERT INTO `user_info` VALUES ('202110009', '吴俊杰', b'1', '1985-01-09', '13721100414', 'wujunjie@edu.cn', 2021);
INSERT INTO `user_info` VALUES ('202110010', '郑丽华', b'0', '1990-06-12', '13721100415', 'zhenglihua@edu.cn', 2021);
INSERT INTO `user_info` VALUES ('202110011', '黄志远', b'1', '1984-10-05', '13721100416', 'huangzhiyuan@edu.cn', 2021);
INSERT INTO `user_info` VALUES ('202110012', '马云燕', b'0', '1987-02-28', '13721100417', 'mayunyan@edu.cn', 2021);
INSERT INTO `user_info` VALUES ('202110013', '朱伟', b'1', '1982-12-17', '13721100418', 'zhuwei@edu.cn', 2021);
INSERT INTO `user_info` VALUES ('202110014', '徐梦琪', b'0', '1991-03-22', '13721100419', 'xumengqi@edu.cn', 2021);
INSERT INTO `user_info` VALUES ('202110015', '胡建华', b'1', '1986-08-11', '13721100420', 'hujianghua@edu.cn', 2021);
INSERT INTO `user_info` VALUES ('202110016', '杨雪', b'0', '1989-11-06', '13721100421', 'yangxue@edu.cn', 2021);
INSERT INTO `user_info` VALUES ('202110017', '周强', b'1', '1984-05-19', '13721100422', 'zhouqiang@edu.cn', 2021);
INSERT INTO `user_info` VALUES ('202110018', '唐玉兰', b'0', '1987-09-24', '13721100423', 'tangyulan@edu.cn', 2021);
INSERT INTO `user_info` VALUES ('202110019', '彭宇', b'1', '1983-01-31', '13721100424', 'pengyu@edu.cn', 2021);
INSERT INTO `user_info` VALUES ('202110020', '韩雅琳', b'0', '1990-07-08', '13721100425', 'hanyalin@edu.cn', 2021);
INSERT INTO `user_info` VALUES ('202120001', '张晨曦', b'1', '2003-01-15', '13900001111', 'zhangchenxi@stu.edu.cn', 2021);
INSERT INTO `user_info` VALUES ('202120002', '王雨晴', b'0', '2003-03-22', '13811112222', 'wangyuqing@stu.edu.cn', 2021);
INSERT INTO `user_info` VALUES ('202120003', '李嘉豪', b'1', '2003-05-10', '13722223333', 'lijiahao@stu.edu.cn', 2021);
INSERT INTO `user_info` VALUES ('202120004', '刘子瑞', b'1', '2003-07-08', '13633334444', 'liuzirui@stu.edu.cn', 2021);
INSERT INTO `user_info` VALUES ('202120005', '陈思颖', b'0', '2003-09-18', '13544445555', 'chensiying@stu.edu.cn', 2021);
INSERT INTO `user_info` VALUES ('202120006', '杨智轩', b'1', '2003-11-30', '13455556666', 'yangzhixuan@stu.edu.cn', 2021);
INSERT INTO `user_info` VALUES ('202120007', '赵雅涵', b'0', '2003-02-27', '13366667777', 'zhaoyahan@stu.edu.cn', 2021);
INSERT INTO `user_info` VALUES ('202120008', '孙浩然', b'1', '2003-04-05', '13277778888', 'sunhaoran@stu.edu.cn', 2021);
INSERT INTO `user_info` VALUES ('202120009', '周依然', b'0', '2003-06-12', '13188889999', 'zhouyiran@stu.edu.cn', 2021);
INSERT INTO `user_info` VALUES ('202120010', '马子豪', b'1', '2003-08-20', '13099990000', 'mazihao@stu.edu.cn', 2021);
INSERT INTO `user_info` VALUES ('202120011', '徐婉婷', b'0', '2003-10-01', '13911112222', 'xuwanting@stu.edu.cn', 2021);
INSERT INTO `user_info` VALUES ('202120012', '郑宇轩', b'1', '2003-12-25', '13822223333', 'zhengyuxuan@stu.edu.cn', 2021);
INSERT INTO `user_info` VALUES ('202120013', '何俊杰', b'1', '2003-01-08', '13733334444', 'hejunjie@stu.edu.cn', 2021);
INSERT INTO `user_info` VALUES ('202120014', '冯若曦', b'0', '2003-03-14', '13644445555', 'fengruoxi@stu.edu.cn', 2021);
INSERT INTO `user_info` VALUES ('202120015', '韩志远', b'1', '2003-05-27', '13555556666', 'hanzhiyuan@stu.edu.cn', 2021);
INSERT INTO `user_info` VALUES ('202120016', '邓语彤', b'0', '2003-07-16', '13466667777', 'dengyutong@stu.edu.cn', 2021);
INSERT INTO `user_info` VALUES ('202120017', '姚梓睿', b'1', '2003-09-03', '13377778888', 'yaozirui@stu.edu.cn', 2021);
INSERT INTO `user_info` VALUES ('202120018', '宋可欣', b'0', '2003-11-22', '13288889999', 'songkexin@stu.edu.cn', 2021);
INSERT INTO `user_info` VALUES ('202120019', '马昊天', b'1', '2003-02-17', '13199990000', 'mahaotian@stu.edu.cn', 2021);
INSERT INTO `user_info` VALUES ('202120020', '罗欣妍', b'0', '2003-04-09', '13000001111', 'luoxinyan@stu.edu.cn', 2021);
INSERT INTO `user_info` VALUES ('202120021', '赵子豪', b'1', '2004-01-12', '13911224455', 'zhaozihao@stu.edu.cn', 2021);
INSERT INTO `user_info` VALUES ('202120022', '孙梦琪', b'0', '2003-10-25', '13822335566', 'sunmengqi@stu.edu.cn', 2021);
INSERT INTO `user_info` VALUES ('202120023', '李昊然', b'1', '2003-05-17', '13733446677', 'lihaoran@stu.edu.cn', 2021);
INSERT INTO `user_info` VALUES ('202120024', '王佳慧', b'0', '2003-07-30', '13644557788', 'wangjiahui@stu.edu.cn', 2021);
INSERT INTO `user_info` VALUES ('202120025', '陈俊杰', b'1', '2003-09-09', '13555668899', 'chenjunjie@stu.edu.cn', 2021);
INSERT INTO `user_info` VALUES ('202120026', '杨欣彤', b'0', '2003-06-05', '13466779900', 'yangxintong@stu.edu.cn', 2021);
INSERT INTO `user_info` VALUES ('202120027', '周志豪', b'1', '2003-04-13', '13377880011', 'zhouzhihao@stu.edu.cn', 2021);
INSERT INTO `user_info` VALUES ('202120028', '马欣悦', b'0', '2003-12-01', '13288991122', 'maxinyue@stu.edu.cn', 2021);
INSERT INTO `user_info` VALUES ('202120029', '徐浩宇', b'1', '2003-02-24', '13199002233', 'xuhaoyu@stu.edu.cn', 2021);
INSERT INTO `user_info` VALUES ('202120030', '罗婉柔', b'0', '2003-08-15', '13000113344', 'luowanrou@stu.edu.cn', 2021);
INSERT INTO `user_info` VALUES ('202120031', '郑天宇', b'1', '2003-03-06', '13922334455', 'zhengtianyu@stu.edu.cn', 2021);
INSERT INTO `user_info` VALUES ('202120032', '何梦瑶', b'0', '2003-07-19', '13833445566', 'hemengyao@stu.edu.cn', 2021);
INSERT INTO `user_info` VALUES ('202120033', '冯子涵', b'1', '2003-11-28', '13744556677', 'fengzihan@stu.edu.cn', 2021);
INSERT INTO `user_info` VALUES ('202120034', '韩诗涵', b'0', '2003-05-22', '13655667788', 'hanshihan@stu.edu.cn', 2021);
INSERT INTO `user_info` VALUES ('202120035', '邓俊豪', b'1', '2003-09-05', '13566778899', 'dengjunhao@stu.edu.cn', 2021);
INSERT INTO `user_info` VALUES ('202120036', '姚紫涵', b'0', '2003-06-30', '13477889900', 'yaozihan@stu.edu.cn', 2021);
INSERT INTO `user_info` VALUES ('202120037', '宋浩然', b'1', '2003-04-25', '13388990011', 'songhaoran@stu.edu.cn', 2021);
INSERT INTO `user_info` VALUES ('202120038', '马婉婷', b'0', '2003-12-12', '13299001122', 'mawanting@stu.edu.cn', 2021);
INSERT INTO `user_info` VALUES ('202120039', '徐明杰', b'1', '2003-02-07', '13100112233', 'xumingjie@stu.edu.cn', 2021);
INSERT INTO `user_info` VALUES ('202120040', '罗佳怡', b'0', '2003-08-09', '13011223344', 'luojiayi@stu.edu.cn', 2021);
INSERT INTO `user_info` VALUES ('202120041', '赵宇航', b'1', '2003-03-11', '13933445566', 'zhaoyuhang@stu.edu.cn', 2021);
INSERT INTO `user_info` VALUES ('202120042', '孙雅婷', b'0', '2003-07-27', '13844556677', 'sunyating@stu.edu.cn', 2021);
INSERT INTO `user_info` VALUES ('202120043', '李志强', b'1', '2002-11-15', '13755667788', 'lizhiqiang@stu.edu.cn', 2021);
INSERT INTO `user_info` VALUES ('202120044', '王梦涵', b'0', '2003-05-18', '13666778899', 'wangmenghan@stu.edu.cn', 2021);
INSERT INTO `user_info` VALUES ('202120045', '陈俊宇', b'1', '2003-09-23', '13577889900', 'chenjunyu@stu.edu.cn', 2021);
INSERT INTO `user_info` VALUES ('202120046', '杨子涵', b'0', '2003-06-14', '13488990011', 'yangzihan@stu.edu.cn', 2021);
INSERT INTO `user_info` VALUES ('202120047', '周浩宇', b'1', '2003-04-29', '13399001122', 'zhouhaoyu@stu.edu.cn', 2021);
INSERT INTO `user_info` VALUES ('202120048', '马欣然', b'0', '2002-12-20', '13200112233', 'maxinran@stu.edu.cn', 2021);
INSERT INTO `user_info` VALUES ('202120049', '徐天宇', b'1', '2003-02-02', '13111223344', 'xutianyu@stu.edu.cn', 2021);
INSERT INTO `user_info` VALUES ('202120050', '罗婉清', b'0', '2003-08-22', '13022334455', 'luowanqing@stu.edu.cn', 2021);
INSERT INTO `user_info` VALUES ('202210001', '刘子轩', b'1', '1973-06-20', '13722100406', 'liuzixuan@edu.cn', 2022);
INSERT INTO `user_info` VALUES ('202210002', '张雨欣', b'0', '1984-11-15', '13722100407', 'zhangyuxin@edu.cn', 2022);
INSERT INTO `user_info` VALUES ('202210003', '王浩宇', b'1', '1977-02-28', '13722100408', 'wanghaoyu@edu.cn', 2022);
INSERT INTO `user_info` VALUES ('202210004', '李梦琪', b'0', '1982-08-09', '13722100409', 'limengqi@edu.cn', 2022);
INSERT INTO `user_info` VALUES ('202210005', '陈思远', b'1', '1987-12-14', '13722100410', 'chensiyuan@edu.cn', 2022);
INSERT INTO `user_info` VALUES ('202210006', '赵语嫣', b'0', '1990-03-25', '13722100411', 'zhaoyuyan@edu.cn', 2022);
INSERT INTO `user_info` VALUES ('202210007', '孙博文', b'1', '1984-07-18', '13722100412', 'sunbowen@edu.cn', 2022);
INSERT INTO `user_info` VALUES ('202210008', '吴诗雨', b'0', '1989-10-27', '13722100413', 'wushiyu@edu.cn', 2022);
INSERT INTO `user_info` VALUES ('202210009', '郑晨阳', b'1', '1986-04-09', '13722100414', 'zhengchenyang@edu.cn', 2022);
INSERT INTO `user_info` VALUES ('202210010', '黄欣怡', b'0', '1991-09-12', '13722100415', 'huangxinyi@edu.cn', 2022);
INSERT INTO `user_info` VALUES ('202210011', '马宇轩', b'1', '1985-01-05', '13722100416', 'mayuxuan@edu.cn', 2022);
INSERT INTO `user_info` VALUES ('202210012', '朱芸萱', b'0', '1988-05-28', '13722100417', 'zhuyunxuan@edu.cn', 2022);
INSERT INTO `user_info` VALUES ('202210013', '徐嘉懿', b'1', '1983-11-17', '13722100418', 'xujiayi@edu.cn', 2022);
INSERT INTO `user_info` VALUES ('202210014', '胡雅馨', b'0', '1992-04-22', '13722100419', 'huyaxin@edu.cn', 2022);
INSERT INTO `user_info` VALUES ('202210015', '杨泽宇', b'1', '1987-08-11', '13722100420', 'yangzeyu@edu.cn', 2022);
INSERT INTO `user_info` VALUES ('202210016', '周雨晴', b'0', '1990-12-06', '13722100421', 'zhouyuqing@edu.cn', 2022);
INSERT INTO `user_info` VALUES ('202210017', '唐子墨', b'1', '1985-06-19', '13722100422', 'tangzimo@edu.cn', 2022);
INSERT INTO `user_info` VALUES ('202210018', '彭语彤', b'0', '1988-10-24', '13722100423', 'pengyutong@edu.cn', 2022);
INSERT INTO `user_info` VALUES ('202210019', '韩昊天', b'1', '1984-02-29', '13722100424', 'hanhaotian@edu.cn', 2022);
INSERT INTO `user_info` VALUES ('202210020', '萧雨桐', b'0', '1991-07-08', '13722100425', 'xiaoyutong@edu.cn', 2022);
INSERT INTO `user_info` VALUES ('202220001', '赵子轩', b'1', '2004-02-10', '13812340987', 'zhaozixuan@stu.edu.cn', 2022);
INSERT INTO `user_info` VALUES ('202220002', '王雅琪', b'0', '2004-06-15', '13698761234', 'wangyaqi@stu.edu.cn', 2022);
INSERT INTO `user_info` VALUES ('202220003', '李浩宇', b'1', '2004-08-23', '13987652345', 'lihaoyu@stu.edu.cn', 2022);
INSERT INTO `user_info` VALUES ('202220004', '陈梦瑶', b'0', '2003-11-05', '13776543456', 'chenmengyao@stu.edu.cn', 2022);
INSERT INTO `user_info` VALUES ('202220005', '孙志强', b'1', '2004-03-30', '13565437890', 'sunzhiqiang@stu.edu.cn', 2022);
INSERT INTO `user_info` VALUES ('202220006', '刘欣怡', b'0', '2004-07-12', '13454326789', 'liuxinyi@stu.edu.cn', 2022);
INSERT INTO `user_info` VALUES ('202220007', '张子豪', b'1', '2004-09-25', '13243215678', 'zhangzihao@stu.edu.cn', 2022);
INSERT INTO `user_info` VALUES ('202220008', '杨若曦', b'0', '2004-12-08', '13032104567', 'yangruoxi@stu.edu.cn', 2022);
INSERT INTO `user_info` VALUES ('202220009', '吴天佑', b'1', '2004-04-17', '13821093456', 'wutianyou@stu.edu.cn', 2022);
INSERT INTO `user_info` VALUES ('202220010', '徐梦琪', b'0', '2004-05-21', '13610982345', 'xumengqi@stu.edu.cn', 2022);
INSERT INTO `user_info` VALUES ('202220011', '赵宇航', b'1', '2004-01-29', '13999871234', 'zhaoyuhang@stu.edu.cn', 2022);
INSERT INTO `user_info` VALUES ('202220012', '周雅婷', b'0', '2004-10-03', '13788762345', 'zhouyating@stu.edu.cn', 2022);
INSERT INTO `user_info` VALUES ('202220013', '胡俊杰', b'1', '2004-06-09', '13577653456', 'hujunjie@stu.edu.cn', 2022);
INSERT INTO `user_info` VALUES ('202220014', '王佳怡', b'0', '2004-03-14', '13466547890', 'wangjiayi@stu.edu.cn', 2022);
INSERT INTO `user_info` VALUES ('202220015', '陈浩然', b'1', '2004-07-27', '13255436789', 'chenhaoran@stu.edu.cn', 2022);
INSERT INTO `user_info` VALUES ('202220016', '李梦雪', b'0', '2004-09-18', '13044325678', 'limengxue@stu.edu.cn', 2022);
INSERT INTO `user_info` VALUES ('202220017', '刘子豪', b'1', '2004-02-24', '13833214567', 'liuzihao@stu.edu.cn', 2022);
INSERT INTO `user_info` VALUES ('202220018', '杨欣然', b'0', '2004-11-06', '13622103456', 'yangxinran@stu.edu.cn', 2022);
INSERT INTO `user_info` VALUES ('202220019', '张宇轩', b'1', '2004-05-09', '13911092345', 'zhangyuxuan@stu.edu.cn', 2022);
INSERT INTO `user_info` VALUES ('202220020', '孙雅静', b'0', '2004-08-30', '13799983456', 'sunyajing@stu.edu.cn', 2022);
INSERT INTO `user_info` VALUES ('202220021', '王博文', b'1', '2004-01-17', '13588874567', 'wangbowen@stu.edu.cn', 2022);
INSERT INTO `user_info` VALUES ('202220022', '赵梦婷', b'0', '2004-04-26', '13477785678', 'zhaomengting@stu.edu.cn', 2022);
INSERT INTO `user_info` VALUES ('202220023', '李志伟', b'1', '2004-10-19', '13266696789', 'lizhiwei@stu.edu.cn', 2022);
INSERT INTO `user_info` VALUES ('202220024', '周子涵', b'0', '2004-07-01', '13055507890', 'zhouzihan@stu.edu.cn', 2022);
INSERT INTO `user_info` VALUES ('202220025', '吴天宇', b'1', '2005-03-05', '13844418901', 'wutianyu@stu.edu.cn', 2022);
INSERT INTO `user_info` VALUES ('202220026', '徐雨晴', b'0', '2004-06-28', '13633329012', 'xuyuqing@stu.edu.cn', 2022);
INSERT INTO `user_info` VALUES ('202220027', '赵浩轩', b'1', '2004-09-11', '13922230123', 'zhaohaoxuan@stu.edu.cn', 2022);
INSERT INTO `user_info` VALUES ('202220028', '杨若彤', b'0', '2004-12-22', '13711141234', 'yangruotong@stu.edu.cn', 2022);
INSERT INTO `user_info` VALUES ('202220029', '刘俊宇', b'1', '2004-05-31', '13500052345', 'liujunyu@stu.edu.cn', 2022);
INSERT INTO `user_info` VALUES ('202220030', '王雪琪', b'0', '2004-08-14', '13488963456', 'wangxueqi@stu.edu.cn', 2022);
INSERT INTO `user_info` VALUES ('202220031', '孙宇航', b'1', '2004-01-22', '13277874567', 'sunyuhang@stu.edu.cn', 2022);
INSERT INTO `user_info` VALUES ('202220032', '张梦瑶', b'0', '2003-11-15', '13066785678', 'zhangmengyao@stu.edu.cn', 2022);
INSERT INTO `user_info` VALUES ('202220033', '李浩然', b'1', '2004-04-02', '13855696789', 'lihaoran@stu.edu.cn', 2022);
INSERT INTO `user_info` VALUES ('202220034', '陈雅婷', b'0', '2004-07-29', '13644507890', 'chenyating@stu.edu.cn', 2022);
INSERT INTO `user_info` VALUES ('202220035', '吴子豪', b'1', '2004-03-08', '13933418901', 'wuzihao@stu.edu.cn', 2022);
INSERT INTO `user_info` VALUES ('202220036', '王雨欣', b'0', '2004-06-18', '13722329012', 'wangyuxin@stu.edu.cn', 2022);
INSERT INTO `user_info` VALUES ('202220037', '赵俊杰', b'1', '2004-09-09', '13511230123', 'zhaojunjie@stu.edu.cn', 2022);
INSERT INTO `user_info` VALUES ('202220038', '杨雅琪', b'0', '2004-12-26', '13488941234', 'yangyaqi@stu.edu.cn', 2022);
INSERT INTO `user_info` VALUES ('202220039', '张天宇', b'1', '2004-05-12', '13277852345', 'zhangtianyu@stu.edu.cn', 2022);
INSERT INTO `user_info` VALUES ('202220040', '李雪梅', b'0', '2004-08-07', '13066763456', 'lixuemei@stu.edu.cn', 2022);
INSERT INTO `user_info` VALUES ('202220041', '孙浩然', b'1', '2004-01-03', '13855674567', 'sunhaoran@stu.edu.cn', 2022);
INSERT INTO `user_info` VALUES ('202220042', '周雅静', b'0', '2004-11-30', '13644585678', 'zhouyajing@stu.edu.cn', 2022);
INSERT INTO `user_info` VALUES ('202220043', '林子涵', b'0', '2004-02-15', '13433496789', 'linzihan@stu.edu.cn', 2022);
INSERT INTO `user_info` VALUES ('202220044', '陈浩宇', b'1', '2004-10-21', '13222307890', 'chenhaoyu@stu.edu.cn', 2022);
INSERT INTO `user_info` VALUES ('202220045', '王梦琪', b'0', '2004-04-28', '13011218901', 'wangmengqi@stu.edu.cn', 2022);
INSERT INTO `user_info` VALUES ('202220046', '张俊豪', b'1', '2004-07-13', '13800129012', 'zhangjunhao@stu.edu.cn', 2022);
INSERT INTO `user_info` VALUES ('202220047', '刘雨欣', b'0', '2004-03-05', '13699030123', 'liuyuxin@stu.edu.cn', 2022);
INSERT INTO `user_info` VALUES ('202220048', '杨天宇', b'1', '2004-12-19', '13588941234', 'yangtianyu@stu.edu.cn', 2022);
INSERT INTO `user_info` VALUES ('202220049', '赵思颖', b'0', '2004-06-24', '13477852345', 'zhaosiying@stu.edu.cn', 2022);
INSERT INTO `user_info` VALUES ('202220050', '吴浩轩', b'1', '2004-09-11', '13366763456', 'wuhaoxuan@stu.edu.cn', 2022);
INSERT INTO `user_info` VALUES ('202310001', '张浩轩', b'1', '1974-09-25', '13723100406', 'zhanghaoxuan@edu.cn', 2023);
INSERT INTO `user_info` VALUES ('202310002', '王梓萱', b'0', '1985-02-18', '13723100407', 'wangzixuan@edu.cn', 2023);
INSERT INTO `user_info` VALUES ('202310003', '李睿哲', b'1', '1978-05-30', '13723100408', 'liruizhe@edu.cn', 2023);
INSERT INTO `user_info` VALUES ('202310004', '陈雨涵', b'0', '1983-11-13', '13723100409', 'chenyuhan@edu.cn', 2023);
INSERT INTO `user_info` VALUES ('202310005', '赵思远', b'1', '1988-03-16', '13723100410', 'zhaosiyuan@edu.cn', 2023);
INSERT INTO `user_info` VALUES ('202310006', '孙雨欣', b'0', '1991-06-27', '13723100411', 'sunyuxin@edu.cn', 2023);
INSERT INTO `user_info` VALUES ('202310007', '吴子轩', b'1', '1985-10-20', '13723100412', 'wuzixuan@edu.cn', 2023);
INSERT INTO `user_info` VALUES ('202310008', '郑梦瑶', b'0', '1990-01-29', '13723100413', 'zhengmengyao@edu.cn', 2023);
INSERT INTO `user_info` VALUES ('202310009', '黄宇航', b'1', '1987-07-11', '13723100414', 'huangyuhang@edu.cn', 2023);
INSERT INTO `user_info` VALUES ('202310010', '马语嫣', b'0', '1992-12-14', '13723100415', 'mayuyan@edu.cn', 2023);
INSERT INTO `user_info` VALUES ('202310011', '朱天宇', b'1', '1986-04-07', '13723100416', 'zhutianyu@edu.cn', 2023);
INSERT INTO `user_info` VALUES ('202310012', '徐诗涵', b'0', '1989-08-30', '13723100417', 'xushihan@edu.cn', 2023);
INSERT INTO `user_info` VALUES ('202310013', '胡博文', b'1', '1984-02-19', '13723100418', 'hubowen@edu.cn', 2023);
INSERT INTO `user_info` VALUES ('202310014', '杨雨晴', b'0', '1993-05-24', '13723100419', 'yangyuqing@edu.cn', 2023);
INSERT INTO `user_info` VALUES ('202310015', '周子墨', b'1', '1988-09-13', '13723100420', 'zhouzimo@edu.cn', 2023);
INSERT INTO `user_info` VALUES ('202310016', '唐梓萱', b'0', '1991-01-08', '13723100421', 'tangzixuan@edu.cn', 2023);
INSERT INTO `user_info` VALUES ('202310017', '彭昊天', b'1', '1986-07-21', '13723100422', 'penghaotian@edu.cn', 2023);
INSERT INTO `user_info` VALUES ('202310018', '韩雨桐', b'0', '1989-11-26', '13723100423', 'hanyutong@edu.cn', 2023);
INSERT INTO `user_info` VALUES ('202310019', '萧子轩', b'1', '1985-03-31', '13723100424', 'xiaozixuan@edu.cn', 2023);
INSERT INTO `user_info` VALUES ('202310020', '柳语嫣', b'0', '1992-08-08', '13723100425', 'liuyuyan@edu.cn', 2023);
INSERT INTO `user_info` VALUES ('202320001', '李嘉欣', b'0', '2005-04-10', '13872345678', 'lijiaxin@stu.edu.cn', 2023);
INSERT INTO `user_info` VALUES ('202320002', '王思聪', b'0', '2005-07-15', '13619876543', 'wangsicong@stu.edu.cn', 2023);
INSERT INTO `user_info` VALUES ('202320003', '张依娜', b'0', '2005-05-09', '18667784567', 'zhangyina@stu.edu.cn', 2023);
INSERT INTO `user_info` VALUES ('202320004', '陈晨曦', b'0', '2005-11-20', '13286327568', 'chenchenxi@stu.edu.cn', 2023);
INSERT INTO `user_info` VALUES ('202320005', '刘凯文', b'1', '2005-03-18', '13912347890', 'liukaiven@stu.edu.cn', 2023);
INSERT INTO `user_info` VALUES ('202320006', '赵凌云', b'0', '2005-09-25', '13823457890', 'zhaolingyun@stu.edu.cn', 2023);
INSERT INTO `user_info` VALUES ('202320007', '孙瑶瑶', b'1', '2005-01-10', '13734568791', 'sunyaoyao@stu.edu.cn', 2023);
INSERT INTO `user_info` VALUES ('202320008', '周紫怡', b'0', '2005-06-13', '13645679801', 'zhouziyi@stu.edu.cn', 2023);
INSERT INTO `user_info` VALUES ('202320009', '吴浩东', b'1', '2005-10-05', '13556789090', 'wuhadong@stu.edu.cn', 2023);
INSERT INTO `user_info` VALUES ('202320010', '郑欣怡', b'0', '2006-02-22', '13467890898', 'zhengxinyi@stu.edu.cn', 2023);
INSERT INTO `user_info` VALUES ('202320011', '王博杰', b'1', '2005-04-30', '13378906543', 'wangbojie@stu.edu.cn', 2023);
INSERT INTO `user_info` VALUES ('202320012', '李思妍', b'0', '2006-01-21', '13289012356', 'lisiya@stu.edu.cn', 2023);
INSERT INTO `user_info` VALUES ('202320013', '张瑾瑜', b'1', '2005-10-11', '13190123654', 'zhangjinyu@stu.edu.cn', 2023);
INSERT INTO `user_info` VALUES ('202320014', '陈羽婷', b'0', '2005-03-27', '13901235790', 'chenyuting@stu.edu.cn', 2023);
INSERT INTO `user_info` VALUES ('202320015', '刘伟杰', b'1', '2005-09-12', '13812347890', 'liuweijie@stu.edu.cn', 2023);
INSERT INTO `user_info` VALUES ('202320016', '王家辉', b'0', '2005-06-01', '13723456765', 'wangjiahui@stu.edu.cn', 2023);
INSERT INTO `user_info` VALUES ('202320017', '李清扬', b'1', '2005-05-22', '13634567891', 'liqingyang@stu.edu.cn', 2023);
INSERT INTO `user_info` VALUES ('202320018', '张秋菊', b'0', '2005-08-14', '13545678012', 'zhangqiujv@stu.edu.cn', 2023);
INSERT INTO `user_info` VALUES ('202320019', '陈怡彤', b'1', '2005-11-07', '13456789021', 'chenyitong@stu.edu.cn', 2023);
INSERT INTO `user_info` VALUES ('202320020', '李沛云', b'0', '2005-07-18', '13367890821', 'lipeiyun@stu.edu.cn', 2023);
INSERT INTO `user_info` VALUES ('202320021', '王晨阳', b'1', '2005-10-29', '13278903456', 'wangchenyang@stu.edu.cn', 2023);
INSERT INTO `user_info` VALUES ('202320022', '张欣如', b'0', '2006-05-01', '13189023456', 'zhangxinru@stu.edu.cn', 2023);
INSERT INTO `user_info` VALUES ('202320023', '李小云', b'1', '2005-09-02', '13890123457', 'lixiaoyun@stu.edu.cn', 2023);
INSERT INTO `user_info` VALUES ('202320024', '陈紫萱', b'0', '2005-08-20', '13701235678', 'chenzixuan@stu.edu.cn', 2023);
INSERT INTO `user_info` VALUES ('202320025', '刘佳宇', b'1', '2005-12-12', '13612347891', 'liujiayu@stu.edu.cn', 2023);
INSERT INTO `user_info` VALUES ('202320026', '王曼婷', b'0', '2005-03-05', '13523457890', 'wangmanting@stu.edu.cn', 2023);
INSERT INTO `user_info` VALUES ('202320027', '张宇超', b'1', '2005-07-17', '13434567891', 'zhangyuchao@stu.edu.cn', 2023);
INSERT INTO `user_info` VALUES ('202320028', '李佳慧', b'0', '2005-12-05', '13345678923', 'lijiahui@stu.edu.cn', 2023);
INSERT INTO `user_info` VALUES ('202320029', '王志伟', b'1', '2005-04-24', '13256789032', 'wangzhiwei@stu.edu.cn', 2023);
INSERT INTO `user_info` VALUES ('202320030', '张洁茹', b'0', '2005-02-06', '13167890125', 'zhangjieru@stu.edu.cn', 2023);
INSERT INTO `user_info` VALUES ('202320031', '陈子豪', b'1', '2005-10-25', '13078903456', 'chenzihao@stu.edu.cn', 2023);
INSERT INTO `user_info` VALUES ('202320032', '李晴天', b'0', '2005-06-23', '13989012347', 'liqingtian@stu.edu.cn', 2023);
INSERT INTO `user_info` VALUES ('202320033', '王荣辉', b'1', '2005-03-02', '13890123567', 'wangronghui@stu.edu.cn', 2023);
INSERT INTO `user_info` VALUES ('202320034', '张丹彤', b'0', '2005-07-22', '13701234988', 'zhangdantong@stu.edu.cn', 2023);
INSERT INTO `user_info` VALUES ('202320035', '李睿智', b'1', '2005-02-09', '13612347891', 'liruzhi@stu.edu.cn', 2023);
INSERT INTO `user_info` VALUES ('202320036', '王飞燕', b'0', '2005-09-17', '13523456701', 'wangfeiyan@stu.edu.cn', 2023);
INSERT INTO `user_info` VALUES ('202320037', '张博文', b'1', '2005-06-05', '13434567894', 'zhangbowen@stu.edu.cn', 2023);
INSERT INTO `user_info` VALUES ('202320038', '李欣怡', b'0', '2005-01-12', '13345678914', 'lixinyi@stu.edu.cn', 2023);
INSERT INTO `user_info` VALUES ('202320039', '王立波', b'1', '2004-12-03', '13256789024', 'wanglibo@stu.edu.cn', 2023);
INSERT INTO `user_info` VALUES ('202320040', '陈彩彤', b'0', '2005-09-08', '13167890876', 'chencaitong@stu.edu.cn', 2023);
INSERT INTO `user_info` VALUES ('202320041', '李志强', b'1', '2005-07-02', '13078906543', 'lizhiqiang@stu.edu.cn', 2023);
INSERT INTO `user_info` VALUES ('202320042', '张雯琪', b'0', '2005-02-12', '13989012356', 'zhangwenqi@stu.edu.cn', 2023);
INSERT INTO `user_info` VALUES ('202320043', '王俊杰', b'1', '2005-08-30', '13890123545', 'wangjunjie@stu.edu.cn', 2023);
INSERT INTO `user_info` VALUES ('202320044', '李佳怡', b'0', '2005-05-21', '13701234567', 'lijiayi@stu.edu.cn', 2023);
INSERT INTO `user_info` VALUES ('202320045', '陈宇轩', b'1', '2004-11-18', '13612347890', 'chenyuxuan@stu.edu.cn', 2023);
INSERT INTO `user_info` VALUES ('202320046', '王子文', b'0', '2005-06-19', '13523456703', 'wangziwen@stu.edu.cn', 2023);
INSERT INTO `user_info` VALUES ('202320047', '刘婷丽', b'1', '2005-01-25', '13434567894', 'liutingli@stu.edu.cn', 2023);
INSERT INTO `user_info` VALUES ('202320048', '张欣琪', b'0', '2005-10-17', '13345678916', 'zhangxinqi@stu.edu.cn', 2023);
INSERT INTO `user_info` VALUES ('202320049', '李昊天', b'1', '2005-11-11', '13256789024', 'lihaotian@stu.edu.cn', 2023);
INSERT INTO `user_info` VALUES ('202320050', '陈宇彤', b'0', '2004-12-29', '13167890889', 'chenyutong@stu.edu.cn', 2023);
INSERT INTO `user_info` VALUES ('202410001', '王子豪', b'1', '1975-12-30', '13724100406', 'wangzihao@edu.cn', 2024);
INSERT INTO `user_info` VALUES ('202410002', '李雨萱', b'0', '1986-05-23', '13724100407', 'liyuxuan@edu.cn', 2024);
INSERT INTO `user_info` VALUES ('202410003', '陈思远', b'1', '1979-08-04', '13724100408', 'chensiyuan@edu.cn', 2024);
INSERT INTO `user_info` VALUES ('202410004', '赵梓涵', b'0', '1984-02-17', '13724100409', 'zhaozihan@edu.cn', 2024);
INSERT INTO `user_info` VALUES ('202410005', '孙浩宇', b'1', '1989-06-20', '13724100410', 'sunhaoyu@edu.cn', 2024);
INSERT INTO `user_info` VALUES ('202410006', '吴雨欣', b'0', '1992-09-29', '13724100411', 'wuyuxin@edu.cn', 2024);
INSERT INTO `user_info` VALUES ('202410007', '郑博文', b'1', '1986-01-22', '13724100412', 'zhengbowen@edu.cn', 2024);
INSERT INTO `user_info` VALUES ('202410008', '黄语嫣', b'0', '1991-04-30', '13724100413', 'huangyuyan@edu.cn', 2024);
INSERT INTO `user_info` VALUES ('202410009', '马天宇', b'1', '1988-10-13', '13724100414', 'matianyu@edu.cn', 2024);
INSERT INTO `user_info` VALUES ('202410010', '朱雨晴', b'0', '1993-03-16', '13724100415', 'zhuyuqing@edu.cn', 2024);
INSERT INTO `user_info` VALUES ('202410011', '徐子墨', b'1', '1987-07-09', '13724100416', 'xuzimo@edu.cn', 2024);
INSERT INTO `user_info` VALUES ('202410012', '胡梓萱', b'0', '1990-11-30', '13724100417', 'huzixuan@edu.cn', 2024);
INSERT INTO `user_info` VALUES ('202410013', '杨昊天', b'1', '1985-05-19', '13724100418', 'yanghaotian@edu.cn', 2024);
INSERT INTO `user_info` VALUES ('202410014', '周雨桐', b'0', '1994-06-24', '13724100419', 'zhouyutong@edu.cn', 2024);
INSERT INTO `user_info` VALUES ('202410015', '唐浩轩', b'1', '1989-12-13', '13724100420', 'tanghaoxuan@edu.cn', 2024);
INSERT INTO `user_info` VALUES ('202410016', '彭语嫣', b'0', '1992-04-08', '13724100421', 'pengyuyan@edu.cn', 2024);
INSERT INTO `user_info` VALUES ('202410017', '韩子轩', b'1', '1987-08-21', '13724100422', 'hanzixuan@edu.cn', 2024);
INSERT INTO `user_info` VALUES ('202410018', '萧雨涵', b'0', '1990-02-26', '13724100423', 'xiaoyuhan@edu.cn', 2024);
INSERT INTO `user_info` VALUES ('202410019', '柳思远', b'1', '1986-06-30', '13724100424', 'liusiyuan@edu.cn', 2024);
INSERT INTO `user_info` VALUES ('202410020', '田梓萱', b'0', '1993-09-08', '13724100425', 'tianzixuan@edu.cn', 2024);
INSERT INTO `user_info` VALUES ('202420001', '李子墨', b'0', '2006-05-16', '13872346781', 'lizimo@stu.edu.cn', 2024);
INSERT INTO `user_info` VALUES ('202420002', '王悦琳', b'0', '2006-03-04', '13619874629', 'wangyuelin@stu.edu.cn', 2024);
INSERT INTO `user_info` VALUES ('202420003', '张佳琪', b'0', '2006-11-11', '18667784123', 'zhangjiaq@stu.edu.cn', 2024);
INSERT INTO `user_info` VALUES ('202420004', '陈思琦', b'0', '2006-07-18', '13286327899', 'chensiqi@stu.edu.cn', 2024);
INSERT INTO `user_info` VALUES ('202420005', '刘宇琪', b'1', '2006-01-03', '13912347822', 'liuyuqi@stu.edu.cn', 2024);
INSERT INTO `user_info` VALUES ('202420006', '赵文君', b'0', '2006-06-28', '13823456722', 'zhaowenjun@stu.edu.cn', 2024);
INSERT INTO `user_info` VALUES ('202420007', '孙浩明', b'1', '2006-08-25', '13734567845', 'sunhaoming@stu.edu.cn', 2024);
INSERT INTO `user_info` VALUES ('202420008', '周瑞雪', b'0', '2006-04-12', '13645678967', 'zhouruixue@stu.edu.cn', 2024);
INSERT INTO `user_info` VALUES ('202420009', '吴佳宇', b'1', '2006-10-13', '13556789089', 'wujiaoyu@stu.edu.cn', 2024);
INSERT INTO `user_info` VALUES ('202420010', '郑悦琪', b'0', '2006-02-27', '13467890834', 'zhengyueqi@stu.edu.cn', 2024);
INSERT INTO `user_info` VALUES ('202420011', '王晓彤', b'1', '2006-06-09', '13378904567', 'wangxiaotong@stu.edu.cn', 2024);
INSERT INTO `user_info` VALUES ('202420012', '李雨琳', b'0', '2006-05-30', '13289012543', 'liylin@stu.edu.cn', 2024);
INSERT INTO `user_info` VALUES ('202420013', '张子涵', b'1', '2006-09-08', '13190123789', 'zhangzihan@stu.edu.cn', 2024);
INSERT INTO `user_info` VALUES ('202420014', '陈欣怡', b'0', '2006-01-17', '13901235987', 'chenxinyi@stu.edu.cn', 2024);
INSERT INTO `user_info` VALUES ('202420015', '刘宇翔', b'1', '2006-08-02', '13812347956', 'liuysxiang@stu.edu.cn', 2024);
INSERT INTO `user_info` VALUES ('202420016', '王晨娜', b'0', '2006-04-23', '13723456781', 'wangchennan@stu.edu.cn', 2024);
INSERT INTO `user_info` VALUES ('202420017', '李心悦', b'1', '2005-11-19', '13634567901', 'lixinyue@stu.edu.cn', 2024);
INSERT INTO `user_info` VALUES ('202420018', '张琪琳', b'0', '2006-02-15', '13545678923', 'zhangqilin@stu.edu.cn', 2024);
INSERT INTO `user_info` VALUES ('202420019', '陈悦彤', b'1', '2006-07-22', '13456789090', 'chenyuetong@stu.edu.cn', 2024);
INSERT INTO `user_info` VALUES ('202420020', '李子涵', b'0', '2006-03-07', '13367890877', 'lizihan@stu.edu.cn', 2024);
INSERT INTO `user_info` VALUES ('202420021', '王韵洁', b'1', '2006-05-12', '13278904568', 'wangyunjie@stu.edu.cn', 2024);
INSERT INTO `user_info` VALUES ('202420022', '张宇婷', b'0', '2006-09-27', '13189012678', 'zhangyuting@stu.edu.cn', 2024);
INSERT INTO `user_info` VALUES ('202420023', '李文琪', b'1', '2006-08-01', '13890123459', 'liwenqi@stu.edu.cn', 2024);
INSERT INTO `user_info` VALUES ('202420024', '陈乐琳', b'0', '2006-11-13', '13701235987', 'chenlelin@stu.edu.cn', 2024);
INSERT INTO `user_info` VALUES ('202420025', '刘浩宇', b'1', '2006-12-10', '13612347982', 'liuhaoyu@stu.edu.cn', 2024);
INSERT INTO `user_info` VALUES ('202420026', '王娅琳', b'0', '2006-06-17', '13523457891', 'wangyalin@stu.edu.cn', 2024);
INSERT INTO `user_info` VALUES ('202420027', '张钰彤', b'1', '2007-01-29', '13434567872', 'zhangyutong@stu.edu.cn', 2024);
INSERT INTO `user_info` VALUES ('202420028', '李欣彤', b'0', '2006-10-21', '13345678901', 'lixintong@stu.edu.cn', 2024);
INSERT INTO `user_info` VALUES ('202420029', '王志文', b'1', '2006-12-03', '13256789059', 'wangzhiwen@stu.edu.cn', 2024);
INSERT INTO `user_info` VALUES ('202420030', '张盈盈', b'0', '2006-05-03', '13167890145', 'zhangyingying@stu.edu.cn', 2024);
INSERT INTO `user_info` VALUES ('202420031', '陈明轩', b'1', '2007-02-01', '13078906529', 'chenmingxuan@stu.edu.cn', 2024);
INSERT INTO `user_info` VALUES ('202420032', '李昕彤', b'0', '2006-07-05', '13989012456', 'lixintong@stu.edu.cn', 2024);
INSERT INTO `user_info` VALUES ('202420033', '王嘉晨', b'1', '2006-03-29', '13890123467', 'wangjiachen@stu.edu.cn', 2024);
INSERT INTO `user_info` VALUES ('202420034', '张艺凡', b'0', '2006-11-10', '13701234987', 'zhangyifan@stu.edu.cn', 2024);
INSERT INTO `user_info` VALUES ('202420035', '李欣彤', b'1', '2006-02-28', '13612347862', 'lixintong@stu.edu.cn', 2024);
INSERT INTO `user_info` VALUES ('202420036', '王伟琪', b'0', '2006-10-06', '13523457894', 'wangweiqi@stu.edu.cn', 2024);
INSERT INTO `user_info` VALUES ('202420037', '张文静', b'1', '2006-06-11', '13434567893', 'zhangwenjing@stu.edu.cn', 2024);
INSERT INTO `user_info` VALUES ('202420038', '李雯彤', b'0', '2006-01-10', '13345678912', 'liwentin@stu.edu.cn', 2024);
INSERT INTO `user_info` VALUES ('202420039', '王可欣', b'1', '2006-09-21', '13256789076', 'wangkexin@stu.edu.cn', 2024);
INSERT INTO `user_info` VALUES ('202420040', '陈家怡', b'0', '2006-04-02', '13167890157', 'chenjiayi@stu.edu.cn', 2024);
INSERT INTO `user_info` VALUES ('202420041', '李婉怡', b'1', '2006-12-24', '13078906540', 'liwany@stu.edu.cn', 2024);
INSERT INTO `user_info` VALUES ('202420042', '张心怡', b'0', '2006-07-03', '13989012478', 'zhangxinyi@stu.edu.cn', 2024);
INSERT INTO `user_info` VALUES ('202420043', '王可欣', b'1', '2006-05-23', '13890123461', 'wangkexin@stu.edu.cn', 2024);
INSERT INTO `user_info` VALUES ('202420044', '李佳怡', b'0', '2006-10-19', '13701235977', 'lijiayi@stu.edu.cn', 2024);
INSERT INTO `user_info` VALUES ('202420045', '陈雪彤', b'1', '2005-11-02', '13612347895', 'chenxuetong@stu.edu.cn', 2024);
INSERT INTO `user_info` VALUES ('202420046', '王艺馨', b'0', '2006-06-26', '13523457897', 'wangyixin@stu.edu.cn', 2024);
INSERT INTO `user_info` VALUES ('202420047', '刘乐天', b'1', '2007-03-21', '13434567878', 'liuletian@stu.edu.cn', 2024);
INSERT INTO `user_info` VALUES ('202420048', '张艺梦', b'0', '2006-09-30', '13345678923', 'zhangyimeng@stu.edu.cn', 2024);
INSERT INTO `user_info` VALUES ('202420049', '李宇婷', b'1', '2006-07-06', '13256789072', 'liuyuting@stu.edu.cn', 2024);
INSERT INTO `user_info` VALUES ('202420050', '陈梦婷', b'0', '2006-12-18', '13167890178', 'chenmengting@stu.edu.cn', 2024);

-- ----------------------------
-- View structure for v_customer_assignment_info
-- ----------------------------
DROP VIEW IF EXISTS `v_customer_assignment_info`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_customer_assignment_info` AS select `a`.`assignment_title` AS `assignment_title`,`a`.`meeting_room_id` AS `meeting_room_id`,`mr`.`meeting_room_name` AS `meeting_room_name`,`a`.`employee_id` AS `employee_id`,`ui_employee`.`name` AS `employee_name`,`ca`.`customer_id` AS `customer_id`,`ui_customer`.`name` AS `customer_name`,`a`.`submission_deadline` AS `submission_deadline`,`a`.`content` AS `assignment_content`,`a`.`submission_url` AS `submission_url`,`ca`.`grade` AS `grade` from ((((`assignment` `a` join `meetingroom` `mr` on((`a`.`meeting_room_id` = `mr`.`meeting_room_id`))) left join `user_info` `ui_employee` on((`a`.`employee_id` = `ui_employee`.`user_id`))) left join `customer_assignment` `ca` on(((`a`.`assignment_title` = `ca`.`assignment_title`) and (`a`.`meeting_room_id` = `ca`.`meeting_room_id`) and (`a`.`employee_id` = `ca`.`employee_id`)))) left join `user_info` `ui_customer` on((`ca`.`customer_id` = `ui_customer`.`user_id`)));

-- ----------------------------
-- View structure for v_customer_info
-- ----------------------------
DROP VIEW IF EXISTS `v_customer_info`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_customer_info` AS select `u`.`user_id` AS `user_id`,`ui`.`name` AS `name`,(case when (`ui`.`gender` is null) then NULL when (`ui`.`gender` = 1) then '男' else '女' end) AS `gender`,`ui`.`birthday` AS `birthday`,`ui`.`phone_number` AS `phone_number`,`ui`.`email` AS `email`,`ui`.`start_year` AS `start_year`,`m`.`major_name` AS `major`,`d`.`department_name` AS `department_name`,`c`.`price_per_hour` AS `price_per_hour` from (((((`user` `u` join `role` `r` on((`u`.`role_id` = `r`.`role_id`))) left join `user_info` `ui` on((`u`.`user_id` = `ui`.`user_id`))) left join `customer_info` `c` on((`u`.`user_id` = `c`.`user_id`))) left join `major` `m` on((`c`.`major_id` = `m`.`major_id`))) left join `department` `d` on((`m`.`department_id` = `d`.`department_id`))) where (`r`.`role_name` = 'customer');

-- ----------------------------
-- View structure for v_employee_info
-- ----------------------------
DROP VIEW IF EXISTS `v_employee_info`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_employee_info` AS select `u`.`user_id` AS `user_id`,`ui`.`name` AS `name`,(case when (`ui`.`gender` is null) then NULL when (`ui`.`gender` = 1) then '男' else '女' end) AS `gender`,`ui`.`birthday` AS `birthday`,`ui`.`phone_number` AS `phone_number`,`ui`.`email` AS `email`,`ui`.`start_year` AS `start_year`,`t`.`title_name` AS `title`,`d`.`department_name` AS `department_name` from (((((`user` `u` join `role` `r` on((`u`.`role_id` = `r`.`role_id`))) left join `user_info` `ui` on((`u`.`user_id` = `ui`.`user_id`))) left join `employee_info` `ei` on((`u`.`user_id` = `ei`.`user_id`))) left join `title` `t` on((`ei`.`title_id` = `t`.`title_id`))) left join `department` `d` on((`ei`.`department_id` = `d`.`department_id`))) where (`r`.`role_name` = 'employee');

-- ----------------------------
-- View structure for v_meetingroom_info
-- ----------------------------
DROP VIEW IF EXISTS `v_meetingroom_info`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_meetingroom_info` AS select `mr`.`meeting_room_id` AS `meeting_room_id`,`mr`.`meeting_room_name` AS `meeting_room_name`,`mr`.`price_per_hour` AS `price_per_hour`,`mr`.`description` AS `description`,`mr`.`capacity` AS `capacity`,`mr`.`type` AS `type`,`mr`.`status` AS `status`,`mr`.`has_projector` AS `has_projector`,`mr`.`has_audio` AS `has_audio`,`mr`.`has_network` AS `has_network`,`mr`.`creator_id` AS `creator_id`,`ui_creator`.`name` AS `creator_name`,`d`.`department_id` AS `department_id`,`d`.`department_name` AS `department_name` from ((`meetingroom` `mr` left join `department` `d` on((`mr`.`department_id` = `d`.`department_id`))) left join `user_info` `ui_creator` on((`mr`.`creator_id` = `ui_creator`.`user_id`)));

-- ----------------------------
-- View structure for v_meetingroom_selection_info
-- ----------------------------
DROP VIEW IF EXISTS `v_meetingroom_selection_info`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_meetingroom_selection_info` AS select `cs`.`meeting_room_id` AS `meeting_room_id`,`mr`.`meeting_room_name` AS `meeting_room_name`,`mr`.`price_per_hour` AS `price_per_hour`,`mr`.`description` AS `description`,`mr`.`capacity` AS `capacity`,`mr`.`type` AS `type`,`mr`.`status` AS `status`,`mr`.`has_projector` AS `has_projector`,`mr`.`has_audio` AS `has_audio`,`mr`.`has_network` AS `has_network`,`cs`.`customer_id` AS `customer_id`,`ui_customer`.`name` AS `customer_name`,`cs`.`selection_time` AS `selection_time`,`cs`.`score` AS `score`,`cs`.`start_time` AS `start_time`,`cs`.`end_time` AS `end_time`,`cs`.`attendees_count` AS `attendees_count`,`cs`.`status` AS `order_status`,`cs`.`total_price` AS `total_price`,`cs`.`payment_status` AS `payment_status`,`cs`.`payment_time` AS `payment_time`,`cs`.`cancellation_time` AS `cancellation_time`,`cs`.`refund_amount` AS `refund_amount`,`d`.`department_name` AS `department_name` from (((`meetingroom_selection` `cs` join `meetingroom` `mr` on((`cs`.`meeting_room_id` = `mr`.`meeting_room_id`))) left join `user_info` `ui_customer` on((`cs`.`customer_id` = `ui_customer`.`user_id`))) left join `department` `d` on((`mr`.`department_id` = `d`.`department_id`)));

-- ----------------------------
-- View structure for v_user_info
-- ----------------------------
DROP VIEW IF EXISTS `v_user_info`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_user_info` AS select `user`.`user_id` AS `user_id`,`role`.`role_name` AS `role_name` from (`user` join `role` on((`user`.`role_id` = `role`.`role_id`)));

SET FOREIGN_KEY_CHECKS = 1;
