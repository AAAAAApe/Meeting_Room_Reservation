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

 Date: 14/05/2025 01:55:58
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for customer_info
-- ----------------------------
DROP TABLE IF EXISTS `customer_info`;
CREATE TABLE `customer_info`  (
  `user_id` char(9) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `major_id` char(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `pricePerHour` decimal(4, 1) NOT NULL DEFAULT 0.0,
  PRIMARY KEY (`user_id`) USING BTREE,
  INDEX `major_id`(`major_id` ASC) USING BTREE,
  CONSTRAINT `customer_info_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `customer_info_ibfk_2` FOREIGN KEY (`major_id`) REFERENCES `major` (`major_id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `customer_info_chk_1` CHECK (`pricePerHour` >= 0)
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
INSERT INTO `customer_info` VALUES ('202020015', '0054', 0.0);
INSERT INTO `customer_info` VALUES ('202020016', '0050', 0.0);
INSERT INTO `customer_info` VALUES ('202020017', '0014', 0.0);
INSERT INTO `customer_info` VALUES ('202020018', '0072', 0.0);
INSERT INTO `customer_info` VALUES ('202020019', '0014', 0.0);
INSERT INTO `customer_info` VALUES ('202020020', '0006', 0.0);
INSERT INTO `customer_info` VALUES ('202020021', '0060', 0.0);
INSERT INTO `customer_info` VALUES ('202020022', '0057', 0.0);
INSERT INTO `customer_info` VALUES ('202020023', '0026', 0.0);
INSERT INTO `customer_info` VALUES ('202020024', '0034', 0.0);
INSERT INTO `customer_info` VALUES ('202020025', '0018', 0.0);
INSERT INTO `customer_info` VALUES ('202020026', '0062', 0.0);
INSERT INTO `customer_info` VALUES ('202020027', '0029', 0.0);
INSERT INTO `customer_info` VALUES ('202020028', '0035', 0.0);
INSERT INTO `customer_info` VALUES ('202020029', '0012', 0.0);
INSERT INTO `customer_info` VALUES ('202020030', '0028', 0.0);
INSERT INTO `customer_info` VALUES ('202020031', '0030', 0.0);
INSERT INTO `customer_info` VALUES ('202020032', '0064', 0.0);
INSERT INTO `customer_info` VALUES ('202020033', '0076', 0.0);
INSERT INTO `customer_info` VALUES ('202020034', '0038', 0.0);
INSERT INTO `customer_info` VALUES ('202020035', '0038', 0.0);
INSERT INTO `customer_info` VALUES ('202020036', '0074', 0.0);
INSERT INTO `customer_info` VALUES ('202020037', '0028', 0.0);
INSERT INTO `customer_info` VALUES ('202020038', '0068', 0.0);
INSERT INTO `customer_info` VALUES ('202020039', '0027', 0.0);
INSERT INTO `customer_info` VALUES ('202020040', '0008', 0.0);
INSERT INTO `customer_info` VALUES ('202020041', '0032', 0.0);
INSERT INTO `customer_info` VALUES ('202020042', '0062', 0.0);
INSERT INTO `customer_info` VALUES ('202020043', '0061', 0.0);
INSERT INTO `customer_info` VALUES ('202020044', '0041', 0.0);
INSERT INTO `customer_info` VALUES ('202020045', '0021', 0.0);
INSERT INTO `customer_info` VALUES ('202020046', '0059', 0.0);
INSERT INTO `customer_info` VALUES ('202020047', '0001', 0.0);
INSERT INTO `customer_info` VALUES ('202020048', '0057', 0.0);
INSERT INTO `customer_info` VALUES ('202020049', '0054', 0.0);
INSERT INTO `customer_info` VALUES ('202020050', '0022', 0.0);
INSERT INTO `customer_info` VALUES ('202120001', '0031', 0.0);
INSERT INTO `customer_info` VALUES ('202120002', '0028', 0.0);
INSERT INTO `customer_info` VALUES ('202120003', '0050', 0.0);
INSERT INTO `customer_info` VALUES ('202120004', '0011', 0.0);
INSERT INTO `customer_info` VALUES ('202120005', '0058', 0.0);
INSERT INTO `customer_info` VALUES ('202120006', '0027', 0.0);
INSERT INTO `customer_info` VALUES ('202120007', '0038', 0.0);
INSERT INTO `customer_info` VALUES ('202120008', '0031', 0.0);
INSERT INTO `customer_info` VALUES ('202120009', '0040', 0.0);
INSERT INTO `customer_info` VALUES ('202120010', '0030', 0.0);
INSERT INTO `customer_info` VALUES ('202120011', '0032', 0.0);
INSERT INTO `customer_info` VALUES ('202120012', '0068', 0.0);
INSERT INTO `customer_info` VALUES ('202120013', '0015', 0.0);
INSERT INTO `customer_info` VALUES ('202120014', '0022', 0.0);
INSERT INTO `customer_info` VALUES ('202120015', '0064', 0.0);
INSERT INTO `customer_info` VALUES ('202120016', '0025', 0.0);
INSERT INTO `customer_info` VALUES ('202120017', '0010', 0.0);
INSERT INTO `customer_info` VALUES ('202120018', '0050', 0.0);
INSERT INTO `customer_info` VALUES ('202120019', '0066', 0.0);
INSERT INTO `customer_info` VALUES ('202120020', '0029', 0.0);
INSERT INTO `customer_info` VALUES ('202120021', '0021', 0.0);
INSERT INTO `customer_info` VALUES ('202120022', '0019', 0.0);
INSERT INTO `customer_info` VALUES ('202120023', '0031', 0.0);
INSERT INTO `customer_info` VALUES ('202120024', '0022', 0.0);
INSERT INTO `customer_info` VALUES ('202120025', '0016', 0.0);
INSERT INTO `customer_info` VALUES ('202120026', '0014', 0.0);
INSERT INTO `customer_info` VALUES ('202120027', '0022', 0.0);
INSERT INTO `customer_info` VALUES ('202120028', '0067', 0.0);
INSERT INTO `customer_info` VALUES ('202120029', '0039', 0.0);
INSERT INTO `customer_info` VALUES ('202120030', '0069', 0.0);
INSERT INTO `customer_info` VALUES ('202120031', '0076', 0.0);
INSERT INTO `customer_info` VALUES ('202120032', '0019', 0.0);
INSERT INTO `customer_info` VALUES ('202120033', '0019', 0.0);
INSERT INTO `customer_info` VALUES ('202120034', '0039', 0.0);
INSERT INTO `customer_info` VALUES ('202120035', '0059', 0.0);
INSERT INTO `customer_info` VALUES ('202120036', '0027', 0.0);
INSERT INTO `customer_info` VALUES ('202120037', '0032', 0.0);
INSERT INTO `customer_info` VALUES ('202120038', '0003', 0.0);
INSERT INTO `customer_info` VALUES ('202120039', '0072', 0.0);
INSERT INTO `customer_info` VALUES ('202120040', '0044', 0.0);
INSERT INTO `customer_info` VALUES ('202120041', '0006', 0.0);
INSERT INTO `customer_info` VALUES ('202120042', '0050', 0.0);
INSERT INTO `customer_info` VALUES ('202120043', '0001', 0.0);
INSERT INTO `customer_info` VALUES ('202120044', '0007', 0.0);
INSERT INTO `customer_info` VALUES ('202120045', '0033', 0.0);
INSERT INTO `customer_info` VALUES ('202120046', '0066', 0.0);
INSERT INTO `customer_info` VALUES ('202120047', '0001', 0.0);
INSERT INTO `customer_info` VALUES ('202120048', '0037', 0.0);
INSERT INTO `customer_info` VALUES ('202120049', '0030', 0.0);
INSERT INTO `customer_info` VALUES ('202120050', '0036', 0.0);
INSERT INTO `customer_info` VALUES ('202220001', '0042', 0.0);
INSERT INTO `customer_info` VALUES ('202220002', '0044', 0.0);
INSERT INTO `customer_info` VALUES ('202220003', '0016', 0.0);
INSERT INTO `customer_info` VALUES ('202220004', '0026', 0.0);
INSERT INTO `customer_info` VALUES ('202220005', '0005', 0.0);
INSERT INTO `customer_info` VALUES ('202220006', '0023', 0.0);
INSERT INTO `customer_info` VALUES ('202220007', '0023', 0.0);
INSERT INTO `customer_info` VALUES ('202220008', '0046', 0.0);
INSERT INTO `customer_info` VALUES ('202220009', '0007', 0.0);
INSERT INTO `customer_info` VALUES ('202220010', '0049', 0.0);
INSERT INTO `customer_info` VALUES ('202220011', '0073', 0.0);
INSERT INTO `customer_info` VALUES ('202220012', '0066', 0.0);
INSERT INTO `customer_info` VALUES ('202220013', '0032', 0.0);
INSERT INTO `customer_info` VALUES ('202220014', '0036', 0.0);
INSERT INTO `customer_info` VALUES ('202220015', '0011', 0.0);
INSERT INTO `customer_info` VALUES ('202220016', '0022', 0.0);
INSERT INTO `customer_info` VALUES ('202220017', '0001', 0.0);
INSERT INTO `customer_info` VALUES ('202220018', '0016', 0.0);
INSERT INTO `customer_info` VALUES ('202220019', '0074', 0.0);
INSERT INTO `customer_info` VALUES ('202220020', '0019', 0.0);
INSERT INTO `customer_info` VALUES ('202220021', '0026', 0.0);
INSERT INTO `customer_info` VALUES ('202220022', '0071', 0.0);
INSERT INTO `customer_info` VALUES ('202220023', '0047', 0.0);
INSERT INTO `customer_info` VALUES ('202220024', '0020', 0.0);
INSERT INTO `customer_info` VALUES ('202220025', '0038', 0.0);
INSERT INTO `customer_info` VALUES ('202220026', '0053', 0.0);
INSERT INTO `customer_info` VALUES ('202220027', '0074', 0.0);
INSERT INTO `customer_info` VALUES ('202220028', '0059', 0.0);
INSERT INTO `customer_info` VALUES ('202220029', '0073', 0.0);
INSERT INTO `customer_info` VALUES ('202220030', '0036', 0.0);
INSERT INTO `customer_info` VALUES ('202220031', '0035', 0.0);
INSERT INTO `customer_info` VALUES ('202220032', '0069', 0.0);
INSERT INTO `customer_info` VALUES ('202220033', '0010', 0.0);
INSERT INTO `customer_info` VALUES ('202220034', '0071', 0.0);
INSERT INTO `customer_info` VALUES ('202220035', '0019', 0.0);
INSERT INTO `customer_info` VALUES ('202220036', '0034', 0.0);
INSERT INTO `customer_info` VALUES ('202220037', '0036', 0.0);
INSERT INTO `customer_info` VALUES ('202220038', '0003', 0.0);
INSERT INTO `customer_info` VALUES ('202220039', '0059', 0.0);
INSERT INTO `customer_info` VALUES ('202220040', '0056', 0.0);
INSERT INTO `customer_info` VALUES ('202220041', '0025', 0.0);
INSERT INTO `customer_info` VALUES ('202220042', '0034', 0.0);
INSERT INTO `customer_info` VALUES ('202220043', '0020', 0.0);
INSERT INTO `customer_info` VALUES ('202220044', '0074', 0.0);
INSERT INTO `customer_info` VALUES ('202220045', '0006', 0.0);
INSERT INTO `customer_info` VALUES ('202220046', '0034', 0.0);
INSERT INTO `customer_info` VALUES ('202220047', '0074', 0.0);
INSERT INTO `customer_info` VALUES ('202220048', '0041', 0.0);
INSERT INTO `customer_info` VALUES ('202220049', '0058', 0.0);
INSERT INTO `customer_info` VALUES ('202220050', '0013', 0.0);
INSERT INTO `customer_info` VALUES ('202320001', '0005', 0.0);
INSERT INTO `customer_info` VALUES ('202320002', '0062', 0.0);
INSERT INTO `customer_info` VALUES ('202320003', '0067', 0.0);
INSERT INTO `customer_info` VALUES ('202320004', '0075', 0.0);
INSERT INTO `customer_info` VALUES ('202320005', '0020', 0.0);
INSERT INTO `customer_info` VALUES ('202320006', '0025', 0.0);
INSERT INTO `customer_info` VALUES ('202320007', '0065', 0.0);
INSERT INTO `customer_info` VALUES ('202320008', '0023', 0.0);
INSERT INTO `customer_info` VALUES ('202320009', '0069', 0.0);
INSERT INTO `customer_info` VALUES ('202320010', '0049', 0.0);
INSERT INTO `customer_info` VALUES ('202320011', '0039', 0.0);
INSERT INTO `customer_info` VALUES ('202320012', '0048', 0.0);
INSERT INTO `customer_info` VALUES ('202320013', '0045', 0.0);
INSERT INTO `customer_info` VALUES ('202320014', '0004', 0.0);
INSERT INTO `customer_info` VALUES ('202320015', '0039', 0.0);
INSERT INTO `customer_info` VALUES ('202320016', '0029', 0.0);
INSERT INTO `customer_info` VALUES ('202320017', '0028', 0.0);
INSERT INTO `customer_info` VALUES ('202320018', '0054', 0.0);
INSERT INTO `customer_info` VALUES ('202320019', '0033', 0.0);
INSERT INTO `customer_info` VALUES ('202320020', '0002', 0.0);
INSERT INTO `customer_info` VALUES ('202320021', '0060', 0.0);
INSERT INTO `customer_info` VALUES ('202320022', '0069', 0.0);
INSERT INTO `customer_info` VALUES ('202320023', '0010', 0.0);
INSERT INTO `customer_info` VALUES ('202320024', '0071', 0.0);
INSERT INTO `customer_info` VALUES ('202320025', '0023', 0.0);
INSERT INTO `customer_info` VALUES ('202320026', '0050', 0.0);
INSERT INTO `customer_info` VALUES ('202320027', '0031', 0.0);
INSERT INTO `customer_info` VALUES ('202320028', '0003', 0.0);
INSERT INTO `customer_info` VALUES ('202320029', '0073', 0.0);
INSERT INTO `customer_info` VALUES ('202320030', '0054', 0.0);
INSERT INTO `customer_info` VALUES ('202320031', '0048', 0.0);
INSERT INTO `customer_info` VALUES ('202320032', '0002', 0.0);
INSERT INTO `customer_info` VALUES ('202320033', '0019', 0.0);
INSERT INTO `customer_info` VALUES ('202320034', '0010', 0.0);
INSERT INTO `customer_info` VALUES ('202320035', '0070', 0.0);
INSERT INTO `customer_info` VALUES ('202320036', '0017', 0.0);
INSERT INTO `customer_info` VALUES ('202320037', '0026', 0.0);
INSERT INTO `customer_info` VALUES ('202320038', '0003', 0.0);
INSERT INTO `customer_info` VALUES ('202320039', '0010', 0.0);
INSERT INTO `customer_info` VALUES ('202320040', '0041', 0.0);
INSERT INTO `customer_info` VALUES ('202320041', '0023', 0.0);
INSERT INTO `customer_info` VALUES ('202320042', '0066', 0.0);
INSERT INTO `customer_info` VALUES ('202320043', '0035', 0.0);
INSERT INTO `customer_info` VALUES ('202320044', '0051', 0.0);
INSERT INTO `customer_info` VALUES ('202320045', '0072', 0.0);
INSERT INTO `customer_info` VALUES ('202320046', '0055', 0.0);
INSERT INTO `customer_info` VALUES ('202320047', '0060', 0.0);
INSERT INTO `customer_info` VALUES ('202320048', '0056', 0.0);
INSERT INTO `customer_info` VALUES ('202320049', '0024', 0.0);
INSERT INTO `customer_info` VALUES ('202320050', '0029', 0.0);
INSERT INTO `customer_info` VALUES ('202420001', '0011', 0.0);
INSERT INTO `customer_info` VALUES ('202420002', '0016', 0.0);
INSERT INTO `customer_info` VALUES ('202420003', '0047', 0.0);
INSERT INTO `customer_info` VALUES ('202420004', '0034', 0.0);
INSERT INTO `customer_info` VALUES ('202420005', '0029', 0.0);
INSERT INTO `customer_info` VALUES ('202420006', '0043', 0.0);
INSERT INTO `customer_info` VALUES ('202420007', '0051', 0.0);
INSERT INTO `customer_info` VALUES ('202420008', '0051', 0.0);
INSERT INTO `customer_info` VALUES ('202420009', '0023', 0.0);
INSERT INTO `customer_info` VALUES ('202420010', '0036', 0.0);
INSERT INTO `customer_info` VALUES ('202420011', '0038', 0.0);
INSERT INTO `customer_info` VALUES ('202420012', '0006', 0.0);
INSERT INTO `customer_info` VALUES ('202420013', '0065', 0.0);
INSERT INTO `customer_info` VALUES ('202420014', '0003', 0.0);
INSERT INTO `customer_info` VALUES ('202420015', '0047', 0.0);
INSERT INTO `customer_info` VALUES ('202420016', '0072', 0.0);
INSERT INTO `customer_info` VALUES ('202420017', '0068', 0.0);
INSERT INTO `customer_info` VALUES ('202420018', '0048', 0.0);
INSERT INTO `customer_info` VALUES ('202420019', '0035', 0.0);
INSERT INTO `customer_info` VALUES ('202420020', '0031', 0.0);
INSERT INTO `customer_info` VALUES ('202420021', '0051', 0.0);
INSERT INTO `customer_info` VALUES ('202420022', '0007', 0.0);
INSERT INTO `customer_info` VALUES ('202420023', '0034', 0.0);
INSERT INTO `customer_info` VALUES ('202420024', '0071', 0.0);
INSERT INTO `customer_info` VALUES ('202420025', '0025', 0.0);
INSERT INTO `customer_info` VALUES ('202420026', '0065', 0.0);
INSERT INTO `customer_info` VALUES ('202420027', '0021', 0.0);
INSERT INTO `customer_info` VALUES ('202420028', '0060', 0.0);
INSERT INTO `customer_info` VALUES ('202420029', '0012', 0.0);
INSERT INTO `customer_info` VALUES ('202420030', '0028', 0.0);
INSERT INTO `customer_info` VALUES ('202420031', '0028', 0.0);
INSERT INTO `customer_info` VALUES ('202420032', '0057', 0.0);
INSERT INTO `customer_info` VALUES ('202420033', '0046', 0.0);
INSERT INTO `customer_info` VALUES ('202420034', '0059', 0.0);
INSERT INTO `customer_info` VALUES ('202420035', '0005', 0.0);
INSERT INTO `customer_info` VALUES ('202420036', '0075', 0.0);
INSERT INTO `customer_info` VALUES ('202420037', '0055', 0.0);
INSERT INTO `customer_info` VALUES ('202420038', '0050', 0.0);
INSERT INTO `customer_info` VALUES ('202420039', '0009', 0.0);
INSERT INTO `customer_info` VALUES ('202420040', '0047', 0.0);
INSERT INTO `customer_info` VALUES ('202420041', '0054', 0.0);
INSERT INTO `customer_info` VALUES ('202420042', '0054', 0.0);
INSERT INTO `customer_info` VALUES ('202420043', '0032', 0.0);
INSERT INTO `customer_info` VALUES ('202420044', '0073', 0.0);
INSERT INTO `customer_info` VALUES ('202420045', '0039', 0.0);
INSERT INTO `customer_info` VALUES ('202420046', '0053', 0.0);
INSERT INTO `customer_info` VALUES ('202420047', '0070', 0.0);
INSERT INTO `customer_info` VALUES ('202420048', '0039', 0.0);
INSERT INTO `customer_info` VALUES ('202420049', '0062', 0.0);
INSERT INTO `customer_info` VALUES ('202420050', '0038', 0.0);

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
INSERT INTO `employee_info` VALUES ('202110003', 4, '10');
INSERT INTO `employee_info` VALUES ('202110004', 2, '17');
INSERT INTO `employee_info` VALUES ('202110005', 4, '14');
INSERT INTO `employee_info` VALUES ('202110006', 1, '17');
INSERT INTO `employee_info` VALUES ('202110007', 3, '07');
INSERT INTO `employee_info` VALUES ('202110008', 4, '08');
INSERT INTO `employee_info` VALUES ('202110009', 2, '13');
INSERT INTO `employee_info` VALUES ('202110010', 3, '05');
INSERT INTO `employee_info` VALUES ('202110011', 4, '11');
INSERT INTO `employee_info` VALUES ('202110012', 2, '03');
INSERT INTO `employee_info` VALUES ('202110013', 2, '17');
INSERT INTO `employee_info` VALUES ('202110014', 2, '05');
INSERT INTO `employee_info` VALUES ('202110015', 1, '12');
INSERT INTO `employee_info` VALUES ('202110016', 1, '11');
INSERT INTO `employee_info` VALUES ('202110017', 4, '01');
INSERT INTO `employee_info` VALUES ('202110018', 3, '08');
INSERT INTO `employee_info` VALUES ('202110019', 1, '10');
INSERT INTO `employee_info` VALUES ('202110020', 2, '15');
INSERT INTO `employee_info` VALUES ('202210001', 1, '11');
INSERT INTO `employee_info` VALUES ('202210002', 2, '05');
INSERT INTO `employee_info` VALUES ('202210003', 4, '03');
INSERT INTO `employee_info` VALUES ('202210004', 4, '09');
INSERT INTO `employee_info` VALUES ('202210005', 1, '04');
INSERT INTO `employee_info` VALUES ('202210006', 3, '04');
INSERT INTO `employee_info` VALUES ('202210007', 2, '14');
INSERT INTO `employee_info` VALUES ('202210008', 1, '05');
INSERT INTO `employee_info` VALUES ('202210009', 4, '09');
INSERT INTO `employee_info` VALUES ('202210010', 1, '10');
INSERT INTO `employee_info` VALUES ('202210011', 3, '16');
INSERT INTO `employee_info` VALUES ('202210012', 2, '02');
INSERT INTO `employee_info` VALUES ('202210013', 2, '15');
INSERT INTO `employee_info` VALUES ('202210014', 4, '07');
INSERT INTO `employee_info` VALUES ('202210015', 4, '09');
INSERT INTO `employee_info` VALUES ('202210016', 3, '01');
INSERT INTO `employee_info` VALUES ('202210017', 1, '04');
INSERT INTO `employee_info` VALUES ('202210018', 4, '06');
INSERT INTO `employee_info` VALUES ('202210019', 1, '05');
INSERT INTO `employee_info` VALUES ('202210020', 3, '01');
INSERT INTO `employee_info` VALUES ('202310001', 3, '08');
INSERT INTO `employee_info` VALUES ('202310002', 3, '07');
INSERT INTO `employee_info` VALUES ('202310003', 1, '10');
INSERT INTO `employee_info` VALUES ('202310004', 2, '06');
INSERT INTO `employee_info` VALUES ('202310005', 2, '16');
INSERT INTO `employee_info` VALUES ('202310006', 3, '17');
INSERT INTO `employee_info` VALUES ('202310007', 1, '02');
INSERT INTO `employee_info` VALUES ('202310008', 4, '04');
INSERT INTO `employee_info` VALUES ('202310009', 2, '12');
INSERT INTO `employee_info` VALUES ('202310010', 3, '11');
INSERT INTO `employee_info` VALUES ('202310011', 4, '02');
INSERT INTO `employee_info` VALUES ('202310012', 1, '17');
INSERT INTO `employee_info` VALUES ('202310013', 4, '16');
INSERT INTO `employee_info` VALUES ('202310014', 1, '05');
INSERT INTO `employee_info` VALUES ('202310015', 4, '07');
INSERT INTO `employee_info` VALUES ('202310016', 2, '17');
INSERT INTO `employee_info` VALUES ('202310017', 2, '11');
INSERT INTO `employee_info` VALUES ('202310018', 3, '03');
INSERT INTO `employee_info` VALUES ('202310019', 4, '13');
INSERT INTO `employee_info` VALUES ('202310020', 1, '09');
INSERT INTO `employee_info` VALUES ('202410001', 4, '09');
INSERT INTO `employee_info` VALUES ('202410002', 3, '14');
INSERT INTO `employee_info` VALUES ('202410003', 1, '17');
INSERT INTO `employee_info` VALUES ('202410004', 3, '05');
INSERT INTO `employee_info` VALUES ('202410005', 2, '07');
INSERT INTO `employee_info` VALUES ('202410006', 2, '06');
INSERT INTO `employee_info` VALUES ('202410007', 1, '13');
INSERT INTO `employee_info` VALUES ('202410008', 1, '01');
INSERT INTO `employee_info` VALUES ('202410009', 2, '02');
INSERT INTO `employee_info` VALUES ('202410010', 1, '04');
INSERT INTO `employee_info` VALUES ('202410011', 4, '10');
INSERT INTO `employee_info` VALUES ('202410012', 1, '04');
INSERT INTO `employee_info` VALUES ('202410013', 3, '04');
INSERT INTO `employee_info` VALUES ('202410014', 2, '06');
INSERT INTO `employee_info` VALUES ('202410015', 2, '02');
INSERT INTO `employee_info` VALUES ('202410016', 1, '13');
INSERT INTO `employee_info` VALUES ('202410017', 4, '14');
INSERT INTO `employee_info` VALUES ('202410018', 4, '07');
INSERT INTO `employee_info` VALUES ('202410019', 4, '13');
INSERT INTO `employee_info` VALUES ('202410020', 4, '03');

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
  `pricePerHour` decimal(2, 1) NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  PRIMARY KEY (`meeting_room_id`) USING BTREE,
  INDEX `creator_id`(`creator_id` ASC) USING BTREE,
  INDEX `department_id`(`department_id` ASC) USING BTREE,
  CONSTRAINT `meetingroom_chk_1` CHECK (`pricePerHour` >= 0)
) ENGINE = InnoDB AUTO_INCREMENT = 452 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of meetingroom
-- ----------------------------
INSERT INTO `meetingroom` VALUES (1, '西方哲学史', '202500001', '01', 3.0, '系统介绍西方哲学从古希腊到现代的发展历程');
INSERT INTO `meetingroom` VALUES (2, '中国哲学史', '202500001', '01', 3.0, '探讨中国哲学思想从先秦到近代的演变');
INSERT INTO `meetingroom` VALUES (3, '伦理学基础', '202500001', '01', 2.5, '研究道德哲学的基本理论和应用');
INSERT INTO `meetingroom` VALUES (4, '逻辑学', '202500001', '01', 3.0, '学习形式逻辑的基本原理和方法');
INSERT INTO `meetingroom` VALUES (5, '形而上学', '202500001', '01', 3.5, '探讨存在的本质和现实的基本结构');
INSERT INTO `meetingroom` VALUES (6, '认识论', '202500001', '01', 3.0, '研究知识的本质、起源和限度');
INSERT INTO `meetingroom` VALUES (7, '美学原理', '202500001', '01', 2.0, '探讨艺术和美的哲学基础');
INSERT INTO `meetingroom` VALUES (8, '科学哲学', '202500001', '01', 3.0, '分析科学知识的性质和科学方法');
INSERT INTO `meetingroom` VALUES (9, '政治哲学', '202500001', '01', 3.0, '研究政治权力、正义和国家的哲学基础');
INSERT INTO `meetingroom` VALUES (10, '宗教哲学', '202500001', '01', 2.5, '探讨宗教现象和信仰的哲学问题');
INSERT INTO `meetingroom` VALUES (11, '现象学', '202500001', '01', 3.0, '研究意识和经验的本质结构');
INSERT INTO `meetingroom` VALUES (12, '分析哲学', '202500001', '01', 3.0, '探讨语言、思维与实在的关系');
INSERT INTO `meetingroom` VALUES (13, '东方哲学', '202500001', '01', 2.5, '研究印度、日本等东方哲学传统');
INSERT INTO `meetingroom` VALUES (14, '环境哲学', '202500001', '01', 2.0, '探讨人与自然的哲学关系');
INSERT INTO `meetingroom` VALUES (15, '数理逻辑', '202500001', '01', 3.5, '研究形式化逻辑系统和数学基础');
INSERT INTO `meetingroom` VALUES (16, '模态逻辑', '202500001', '01', 3.0, '探讨必然性和可能性的逻辑理论');
INSERT INTO `meetingroom` VALUES (17, '归纳逻辑', '202500001', '01', 2.5, '研究科学推理和概率推断方法');
INSERT INTO `meetingroom` VALUES (18, '逻辑史', '202500001', '01', 2.0, '探讨逻辑学的历史发展');
INSERT INTO `meetingroom` VALUES (19, '比较宗教学', '202500001', '01', 3.0, '比较研究世界主要宗教传统');
INSERT INTO `meetingroom` VALUES (20, '宗教人类学', '202500001', '01', 2.5, '从人类学角度研究宗教现象');
INSERT INTO `meetingroom` VALUES (21, '宗教社会学', '202500001', '01', 2.5, '探讨宗教与社会的互动关系');
INSERT INTO `meetingroom` VALUES (22, '中国宗教', '202500001', '01', 3.0, '研究中国传统宗教文化');
INSERT INTO `meetingroom` VALUES (23, '应用伦理学', '202500001', '01', 3.0, '研究现代社会的伦理问题');
INSERT INTO `meetingroom` VALUES (24, '元伦理学', '202500001', '01', 3.0, '探讨伦理学的基础理论');
INSERT INTO `meetingroom` VALUES (25, '职业伦理', '202500001', '01', 2.0, '研究各行业的伦理准则');
INSERT INTO `meetingroom` VALUES (26, '生命伦理学', '202500001', '01', 2.5, '探讨生命科学相关的伦理问题');
INSERT INTO `meetingroom` VALUES (27, '微观经济学', '202500001', '02', 4.0, '研究个体经济单位的经济行为');
INSERT INTO `meetingroom` VALUES (28, '宏观经济学', '202500001', '02', 4.0, '分析整体经济运行和宏观经济政策');
INSERT INTO `meetingroom` VALUES (29, '计量经济学', '202500001', '02', 3.5, '应用统计方法分析经济数据');
INSERT INTO `meetingroom` VALUES (30, '国际金融', '202500001', '02', 3.0, '研究跨国金融活动和国际金融市场');
INSERT INTO `meetingroom` VALUES (31, '投资学', '202500001', '02', 3.5, '探讨资产定价和投资组合理论');
INSERT INTO `meetingroom` VALUES (32, '货币银行学', '202500001', '02', 3.0, '分析货币体系和商业银行运作');
INSERT INTO `meetingroom` VALUES (33, '发展经济学', '202500001', '02', 3.0, '研究经济发展和增长的理论与实践');
INSERT INTO `meetingroom` VALUES (34, '金融衍生工具', '202500001', '02', 3.5, '学习期货、期权等金融衍生品');
INSERT INTO `meetingroom` VALUES (35, '行为经济学', '202500001', '02', 2.5, '探讨心理因素对经济决策的影响');
INSERT INTO `meetingroom` VALUES (36, '产业经济学', '202500001', '02', 3.0, '分析产业结构、组织和政策');
INSERT INTO `meetingroom` VALUES (37, '统计学导论', '202500001', '02', 3.5, '学习统计学的基本概念和方法');
INSERT INTO `meetingroom` VALUES (38, '经济统计分析', '202500001', '02', 4.0, '运用统计方法分析经济数据');
INSERT INTO `meetingroom` VALUES (39, '时间序列分析', '202500001', '02', 3.5, '研究时间序列数据的统计建模');
INSERT INTO `meetingroom` VALUES (40, '抽样调查理论', '202500001', '02', 3.0, '学习调查设计和数据收集方法');
INSERT INTO `meetingroom` VALUES (41, '多元统计分析', '202500001', '02', 3.5, '掌握多变量统计分析技术');
INSERT INTO `meetingroom` VALUES (42, '数据挖掘', '202500001', '02', 3.5, '学习大数据分析和挖掘方法');
INSERT INTO `meetingroom` VALUES (43, '商务数据分析', '202500001', '02', 3.5, '运用数据分析方法解决商业问题');
INSERT INTO `meetingroom` VALUES (44, '市场调研', '202500001', '02', 3.0, '学习市场研究方法和技术');
INSERT INTO `meetingroom` VALUES (45, '商业策略', '202500001', '02', 3.5, '研究企业战略制定和实施');
INSERT INTO `meetingroom` VALUES (46, '电子商务', '202500001', '02', 3.0, '探讨互联网商业模式和运营');
INSERT INTO `meetingroom` VALUES (47, '商业谈判', '202500001', '02', 2.5, '学习商务谈判技巧和策略');
INSERT INTO `meetingroom` VALUES (48, '工程经济学', '202500001', '02', 3.5, '学习工程项目的经济评价方法');
INSERT INTO `meetingroom` VALUES (49, '运筹学', '202500001', '02', 4.0, '研究资源优化配置的数学方法');
INSERT INTO `meetingroom` VALUES (50, '决策理论与方法', '202500001', '02', 3.5, '学习科学决策的理论和技术');
INSERT INTO `meetingroom` VALUES (51, '系统工程', '202500001', '02', 3.5, '研究复杂系统的分析和设计');
INSERT INTO `meetingroom` VALUES (52, '风险管理', '202500001', '02', 3.0, '学习风险识别和控制方法');
INSERT INTO `meetingroom` VALUES (53, '财政学原理', '202500001', '02', 4.0, '学习财政基本理论和政策');
INSERT INTO `meetingroom` VALUES (54, '税收学', '202500001', '02', 3.5, '研究税收制度和政策');
INSERT INTO `meetingroom` VALUES (55, '政府预算管理', '202500001', '02', 3.0, '学习政府预算编制和执行');
INSERT INTO `meetingroom` VALUES (56, '公共支出管理', '202500001', '02', 3.0, '研究公共支出的效率和效果');
INSERT INTO `meetingroom` VALUES (57, '地方财政', '202500001', '02', 3.0, '探讨地方政府财政运行');
INSERT INTO `meetingroom` VALUES (58, '金融数学', '202500001', '02', 4.0, '学习金融定量分析方法');
INSERT INTO `meetingroom` VALUES (59, '金融风险建模', '202500001', '02', 3.5, '研究金融风险的量化模型');
INSERT INTO `meetingroom` VALUES (60, '计算金融', '202500001', '02', 3.5, '学习金融算法和程序设计');
INSERT INTO `meetingroom` VALUES (61, '固定收益证券', '202500001', '02', 3.5, '研究债券定价和投资策略');
INSERT INTO `meetingroom` VALUES (62, '结构化产品设计', '202500001', '02', 3.0, '学习金融产品创新和设计');
INSERT INTO `meetingroom` VALUES (63, '宪法学', '202500001', '03', 3.5, '研究国家根本大法的理论和实践');
INSERT INTO `meetingroom` VALUES (64, '民法总论', '202500001', '03', 4.0, '学习民事法律关系的基本原理');
INSERT INTO `meetingroom` VALUES (65, '刑法学', '202500001', '03', 4.0, '探讨犯罪与刑罚的基本理论');
INSERT INTO `meetingroom` VALUES (66, '国际法', '202500001', '03', 3.0, '研究国家间关系的法律规范');
INSERT INTO `meetingroom` VALUES (67, '行政法学', '202500001', '03', 3.0, '分析行政权力运作的法律控制');
INSERT INTO `meetingroom` VALUES (68, '商法学', '202500001', '03', 3.5, '学习商事组织和商事活动的法律规范');
INSERT INTO `meetingroom` VALUES (69, '刑事诉讼法', '202500001', '03', 3.0, '研究刑事司法程序的法律规定');
INSERT INTO `meetingroom` VALUES (70, '知识产权法', '202500001', '03', 2.5, '探讨专利、商标和著作权的法律保护');
INSERT INTO `meetingroom` VALUES (71, '环境与资源保护法', '202500001', '03', 2.5, '分析环境保护的法律制度和实践');
INSERT INTO `meetingroom` VALUES (72, '法律文书写作', '202500001', '03', 2.0, '训练法律实务中的文书撰写技能');
INSERT INTO `meetingroom` VALUES (73, '专利法', '202500001', '03', 3.0, '深入研究专利申请、审查和保护制度');
INSERT INTO `meetingroom` VALUES (74, '商标法', '202500001', '03', 3.0, '探讨商标注册、使用和保护的法律规范');
INSERT INTO `meetingroom` VALUES (75, '著作权法', '202500001', '03', 3.0, '分析作品创作和使用的权利保护');
INSERT INTO `meetingroom` VALUES (76, '知识产权诉讼实务', '202500001', '03', 3.5, '学习知识产权案件的诉讼程序和技巧');
INSERT INTO `meetingroom` VALUES (77, '国际知识产权法', '202500001', '03', 3.0, '研究国际知识产权保护体系');
INSERT INTO `meetingroom` VALUES (78, '知识产权许可与转让', '202500001', '03', 2.5, '探讨知识产权的商业化运作');
INSERT INTO `meetingroom` VALUES (79, '犯罪心理学', '202500001', '03', 3.5, '研究犯罪人的心理特征和行为规律');
INSERT INTO `meetingroom` VALUES (80, '矫正教育学', '202500001', '03', 3.0, '探讨服刑人员的教育改造方法');
INSERT INTO `meetingroom` VALUES (81, '监狱管理学', '202500001', '03', 3.0, '学习监狱系统的组织和管理');
INSERT INTO `meetingroom` VALUES (82, '社区矫正', '202500001', '03', 2.5, '研究社区矫正的理论与实践');
INSERT INTO `meetingroom` VALUES (83, '罪犯改造技术', '202500001', '03', 3.0, '探讨罪犯行为矫正的方法和技术');
INSERT INTO `meetingroom` VALUES (84, '刑事执行法', '202500001', '03', 3.0, '学习刑罚执行的法律制度');
INSERT INTO `meetingroom` VALUES (85, '社会学理论', '202500001', '04', 3.5, '介绍经典和现代社会学理论');
INSERT INTO `meetingroom` VALUES (86, '社会研究方法', '202500001', '04', 3.0, '学习社会科学研究的定量和定性方法');
INSERT INTO `meetingroom` VALUES (87, '文化人类学', '202500001', '04', 3.0, '研究不同文化背景下的人类行为');
INSERT INTO `meetingroom` VALUES (88, '社会心理学', '202500001', '04', 3.0, '探讨个体在社会环境中的心理过程');
INSERT INTO `meetingroom` VALUES (89, '城市社会学', '202500001', '04', 2.5, '分析城市发展和社会结构变迁');
INSERT INTO `meetingroom` VALUES (90, '人口学', '202500001', '04', 2.5, '研究人口变动及其社会影响');
INSERT INTO `meetingroom` VALUES (91, '社会统计学', '202500001', '04', 3.0, '学习社会科学数据分析方法');
INSERT INTO `meetingroom` VALUES (92, '民俗学', '202500001', '04', 2.0, '研究民间传统和习俗');
INSERT INTO `meetingroom` VALUES (93, '性别研究', '202500001', '04', 2.5, '探讨性别与社会结构的关系');
INSERT INTO `meetingroom` VALUES (94, '全球化与社会变迁', '202500001', '04', 3.0, '分析全球化背景下的社会转型');
INSERT INTO `meetingroom` VALUES (95, '社会工作概论', '202500001', '04', 3.0, '介绍社会工作的基本理论和方法');
INSERT INTO `meetingroom` VALUES (96, '社会问题研究', '202500001', '04', 3.0, '分析当代社会问题及其解决方案');
INSERT INTO `meetingroom` VALUES (97, '组织社会学', '202500001', '04', 2.5, '研究社会组织的结构和功能');
INSERT INTO `meetingroom` VALUES (98, '家庭社会学', '202500001', '04', 2.5, '探讨家庭制度与社会变迁');
INSERT INTO `meetingroom` VALUES (99, '社会调查实务', '202500001', '04', 3.5, '实践社会调查的具体方法和技巧');
INSERT INTO `meetingroom` VALUES (100, '体质人类学', '202500001', '04', 3.0, '研究人类的生物学特征和演化');
INSERT INTO `meetingroom` VALUES (101, '考古人类学', '202500001', '04', 3.0, '探索人类文化的物质遗存');
INSERT INTO `meetingroom` VALUES (102, '语言人类学', '202500001', '04', 2.5, '研究语言与文化的关系');
INSERT INTO `meetingroom` VALUES (103, '经济人类学', '202500001', '04', 2.5, '分析不同社会的经济行为');
INSERT INTO `meetingroom` VALUES (104, '田野调查方法', '202500001', '04', 3.5, '学习人类学实地研究的方法');
INSERT INTO `meetingroom` VALUES (105, '社会保障制度', '202500001', '04', 3.0, '研究社会保险和福利制度');
INSERT INTO `meetingroom` VALUES (106, '公共政策分析', '202500001', '04', 3.5, '学习政策制定和评估方法');
INSERT INTO `meetingroom` VALUES (107, '社区发展与治理', '202500001', '04', 3.0, '探讨社区建设和管理模式');
INSERT INTO `meetingroom` VALUES (108, '社会福利政策', '202500001', '04', 2.5, '分析各类社会福利政策');
INSERT INTO `meetingroom` VALUES (109, '政策评估方法', '202500001', '04', 3.0, '学习政策效果评估技术');
INSERT INTO `meetingroom` VALUES (110, '马克思主义基本原理', '202500001', '05', 3.5, '系统介绍马克思主义哲学、政治经济学和科学社会主义');
INSERT INTO `meetingroom` VALUES (111, '中国特色社会主义理论体系', '202500001', '05', 3.0, '研究中国特色社会主义的形成和发展');
INSERT INTO `meetingroom` VALUES (112, '马克思主义发展史', '202500001', '05', 3.0, '探讨马克思主义理论的历史演变');
INSERT INTO `meetingroom` VALUES (113, '马克思主义政治经济学', '202500001', '05', 3.5, '学习马克思主义经济理论和方法');
INSERT INTO `meetingroom` VALUES (114, '科学社会主义理论与实践', '202500001', '05', 2.5, '分析社会主义运动的历史和现实');
INSERT INTO `meetingroom` VALUES (115, '马克思主义哲学', '202500001', '05', 3.0, '研究辩证唯物主义和历史唯物主义');
INSERT INTO `meetingroom` VALUES (116, '国外马克思主义研究', '202500001', '05', 2.5, '介绍西方马克思主义流派和理论');
INSERT INTO `meetingroom` VALUES (117, '马克思主义中国化研究', '202500001', '05', 3.0, '探讨马克思主义与中国实际相结合的过程');
INSERT INTO `meetingroom` VALUES (118, '思想政治教育学原理', '202500001', '05', 2.5, '研究思想政治教育的理论和实践');
INSERT INTO `meetingroom` VALUES (119, '当代社会思潮', '202500001', '05', 2.0, '分析当代国内外主要社会思潮');
INSERT INTO `meetingroom` VALUES (120, '党史研究方法', '202500001', '05', 3.0, '学习中国共产党历史研究的基本方法和文献分析');
INSERT INTO `meetingroom` VALUES (121, '社会主义比较研究', '202500001', '05', 3.0, '比较研究不同国家社会主义发展道路和经验');
INSERT INTO `meetingroom` VALUES (122, '中国化马克思主义文献精读', '202500001', '05', 3.5, '深入研读马克思主义中国化重要文献');
INSERT INTO `meetingroom` VALUES (123, '党的建设理论与实践', '202500001', '05', 3.0, '研究党的建设历史经验和现代化建设');
INSERT INTO `meetingroom` VALUES (124, '意识形态理论与实践', '202500001', '05', 2.5, '探讨意识形态的本质、功能和现实意义');
INSERT INTO `meetingroom` VALUES (125, '中国特色社会主义政治经济学', '202500001', '05', 3.5, '研究中国特色社会主义经济理论和实践');
INSERT INTO `meetingroom` VALUES (126, '马克思主义与现代化建设', '202500001', '05', 3.0, '探讨马克思主义指导现代化建设的理论与实践');
INSERT INTO `meetingroom` VALUES (127, '党史文献研究', '202500001', '05', 3.5, '深入研究党史重要文献和历史档案');
INSERT INTO `meetingroom` VALUES (128, '社会主义核心价值观研究', '202500001', '05', 2.5, '研究社会主义核心价值观的理论与实践');
INSERT INTO `meetingroom` VALUES (129, '中国古代文学史', '202500001', '06', 4.0, '系统介绍中国古代文学发展历程');
INSERT INTO `meetingroom` VALUES (130, '中国现代文学', '202500001', '06', 3.0, '研究五四运动以来的中国文学');
INSERT INTO `meetingroom` VALUES (131, '文学理论', '202500001', '06', 3.0, '学习文学批评和分析的基本理论');
INSERT INTO `meetingroom` VALUES (132, '古代汉语', '202500001', '06', 3.5, '研究古代汉语的语法、词汇和文字');
INSERT INTO `meetingroom` VALUES (133, '现代汉语', '202500001', '06', 3.0, '分析现代汉语的语音、词汇和语法');
INSERT INTO `meetingroom` VALUES (134, '比较文学', '202500001', '06', 2.5, '探讨不同文化背景下的文学比较');
INSERT INTO `meetingroom` VALUES (135, '民间文学', '202500001', '06', 2.0, '研究民间口头文学传统');
INSERT INTO `meetingroom` VALUES (136, '中国文学批评史', '202500001', '06', 3.0, '介绍中国古代文学批评理论');
INSERT INTO `meetingroom` VALUES (137, '写作学', '202500001', '06', 2.0, '训练文学创作和应用文写作技能');
INSERT INTO `meetingroom` VALUES (138, '方言学', '202500001', '06', 2.5, '研究中国各地方言的特点和分布');
INSERT INTO `meetingroom` VALUES (139, '语言学概论', '202500001', '06', 3.0, '介绍语言学的基本理论和研究方法');
INSERT INTO `meetingroom` VALUES (140, '汉语语言学', '202500001', '06', 3.0, '深入研究汉语语言系统的特点');
INSERT INTO `meetingroom` VALUES (141, '中国古代文化', '202500001', '06', 3.0, '探讨中国传统文化的核心内容');
INSERT INTO `meetingroom` VALUES (142, '文学创作实践', '202500001', '06', 2.5, '培养文学创作能力和艺术素养');
INSERT INTO `meetingroom` VALUES (143, '汉语修辞学', '202500001', '06', 2.5, '研究汉语修辞手段和表达技巧');
INSERT INTO `meetingroom` VALUES (144, '汉语国际教育', '202500001', '06', 3.0, '培养对外汉语教学的专业能力');
INSERT INTO `meetingroom` VALUES (145, '语言与认知', '202500001', '06', 2.5, '探讨语言与人类认知的关系');
INSERT INTO `meetingroom` VALUES (146, '文献整理与编纂', '202500001', '06', 3.0, '训练古籍整理和文献编纂能力');
INSERT INTO `meetingroom` VALUES (147, '中国文化典籍导读', '202500001', '06', 3.0, '研读中国重要文化典籍');
INSERT INTO `meetingroom` VALUES (148, '高级英语', '202500001', '07', 4.0, '提高英语听说读写综合能力');
INSERT INTO `meetingroom` VALUES (149, '英语语言学', '202500001', '07', 3.0, '研究英语语言的结构和功能');
INSERT INTO `meetingroom` VALUES (150, '英美文学选读', '202500001', '07', 3.0, '学习英美文学经典作品');
INSERT INTO `meetingroom` VALUES (151, '英语语音学', '202500001', '07', 2.5, '系统学习英语语音和发音规则');
INSERT INTO `meetingroom` VALUES (152, '英语写作', '202500001', '07', 2.5, '训练学术英语写作能力');
INSERT INTO `meetingroom` VALUES (153, '英语词汇学', '202500001', '07', 2.5, '研究英语词汇的构成和演变');
INSERT INTO `meetingroom` VALUES (154, '英语国家概况', '202500001', '07', 2.0, '介绍英语国家的历史、文化和社会');
INSERT INTO `meetingroom` VALUES (155, '英语教学法', '202500001', '07', 3.0, '探讨英语教学的理论与方法');
INSERT INTO `meetingroom` VALUES (156, '基础德语', '202500001', '07', 4.0, '德语语音、语法和基础会话训练');
INSERT INTO `meetingroom` VALUES (157, '德语听说', '202500001', '07', 3.0, '提高德语听力理解和口语表达能力');
INSERT INTO `meetingroom` VALUES (158, '德语阅读', '202500001', '07', 3.0, '培养德语文献阅读和理解能力');
INSERT INTO `meetingroom` VALUES (159, '德语写作', '202500001', '07', 2.5, '训练德语写作和表达技能');
INSERT INTO `meetingroom` VALUES (160, '德国文学', '202500001', '07', 3.0, '了解德国文学发展和经典作品');
INSERT INTO `meetingroom` VALUES (161, '德语语言学', '202500001', '07', 3.0, '研究德语语言的结构和特点');
INSERT INTO `meetingroom` VALUES (162, '基础日语', '202500001', '07', 4.0, '日语发音、语法和基础会话训练');
INSERT INTO `meetingroom` VALUES (163, '日语会话', '202500001', '07', 3.0, '提高日语口语交际能力');
INSERT INTO `meetingroom` VALUES (164, '日语阅读', '202500001', '07', 3.0, '培养日语文献阅读理解能力');
INSERT INTO `meetingroom` VALUES (165, '日语写作', '202500001', '07', 2.5, '训练日语写作和表达技能');
INSERT INTO `meetingroom` VALUES (166, '日本文学', '202500001', '07', 3.0, '了解日本文学发展和经典作品');
INSERT INTO `meetingroom` VALUES (167, '日本文化', '202500001', '07', 2.5, '学习日本传统文化和现代社会');
INSERT INTO `meetingroom` VALUES (168, '基础法语', '202500001', '07', 4.0, '法语语音、语法和基础会话训练');
INSERT INTO `meetingroom` VALUES (169, '法语听说', '202500001', '07', 3.0, '提高法语听力理解和口语表达能力');
INSERT INTO `meetingroom` VALUES (170, '法语阅读', '202500001', '07', 3.0, '培养法语文献阅读和理解能力');
INSERT INTO `meetingroom` VALUES (171, '法语写作', '202500001', '07', 2.5, '训练法语写作和表达技能');
INSERT INTO `meetingroom` VALUES (172, '法国文学', '202500001', '07', 3.0, '了解法国文学发展和经典作品');
INSERT INTO `meetingroom` VALUES (173, '法语语言学', '202500001', '07', 3.0, '研究法语语言的结构和特点');
INSERT INTO `meetingroom` VALUES (174, '商务英语阅读', '202500001', '07', 3.0, '学习商务英语文献阅读技巧');
INSERT INTO `meetingroom` VALUES (175, '商务英语写作', '202500001', '07', 3.0, '训练商务文书写作能力');
INSERT INTO `meetingroom` VALUES (176, '国际贸易英语', '202500001', '07', 3.5, '学习国际贸易专业英语');
INSERT INTO `meetingroom` VALUES (177, '商务谈判英语', '202500001', '07', 3.0, '培养商务谈判的英语技能');
INSERT INTO `meetingroom` VALUES (178, '跨文化商务交际', '202500001', '07', 2.5, '探讨国际商务中的文化差异');
INSERT INTO `meetingroom` VALUES (179, '商务英语翻译', '202500001', '07', 3.0, '训练商务文件的翻译技能');
INSERT INTO `meetingroom` VALUES (180, '翻译理论与实践', '202500001', '07', 3.5, '训练英汉互译的基本技能');
INSERT INTO `meetingroom` VALUES (181, '口译技巧', '202500001', '07', 3.0, '培养交替传译和同声传译技能');
INSERT INTO `meetingroom` VALUES (182, '文学翻译', '202500001', '07', 3.0, '训练文学作品的翻译技巧');
INSERT INTO `meetingroom` VALUES (183, '科技翻译', '202500001', '07', 3.0, '培养科技文献的翻译能力');
INSERT INTO `meetingroom` VALUES (184, '法律翻译', '202500001', '07', 3.0, '训练法律文件的翻译技能');
INSERT INTO `meetingroom` VALUES (185, '跨文化交际', '202500001', '07', 2.5, '探讨不同文化背景下的交际策略');
INSERT INTO `meetingroom` VALUES (186, '新闻学概论', '202500001', '08', 3.0, '介绍新闻学基本理论和实践');
INSERT INTO `meetingroom` VALUES (187, '传播学理论', '202500001', '08', 3.5, '研究信息传播的基本规律');
INSERT INTO `meetingroom` VALUES (188, '新闻采访与写作', '202500001', '08', 3.0, '训练新闻采写的基本技能');
INSERT INTO `meetingroom` VALUES (189, '媒介伦理与法规', '202500001', '08', 2.5, '探讨新闻传播中的伦理和法律问题');
INSERT INTO `meetingroom` VALUES (190, '新媒体技术', '202500001', '08', 3.0, '学习数字媒体技术的应用');
INSERT INTO `meetingroom` VALUES (191, '广告学原理', '202500001', '08', 2.5, '介绍广告策划和创意的基本理论');
INSERT INTO `meetingroom` VALUES (192, '公共关系学', '202500001', '08', 2.5, '研究组织与公众的沟通策略');
INSERT INTO `meetingroom` VALUES (193, '数据新闻', '202500001', '08', 3.0, '学习基于数据的新闻报道方法');
INSERT INTO `meetingroom` VALUES (194, '广播电视新闻', '202500001', '08', 2.5, '探讨广播电视新闻的采编播特点');
INSERT INTO `meetingroom` VALUES (195, '媒介经营管理', '202500001', '08', 3.0, '分析传媒组织的运营和管理');
INSERT INTO `meetingroom` VALUES (196, '新闻评论写作', '202500001', '08', 2.5, '培养新闻评论与社论写作能力');
INSERT INTO `meetingroom` VALUES (197, '舆论学', '202500001', '08', 3.0, '研究舆论形成与引导的规律');
INSERT INTO `meetingroom` VALUES (198, '新闻摄影', '202500001', '08', 2.5, '训练新闻摄影与图片报道技能');
INSERT INTO `meetingroom` VALUES (199, '调查性报道', '202500001', '08', 3.0, '学习深度调查报道的方法');
INSERT INTO `meetingroom` VALUES (200, '融媒体新闻报道', '202500001', '08', 3.0, '掌握全媒体新闻采编技能');
INSERT INTO `meetingroom` VALUES (201, '受众分析', '202500001', '08', 3.0, '研究传播对象的特征与行为');
INSERT INTO `meetingroom` VALUES (202, '传播效果研究', '202500001', '08', 3.0, '分析传播活动的效果评估方法');
INSERT INTO `meetingroom` VALUES (203, '跨文化传播', '202500001', '08', 2.5, '探讨不同文化间的传播现象');
INSERT INTO `meetingroom` VALUES (204, '网络传播', '202500001', '08', 3.0, '研究互联网传播规律与应用');
INSERT INTO `meetingroom` VALUES (205, '危机传播', '202500001', '08', 2.5, '学习危机事件的传播应对策略');
INSERT INTO `meetingroom` VALUES (206, '广告创意', '202500001', '08', 3.0, '培养广告创意与策划能力');
INSERT INTO `meetingroom` VALUES (207, '品牌传播', '202500001', '08', 3.0, '研究品牌建设与传播策略');
INSERT INTO `meetingroom` VALUES (208, '市场调查', '202500001', '08', 2.5, '学习市场研究与消费者行为分析');
INSERT INTO `meetingroom` VALUES (209, '整合营销传播', '202500001', '08', 3.0, '掌握全方位营销传播方法');
INSERT INTO `meetingroom` VALUES (210, '数字广告', '202500001', '08', 3.0, '研究数字环境下的广告投放策略');
INSERT INTO `meetingroom` VALUES (211, '中国古代史', '202500001', '09', 4.0, '系统介绍中国古代历史发展');
INSERT INTO `meetingroom` VALUES (212, '中国近代史', '202500001', '09', 3.5, '研究1840年以来的中国历史');
INSERT INTO `meetingroom` VALUES (213, '世界文明史', '202500001', '09', 4.0, '探讨世界主要文明的发展历程');
INSERT INTO `meetingroom` VALUES (214, '历史文献学', '202500001', '09', 3.0, '学习历史文献的检索和利用');
INSERT INTO `meetingroom` VALUES (215, '考古学概论', '202500001', '09', 3.0, '介绍考古学的基本理论和方法');
INSERT INTO `meetingroom` VALUES (216, '中国历史地理', '202500001', '09', 2.5, '研究历史时期中国地理环境变迁');
INSERT INTO `meetingroom` VALUES (217, '史学理论与方法', '202500001', '09', 3.0, '学习历史研究的基本理论和方法');
INSERT INTO `meetingroom` VALUES (218, '西方史学史', '202500001', '09', 3.0, '介绍西方史学发展历程');
INSERT INTO `meetingroom` VALUES (219, '中国社会经济史', '202500001', '09', 3.0, '研究中国历史上的经济制度和发展');
INSERT INTO `meetingroom` VALUES (220, '口述历史理论与实践', '202500001', '09', 2.5, '学习口述历史的采集和研究方法');
INSERT INTO `meetingroom` VALUES (221, '中国文化史', '202500001', '09', 3.5, '研究中国历史文化的发展与变迁');
INSERT INTO `meetingroom` VALUES (222, '历史地理信息系统', '202500001', '09', 3.0, '运用GIS技术研究历史地理');
INSERT INTO `meetingroom` VALUES (223, '区域国别史', '202500001', '09', 3.5, '深入研究特定地区或国家的历史');
INSERT INTO `meetingroom` VALUES (224, '比较文明史', '202500001', '09', 3.0, '比较研究不同文明的发展历程');
INSERT INTO `meetingroom` VALUES (225, '田野考古实践', '202500001', '09', 4.0, '实地考古发掘与调查方法训练');
INSERT INTO `meetingroom` VALUES (226, '文物修复与保护', '202500001', '09', 3.5, '学习文物修复技术与保护方法');
INSERT INTO `meetingroom` VALUES (227, '区域语言与文化', '202500001', '09', 3.0, '研究特定地区的语言与文化特征');
INSERT INTO `meetingroom` VALUES (228, '文物保护材料学', '202500001', '09', 3.5, '研究文物保护所需的材料特性');
INSERT INTO `meetingroom` VALUES (229, '文物病害防治', '202500001', '09', 3.0, '学习文物病害的预防与治理方法');
INSERT INTO `meetingroom` VALUES (230, '博物馆学', '202500001', '09', 3.0, '学习博物馆的运营与展览策划');
INSERT INTO `meetingroom` VALUES (231, '数字考古技术', '202500001', '09', 3.0, '运用数字技术进行考古研究');
INSERT INTO `meetingroom` VALUES (232, '文化遗产保护', '202500001', '09', 3.5, '研究文化遗产的保护理论与实践');
INSERT INTO `meetingroom` VALUES (233, '高等数学(上)', '202500001', '10', 5.0, '学习函数、极限、导数、积分等微积分基础知识');
INSERT INTO `meetingroom` VALUES (234, '高等数学(下)', '202500001', '10', 5.0, '学习多元函数微积分、无穷级数等高等数学进阶内容');
INSERT INTO `meetingroom` VALUES (235, '线性代数', '202500001', '10', 4.0, '学习矩阵、向量空间、线性变换等基础知识');
INSERT INTO `meetingroom` VALUES (236, '数学分析', '202500001', '10', 5.0, '学习微积分的基本理论和方法');
INSERT INTO `meetingroom` VALUES (237, '高等代数', '202500001', '10', 4.5, '研究线性代数的基本概念和理论');
INSERT INTO `meetingroom` VALUES (238, '概率论与数理统计', '202500001', '10', 4.0, '学习随机现象的概率规律和统计方法');
INSERT INTO `meetingroom` VALUES (239, '常微分方程', '202500001', '10', 3.5, '研究常微分方程的基本理论和解法');
INSERT INTO `meetingroom` VALUES (240, '复变函数', '202500001', '10', 3.5, '探讨复数域上的函数理论');
INSERT INTO `meetingroom` VALUES (241, '数值分析', '202500001', '10', 3.5, '学习数值计算的基本算法');
INSERT INTO `meetingroom` VALUES (242, '拓扑学', '202500001', '10', 3.0, '研究空间在连续变形下的不变性质');
INSERT INTO `meetingroom` VALUES (243, '数论基础', '202500001', '10', 3.0, '介绍整数性质的基本理论');
INSERT INTO `meetingroom` VALUES (244, '运筹学', '202500001', '10', 3.5, '学习最优化问题的数学方法');
INSERT INTO `meetingroom` VALUES (245, '数学建模', '202500001', '10', 3.0, '训练用数学方法解决实际问题的能力');
INSERT INTO `meetingroom` VALUES (246, '密码学基础', '202500001', '14', 4.0, '学习现代密码学理论和应用');
INSERT INTO `meetingroom` VALUES (247, '力学', '202500001', '11', 4.0, '研究物体机械运动的基本规律');
INSERT INTO `meetingroom` VALUES (248, '热学', '202500001', '11', 3.5, '探讨热现象和热力学定律');
INSERT INTO `meetingroom` VALUES (249, '电磁学', '202500001', '11', 4.0, '学习电磁场的基本理论和应用');
INSERT INTO `meetingroom` VALUES (250, '光学', '202500001', '11', 3.5, '研究光的性质和光学现象');
INSERT INTO `meetingroom` VALUES (251, '原子物理学', '202500001', '11', 3.5, '探讨原子结构和量子现象');
INSERT INTO `meetingroom` VALUES (252, '理论力学', '202500001', '11', 4.0, '学习分析力学的基本原理');
INSERT INTO `meetingroom` VALUES (253, '电动力学', '202500001', '11', 4.0, '研究电磁场的动力学理论');
INSERT INTO `meetingroom` VALUES (254, '量子力学', '202500001', '11', 4.5, '探讨微观粒子的运动规律');
INSERT INTO `meetingroom` VALUES (255, '固体物理学', '202500001', '11', 3.5, '研究固体材料的物理性质');
INSERT INTO `meetingroom` VALUES (256, '计算物理', '202500001', '11', 3.0, '学习物理问题的数值计算方法');
INSERT INTO `meetingroom` VALUES (257, '统计物理学', '202500001', '11', 4.0, '研究多粒子系统的宏观性质');
INSERT INTO `meetingroom` VALUES (258, '相对论', '202500001', '11', 4.0, '探讨时空和引力的基本理论');
INSERT INTO `meetingroom` VALUES (259, '数学物理方法', '202500001', '11', 3.5, '学习物理问题的数学处理方法');
INSERT INTO `meetingroom` VALUES (260, '材料物理', '202500001', '11', 3.5, '研究材料的物理性质和应用');
INSERT INTO `meetingroom` VALUES (261, '半导体物理', '202500001', '11', 4.0, '学习半导体的基本特性和器件原理');
INSERT INTO `meetingroom` VALUES (262, '光电子学', '202500001', '11', 3.5, '研究光电转换原理和应用');
INSERT INTO `meetingroom` VALUES (263, '核反应理论', '202500001', '11', 4.0, '研究原子核反应的基本规律');
INSERT INTO `meetingroom` VALUES (264, '粒子物理', '202500001', '11', 4.0, '探讨基本粒子的性质和相互作用');
INSERT INTO `meetingroom` VALUES (265, '辐射防护', '202500001', '11', 3.0, '学习核辐射防护的原理和方法');
INSERT INTO `meetingroom` VALUES (266, '量子计算', '202500001', '11', 4.0, '研究量子计算的原理和算法');
INSERT INTO `meetingroom` VALUES (267, '量子通信', '202500001', '11', 3.5, '学习量子通信的基本原理和技术');
INSERT INTO `meetingroom` VALUES (268, '量子密码学', '202500001', '11', 3.5, '探讨基于量子原理的密码系统');
INSERT INTO `meetingroom` VALUES (269, '无机化学', '202500001', '12', 4.0, '研究无机化合物的结构和性质');
INSERT INTO `meetingroom` VALUES (270, '有机化学', '202500001', '12', 4.0, '学习有机化合物的结构和反应');
INSERT INTO `meetingroom` VALUES (271, '分析化学', '202500001', '12', 3.5, '探讨物质成分的分析方法');
INSERT INTO `meetingroom` VALUES (272, '物理化学', '202500001', '12', 4.5, '研究化学体系的物理性质和变化规律');
INSERT INTO `meetingroom` VALUES (273, '结构化学', '202500001', '12', 3.5, '探讨分子和晶体的结构');
INSERT INTO `meetingroom` VALUES (274, '高分子化学', '202500001', '12', 3.0, '学习高分子化合物的合成和性质');
INSERT INTO `meetingroom` VALUES (275, '仪器分析', '202500001', '12', 3.0, '介绍现代分析仪器的原理和应用');
INSERT INTO `meetingroom` VALUES (276, '催化化学', '202500001', '12', 3.0, '研究催化反应的基本原理');
INSERT INTO `meetingroom` VALUES (277, '环境化学', '202500001', '12', 2.5, '探讨化学物质在环境中的行为');
INSERT INTO `meetingroom` VALUES (278, '计算化学', '202500001', '12', 3.0, '学习化学问题的计算方法');
INSERT INTO `meetingroom` VALUES (279, '量子化学', '202500001', '12', 4.0, '研究分子体系的量子力学性质');
INSERT INTO `meetingroom` VALUES (280, '配位化学', '202500001', '12', 3.5, '研究配位化合物的结构和性质');
INSERT INTO `meetingroom` VALUES (281, '化学热力学', '202500001', '12', 3.5, '研究化学反应的能量变化规律');
INSERT INTO `meetingroom` VALUES (282, '化学动力学', '202500001', '12', 3.5, '研究化学反应速率和机理');
INSERT INTO `meetingroom` VALUES (283, '化学实验设计', '202500001', '12', 2.0, '学习化学实验的设计和优化方法');
INSERT INTO `meetingroom` VALUES (284, '工业化学', '202500001', '12', 4.0, '研究工业生产中的化学过程');
INSERT INTO `meetingroom` VALUES (285, '化工原理', '202500001', '12', 4.0, '学习化工单元操作的基本原理');
INSERT INTO `meetingroom` VALUES (286, '精细化工', '202500001', '12', 3.5, '研究精细化学品的合成和应用');
INSERT INTO `meetingroom` VALUES (287, '电化学', '202500001', '12', 3.5, '研究电化学反应和应用');
INSERT INTO `meetingroom` VALUES (288, '材料化学', '202500001', '12', 3.5, '学习新材料的制备和性能');
INSERT INTO `meetingroom` VALUES (289, '生物化学', '202500001', '12', 4.0, '研究生物体内的化学反应');
INSERT INTO `meetingroom` VALUES (290, '分子生物学', '202500001', '12', 4.0, '学习生物大分子的结构和功能');
INSERT INTO `meetingroom` VALUES (291, '药物化学', '202500001', '12', 3.5, '研究药物的化学合成和作用');
INSERT INTO `meetingroom` VALUES (292, '生物有机化学', '202500001', '12', 3.5, '研究有机化合物在生物体内的作用');
INSERT INTO `meetingroom` VALUES (293, '化学生物学实验技术', '202500001', '12', 2.5, '学习化学生物学研究方法');
INSERT INTO `meetingroom` VALUES (294, '工程制图', '202500001', '13', 3.0, '学习工程图样的绘制和阅读');
INSERT INTO `meetingroom` VALUES (295, '材料力学', '202500001', '13', 4.0, '研究材料在外力作用下的力学性能');
INSERT INTO `meetingroom` VALUES (296, '机械设计基础', '202500001', '13', 3.5, '学习机械零件和机构的设计原理');
INSERT INTO `meetingroom` VALUES (297, '电子技术', '202500001', '13', 3.5, '研究模拟和数字电子电路');
INSERT INTO `meetingroom` VALUES (298, '自动控制原理', '202500001', '13', 3.5, '学习控制系统的基本理论');
INSERT INTO `meetingroom` VALUES (299, '工程热力学', '202500001', '13', 3.0, '探讨热能与机械能转换的规律');
INSERT INTO `meetingroom` VALUES (300, '流体力学', '202500001', '13', 3.5, '研究流体静止和运动的力学规律');
INSERT INTO `meetingroom` VALUES (301, 'CAD/CAM技术', '202500001', '13', 3.0, '学习计算机辅助设计与制造');
INSERT INTO `meetingroom` VALUES (302, '传感器技术', '202500001', '13', 2.5, '介绍各种传感器的原理和应用');
INSERT INTO `meetingroom` VALUES (303, '机器人学', '202500001', '13', 3.0, '探讨机器人运动学和动力学');
INSERT INTO `meetingroom` VALUES (304, '机械原理', '202500001', '13', 3.5, '研究机械运动和力传递的基本原理');
INSERT INTO `meetingroom` VALUES (305, '机械制造技术', '202500001', '13', 4.0, '学习各种机械加工方法和工艺');
INSERT INTO `meetingroom` VALUES (306, '数控技术', '202500001', '13', 3.0, '掌握数控机床编程和操作技术');
INSERT INTO `meetingroom` VALUES (307, '机械振动', '202500001', '13', 3.0, '研究机械系统的振动现象和控制');
INSERT INTO `meetingroom` VALUES (308, '弹性力学', '202500001', '13', 3.5, '研究弹性体的应力和变形');
INSERT INTO `meetingroom` VALUES (309, '结构力学', '202500001', '13', 4.0, '分析工程结构的受力和变形');
INSERT INTO `meetingroom` VALUES (310, '计算力学', '202500001', '13', 3.0, '学习力学问题的数值计算方法');
INSERT INTO `meetingroom` VALUES (311, '实验力学', '202500001', '13', 3.0, '进行力学实验和数据分析');
INSERT INTO `meetingroom` VALUES (312, '材料科学基础', '202500001', '13', 4.0, '学习材料的结构和性能关系');
INSERT INTO `meetingroom` VALUES (313, '金属材料学', '202500001', '13', 3.5, '研究金属材料的性能和应用');
INSERT INTO `meetingroom` VALUES (314, '高分子材料', '202500001', '13', 3.0, '学习高分子材料的制备和性能');
INSERT INTO `meetingroom` VALUES (315, '材料测试技术', '202500001', '13', 3.0, '掌握材料性能测试方法');
INSERT INTO `meetingroom` VALUES (316, '电路理论', '202500001', '13', 4.0, '学习电路分析的基本理论');
INSERT INTO `meetingroom` VALUES (317, '电机学', '202500001', '13', 3.5, '研究电机的工作原理和特性');
INSERT INTO `meetingroom` VALUES (318, '电力电子技术', '202500001', '13', 3.5, '学习电力电子器件和变换电路');
INSERT INTO `meetingroom` VALUES (319, '电气控制系统', '202500001', '13', 3.0, '设计和分析电气控制系统');
INSERT INTO `meetingroom` VALUES (320, '工业设计方法', '202500001', '13', 3.5, '学习产品设计的方法和流程');
INSERT INTO `meetingroom` VALUES (321, '人机工程学', '202500001', '13', 3.0, '研究产品与使用者的交互关系');
INSERT INTO `meetingroom` VALUES (322, '产品造型设计', '202500001', '13', 3.5, '学习产品的造型和结构设计');
INSERT INTO `meetingroom` VALUES (323, '设计表现技法', '202500001', '13', 3.0, '掌握设计效果图的表现方法');
INSERT INTO `meetingroom` VALUES (324, '程序设计基础', '202500001', '14', 4.0, '学习计算机编程的基本概念和方法');
INSERT INTO `meetingroom` VALUES (325, '数据结构', '202500001', '14', 4.0, '研究数据的组织和存储方式');
INSERT INTO `meetingroom` VALUES (326, '算法设计与分析', '202500001', '14', 4.0, '学习算法设计的基本策略和复杂度分析');
INSERT INTO `meetingroom` VALUES (327, '计算机组成原理', '202500001', '14', 4.0, '探讨计算机硬件系统的基本组成');
INSERT INTO `meetingroom` VALUES (328, '操作系统', '202500001', '14', 4.0, '研究计算机系统资源管理的基本原理');
INSERT INTO `meetingroom` VALUES (329, '数据库系统', '202500001', '14', 3.5, '学习数据库的设计和管理');
INSERT INTO `meetingroom` VALUES (330, '计算机网络', '202500001', '14', 3.5, '研究计算机网络的体系结构和协议');
INSERT INTO `meetingroom` VALUES (331, '软件工程', '202500001', '14', 3.0, '学习软件开发的过程和方法');
INSERT INTO `meetingroom` VALUES (332, '人工智能', '202500001', '14', 3.5, '探讨智能系统的设计和实现');
INSERT INTO `meetingroom` VALUES (333, '机器学习', '202500001', '14', 3.5, '研究计算机从数据中学习的方法');
INSERT INTO `meetingroom` VALUES (334, '编译原理', '202500001', '14', 4.0, '学习程序语言的编译原理和实现方法');
INSERT INTO `meetingroom` VALUES (335, '分布式系统', '202500001', '14', 3.5, '研究分布式计算和存储系统的设计');
INSERT INTO `meetingroom` VALUES (336, '计算机图形学', '202500001', '14', 3.5, '学习计算机图形的生成和处理技术');
INSERT INTO `meetingroom` VALUES (337, '高性能计算', '202500001', '14', 3.5, '探索并行计算和性能优化技术');
INSERT INTO `meetingroom` VALUES (338, '软件测试与质量保证', '202500001', '14', 3.5, '学习软件测试方法和质量管理');
INSERT INTO `meetingroom` VALUES (339, '需求工程', '202500001', '14', 3.0, '研究软件需求分析和管理方法');
INSERT INTO `meetingroom` VALUES (340, '软件架构设计', '202500001', '14', 3.5, '学习大型软件系统的架构设计');
INSERT INTO `meetingroom` VALUES (341, '敏捷开发方法', '202500001', '14', 3.0, '探索现代软件开发流程和实践');
INSERT INTO `meetingroom` VALUES (342, '网络安全', '202500001', '14', 4.0, '学习网络安全技术和防护方法');
INSERT INTO `meetingroom` VALUES (343, '云计算技术', '202500001', '14', 3.5, '研究云计算平台的架构和服务');
INSERT INTO `meetingroom` VALUES (344, '网络编程', '202500001', '14', 3.5, '学习网络应用程序开发技术');
INSERT INTO `meetingroom` VALUES (345, '物联网技术', '202500001', '14', 3.0, '探索物联网系统的设计和应用');
INSERT INTO `meetingroom` VALUES (346, '区块链原理', '202500001', '14', 4.0, '研究区块链系统的核心机制');
INSERT INTO `meetingroom` VALUES (347, '智能合约开发', '202500001', '14', 3.5, '学习区块链智能合约的设计和实现');
INSERT INTO `meetingroom` VALUES (348, '区块链应用开发', '202500001', '14', 3.5, '探索区块链在各领域的应用开发');
INSERT INTO `meetingroom` VALUES (349, '管理学原理', '202500001', '15', 3.5, '介绍管理的基本理论和职能');
INSERT INTO `meetingroom` VALUES (350, '组织行为学', '202500001', '15', 3.0, '研究组织中个体和群体的行为规律');
INSERT INTO `meetingroom` VALUES (351, '战略管理', '202500001', '15', 3.5, '学习企业战略制定和实施');
INSERT INTO `meetingroom` VALUES (352, '市场营销学', '202500001', '15', 3.0, '探讨市场分析和营销策略');
INSERT INTO `meetingroom` VALUES (353, '人力资源管理', '202500001', '15', 3.0, '研究组织人力资源的获取和发展');
INSERT INTO `meetingroom` VALUES (354, '运营管理', '202500001', '15', 3.5, '学习产品和服务的生产运作管理');
INSERT INTO `meetingroom` VALUES (355, '管理信息系统', '202500001', '15', 3.0, '探讨信息技术在管理中的应用');
INSERT INTO `meetingroom` VALUES (356, '财务管理', '202500001', '15', 3.5, '研究企业资金的筹集和运用');
INSERT INTO `meetingroom` VALUES (357, '企业伦理', '202500001', '15', 2.0, '探讨企业管理中的伦理问题');
INSERT INTO `meetingroom` VALUES (358, '项目管理', '202500001', '15', 3.0, '学习项目规划和控制的方法');
INSERT INTO `meetingroom` VALUES (359, '会计学原理', '202500001', '15', 3.5, '学习会计核算的基本理论和方法');
INSERT INTO `meetingroom` VALUES (360, '中级财务会计', '202500001', '15', 4.0, '深入学习企业会计核算和报告');
INSERT INTO `meetingroom` VALUES (361, '成本会计', '202500001', '15', 3.5, '研究产品成本核算和管理');
INSERT INTO `meetingroom` VALUES (362, '审计学', '202500001', '15', 3.5, '学习审计的基本理论和实务');
INSERT INTO `meetingroom` VALUES (363, '税务会计', '202500001', '15', 3.0, '研究税收政策和纳税实务');
INSERT INTO `meetingroom` VALUES (364, '管理会计', '202500001', '15', 3.5, '学习企业内部管理决策方法');
INSERT INTO `meetingroom` VALUES (365, '国际贸易理论与实务', '202500001', '15', 3.5, '学习国际贸易基本理论和操作');
INSERT INTO `meetingroom` VALUES (366, '国际金融', '202500001', '15', 3.5, '研究国际金融市场和汇率理论');
INSERT INTO `meetingroom` VALUES (367, '国际商法', '202500001', '15', 3.0, '学习国际商务相关法律规范');
INSERT INTO `meetingroom` VALUES (368, '跨国公司管理', '202500001', '15', 3.5, '研究跨国企业的运营管理');
INSERT INTO `meetingroom` VALUES (369, '国际商务谈判', '202500001', '15', 3.0, '培养国际商务谈判技能');
INSERT INTO `meetingroom` VALUES (370, '国际物流管理', '202500001', '15', 3.0, '学习国际物流运作和管理');
INSERT INTO `meetingroom` VALUES (371, '公共政策分析', '202500001', '15', 3.5, '研究公共政策制定和评估');
INSERT INTO `meetingroom` VALUES (372, '行政管理学', '202500001', '15', 3.5, '学习行政组织的管理理论');
INSERT INTO `meetingroom` VALUES (373, '政府预算管理', '202500001', '15', 3.0, '研究政府部门的预算管理');
INSERT INTO `meetingroom` VALUES (374, '公共服务管理', '202500001', '15', 3.0, '学习公共服务的提供和管理');
INSERT INTO `meetingroom` VALUES (375, '电子政务', '202500001', '15', 3.0, '探讨信息技术在政府管理中的应用');
INSERT INTO `meetingroom` VALUES (376, '城市管理', '202500001', '15', 3.0, '研究城市发展和管理问题');
INSERT INTO `meetingroom` VALUES (377, '人体解剖学', '202500001', '16', 5.0, '研究人体各器官系统的形态结构');
INSERT INTO `meetingroom` VALUES (378, '生理学', '202500001', '16', 4.5, '探讨人体生命活动的规律');
INSERT INTO `meetingroom` VALUES (379, '生物化学', '202500001', '16', 4.0, '研究生命体的化学组成和代谢');
INSERT INTO `meetingroom` VALUES (380, '病理学', '202500001', '16', 4.0, '学习疾病发生发展的基本规律');
INSERT INTO `meetingroom` VALUES (381, '药理学', '202500001', '16', 4.0, '探讨药物与机体相互作用');
INSERT INTO `meetingroom` VALUES (382, '诊断学', '202500001', '16', 4.0, '学习疾病诊断的基本方法');
INSERT INTO `meetingroom` VALUES (383, '内科学', '202500001', '16', 5.0, '研究内科疾病的诊断和治疗');
INSERT INTO `meetingroom` VALUES (384, '外科学', '202500001', '16', 5.0, '学习外科疾病的诊断和手术技术');
INSERT INTO `meetingroom` VALUES (385, '妇产科学', '202500001', '16', 4.0, '研究女性生理和疾病特点');
INSERT INTO `meetingroom` VALUES (386, '儿科学', '202500001', '16', 4.0, '研究儿童疾病的诊断和治疗');
INSERT INTO `meetingroom` VALUES (387, '神经科学', '202500001', '16', 4.0, '研究神经系统疾病');
INSERT INTO `meetingroom` VALUES (388, '影像医学', '202500001', '16', 3.5, '学习医学影像诊断技术');
INSERT INTO `meetingroom` VALUES (389, '急诊医学', '202500001', '16', 4.0, '掌握急危重症的处理方法');
INSERT INTO `meetingroom` VALUES (390, '药物化学', '202500001', '16', 4.0, '研究药物的化学结构与活性');
INSERT INTO `meetingroom` VALUES (391, '药剂学', '202500001', '16', 4.0, '研究药物制剂的原理与方法');
INSERT INTO `meetingroom` VALUES (392, '药物分析', '202500001', '16', 3.5, '学习药物质量检测方法');
INSERT INTO `meetingroom` VALUES (393, '药物毒理学', '202500001', '16', 3.5, '研究药物的毒性作用');
INSERT INTO `meetingroom` VALUES (394, '药事管理', '202500001', '16', 3.0, '学习药品管理相关法规');
INSERT INTO `meetingroom` VALUES (395, '中医基础理论', '202500001', '16', 4.0, '学习中医药的基本理论');
INSERT INTO `meetingroom` VALUES (396, '中药鉴定学', '202500001', '16', 4.0, '研究中药材的鉴别方法');
INSERT INTO `meetingroom` VALUES (397, '方剂学', '202500001', '16', 4.0, '学习中药复方配伍原理');
INSERT INTO `meetingroom` VALUES (398, '中药炮制学', '202500001', '16', 3.5, '研究中药加工炮制技术');
INSERT INTO `meetingroom` VALUES (399, '中药药理学', '202500001', '16', 3.5, '研究中药的药理作用');
INSERT INTO `meetingroom` VALUES (400, '流行病学', '202500001', '16', 4.0, '研究疾病流行规律');
INSERT INTO `meetingroom` VALUES (401, '卫生统计学', '202500001', '16', 3.5, '学习健康数据分析方法');
INSERT INTO `meetingroom` VALUES (402, '环境卫生学', '202500001', '16', 3.5, '研究环境因素对健康的影响');
INSERT INTO `meetingroom` VALUES (403, '职业卫生与职业医学', '202500001', '16', 3.5, '研究职业相关疾病防治');
INSERT INTO `meetingroom` VALUES (404, '营养与食品卫生学', '202500001', '16', 3.5, '学习营养与食品安全');
INSERT INTO `meetingroom` VALUES (405, '医学仪器原理', '202500001', '16', 4.0, '学习医疗设备的工作原理');
INSERT INTO `meetingroom` VALUES (406, '生物医学传感器', '202500001', '16', 3.5, '研究生物信号检测技术');
INSERT INTO `meetingroom` VALUES (407, '医学图像处理', '202500001', '16', 4.0, '学习医学影像数据处理');
INSERT INTO `meetingroom` VALUES (408, '生物力学', '202500001', '16', 3.5, '研究生物体的力学特性');
INSERT INTO `meetingroom` VALUES (409, '康复工程', '202500001', '16', 3.5, '学习康复设备设计原理');
INSERT INTO `meetingroom` VALUES (410, '医学伦理学', '202500001', '16', 2.0, '研究医疗实践中的伦理问题');
INSERT INTO `meetingroom` VALUES (411, '预防医学', '202500001', '16', 3.0, '探讨疾病预防和健康促进');
INSERT INTO `meetingroom` VALUES (412, '艺术概论', '202500001', '17', 2.5, '介绍艺术的基本理论和历史');
INSERT INTO `meetingroom` VALUES (413, '素描基础', '202500001', '17', 3.0, '训练造型艺术的基本技能');
INSERT INTO `meetingroom` VALUES (414, '色彩学', '202500001', '17', 2.5, '研究色彩的构成和表现');
INSERT INTO `meetingroom` VALUES (415, '中外美术史', '202500001', '17', 3.0, '介绍中外美术发展历程');
INSERT INTO `meetingroom` VALUES (416, '人体素描', '202500001', '17', 3.0, '学习人体结构和造型表现');
INSERT INTO `meetingroom` VALUES (417, '水彩技法', '202500001', '17', 2.5, '掌握水彩绘画的基本技巧');
INSERT INTO `meetingroom` VALUES (418, '中国画技法', '202500001', '17', 3.0, '训练传统中国画的绘制方法');
INSERT INTO `meetingroom` VALUES (419, '油画技法', '202500001', '17', 3.0, '学习西方油画的绘制技术');
INSERT INTO `meetingroom` VALUES (420, '平面构成', '202500001', '17', 2.5, '学习二维空间的艺术设计');
INSERT INTO `meetingroom` VALUES (421, '立体构成', '202500001', '17', 2.5, '探讨三维空间的艺术表现');
INSERT INTO `meetingroom` VALUES (422, '字体设计', '202500001', '17', 2.5, '研究文字的艺术表现形式');
INSERT INTO `meetingroom` VALUES (423, '包装设计', '202500001', '17', 3.0, '学习产品包装的设计方法');
INSERT INTO `meetingroom` VALUES (424, 'UI设计', '202500001', '17', 3.0, '探索数字界面的设计原则');
INSERT INTO `meetingroom` VALUES (425, '品牌设计', '202500001', '17', 3.0, '学习品牌视觉识别系统设计');
INSERT INTO `meetingroom` VALUES (426, '音乐理论', '202500001', '17', 2.5, '学习基本乐理和音乐分析');
INSERT INTO `meetingroom` VALUES (427, '视唱练耳', '202500001', '17', 2.0, '训练音乐听觉能力');
INSERT INTO `meetingroom` VALUES (428, '钢琴演奏', '202500001', '17', 3.0, '掌握钢琴演奏技巧');
INSERT INTO `meetingroom` VALUES (429, '声乐训练', '202500001', '17', 2.5, '培养声乐演唱能力');
INSERT INTO `meetingroom` VALUES (430, '作曲技法', '202500001', '17', 3.0, '学习音乐创作方法');
INSERT INTO `meetingroom` VALUES (431, '中外音乐史', '202500001', '17', 3.0, '了解音乐艺术发展历程');
INSERT INTO `meetingroom` VALUES (432, '舞蹈基础训练', '202500001', '17', 3.0, '培养基本舞蹈素质');
INSERT INTO `meetingroom` VALUES (433, '中国古典舞', '202500001', '17', 3.0, '学习传统舞蹈艺术');
INSERT INTO `meetingroom` VALUES (434, '芭蕾舞基础', '202500001', '17', 3.0, '掌握芭蕾舞基本技巧');
INSERT INTO `meetingroom` VALUES (435, '现代舞', '202500001', '17', 2.5, '探索现代舞蹈表现形式');
INSERT INTO `meetingroom` VALUES (436, '舞蹈编导', '202500001', '17', 3.0, '学习舞蹈编创方法');
INSERT INTO `meetingroom` VALUES (437, '戏剧表演基础', '202500001', '17', 3.0, '训练表演基本功');
INSERT INTO `meetingroom` VALUES (438, '台词与发声', '202500001', '17', 2.5, '培养舞台发声能力');
INSERT INTO `meetingroom` VALUES (439, '形体训练', '202500001', '17', 2.5, '锻炼表演者身体素质');
INSERT INTO `meetingroom` VALUES (440, '戏剧导演', '202500001', '17', 3.0, '学习戏剧导演方法');
INSERT INTO `meetingroom` VALUES (441, '中外戏剧史', '202500001', '17', 3.0, '了解戏剧艺术发展历程');
INSERT INTO `meetingroom` VALUES (442, '影视制作基础', '202500001', '17', 3.0, '学习影视制作流程');
INSERT INTO `meetingroom` VALUES (443, '摄像技术', '202500001', '17', 3.0, '掌握摄像机操作技巧');
INSERT INTO `meetingroom` VALUES (444, '影视剪辑', '202500001', '17', 3.0, '学习影视后期制作');
INSERT INTO `meetingroom` VALUES (445, '影视导演', '202500001', '17', 3.5, '培养影视导演能力');
INSERT INTO `meetingroom` VALUES (446, '影视特效', '202500001', '17', 3.0, '学习视觉特效制作');
INSERT INTO `meetingroom` VALUES (447, '摄影基础', '202500001', '17', 2.5, '学习摄影基本原理');
INSERT INTO `meetingroom` VALUES (448, '人像摄影', '202500001', '17', 3.0, '掌握人像拍摄技巧');
INSERT INTO `meetingroom` VALUES (449, '风光摄影', '202500001', '17', 3.0, '学习自然景观拍摄');
INSERT INTO `meetingroom` VALUES (450, '商业摄影', '202500001', '17', 3.0, '探索商业摄影创作');
INSERT INTO `meetingroom` VALUES (451, '后期处理', '202500001', '17', 2.5, '学习数字图像处理技术');

-- ----------------------------
-- Table structure for meetingroom_employee
-- ----------------------------
DROP TABLE IF EXISTS `meetingroom_employee`;
CREATE TABLE `meetingroom_employee`  (
  `meeting_room_id` int NOT NULL,
  `user_id` char(9) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`meeting_room_id`, `user_id`) USING BTREE,
  INDEX `user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `meetingroom_employee_ibfk_1` FOREIGN KEY (`meeting_room_id`) REFERENCES `meetingroom` (`meeting_room_id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `meetingroom_employee_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of meetingroom_employee
-- ----------------------------
INSERT INTO `meetingroom_employee` VALUES (1, '202010001');
INSERT INTO `meetingroom_employee` VALUES (2, '202010001');
INSERT INTO `meetingroom_employee` VALUES (3, '202010001');
INSERT INTO `meetingroom_employee` VALUES (1, '202010002');
INSERT INTO `meetingroom_employee` VALUES (1, '202010003');
INSERT INTO `meetingroom_employee` VALUES (1, '202010004');
INSERT INTO `meetingroom_employee` VALUES (1, '202010005');
INSERT INTO `meetingroom_employee` VALUES (1, '202010006');
INSERT INTO `meetingroom_employee` VALUES (1, '202010007');

-- ----------------------------
-- Table structure for meetingroom_selection
-- ----------------------------
DROP TABLE IF EXISTS `meetingroom_selection`;
CREATE TABLE `meetingroom_selection`  (
  `meeting_room_id` int NOT NULL,
  `customer_id` char(9) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `employee_id` char(9) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `selection_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `score` decimal(4, 1) NOT NULL,
  PRIMARY KEY (`meeting_room_id`, `customer_id`, `employee_id`) USING BTREE,
  INDEX `student_id`(`customer_id` ASC) USING BTREE,
  INDEX `teacher_id`(`employee_id` ASC) USING BTREE,
  CONSTRAINT `meetingroom_selection_ibfk_1` FOREIGN KEY (`meeting_room_id`) REFERENCES `meetingroom` (`meeting_room_id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `meetingroom_selection_ibfk_3` FOREIGN KEY (`employee_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `meetingroom_selection_chk_1` CHECK (`score` between 0 and 100)
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of meetingroom_selection
-- ----------------------------
INSERT INTO `meetingroom_selection` VALUES (1, '202010001', '202010001', '2025-04-23 20:50:01', 0.0);
INSERT INTO `meetingroom_selection` VALUES (1, '202020002', '202010001', '2025-04-24 05:21:43', 99.0);
INSERT INTO `meetingroom_selection` VALUES (1, '202020002', '202010002', '2025-04-24 05:21:58', 0.0);

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
INSERT INTO `refresh_token` VALUES ('202500001', '76f07224-24f7-482c-a98b-da8329877234', '2025-06-13 01:47:02', '2025-05-14 01:47:02');

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
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_customer_info` AS select `u`.`user_id` AS `user_id`,`ui`.`name` AS `name`,(case when (`ui`.`gender` is null) then NULL when (`ui`.`gender` = 1) then '男' else '女' end) AS `gender`,`ui`.`birthday` AS `birthday`,`ui`.`phone_number` AS `phone_number`,`ui`.`email` AS `email`,`ui`.`start_year` AS `start_year`,`m`.`major_name` AS `major`,`d`.`department_name` AS `department_name`,`c`.`pricePerHour` AS `pricePerHour` from (((((`user` `u` join `role` `r` on((`u`.`role_id` = `r`.`role_id`))) left join `user_info` `ui` on((`u`.`user_id` = `ui`.`user_id`))) left join `customer_info` `c` on((`u`.`user_id` = `c`.`user_id`))) left join `major` `m` on((`c`.`major_id` = `m`.`major_id`))) left join `department` `d` on((`m`.`department_id` = `d`.`department_id`))) where (`r`.`role_name` = 'customer');

-- ----------------------------
-- View structure for v_employee_info
-- ----------------------------
DROP VIEW IF EXISTS `v_employee_info`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_employee_info` AS select `u`.`user_id` AS `user_id`,`ui`.`name` AS `name`,(case when (`ui`.`gender` is null) then NULL when (`ui`.`gender` = 1) then '男' else '女' end) AS `gender`,`ui`.`birthday` AS `birthday`,`ui`.`phone_number` AS `phone_number`,`ui`.`email` AS `email`,`ui`.`start_year` AS `start_year`,`t`.`title_name` AS `title`,`d`.`department_name` AS `department_name` from (((((`user` `u` join `role` `r` on((`u`.`role_id` = `r`.`role_id`))) left join `user_info` `ui` on((`u`.`user_id` = `ui`.`user_id`))) left join `employee_info` `ei` on((`u`.`user_id` = `ei`.`user_id`))) left join `title` `t` on((`ei`.`title_id` = `t`.`title_id`))) left join `department` `d` on((`ei`.`department_id` = `d`.`department_id`))) where (`r`.`role_name` = 'employee');

-- ----------------------------
-- View structure for v_meetingroom_info
-- ----------------------------
DROP VIEW IF EXISTS `v_meetingroom_info`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_meetingroom_info` AS select `mr`.`meeting_room_id` AS `meeting_room_id`,`mr`.`meeting_room_name` AS `meeting_room_name`,`mr`.`pricePerHour` AS `pricePerHour`,`mr`.`description` AS `description`,`mr`.`creator_id` AS `creator_id`,`ui_creator`.`name` AS `creator_name`,`d`.`department_id` AS `department_id`,`d`.`department_name` AS `department_name`,count(`ce`.`user_id`) AS `employee_count` from (((`meetingroom` `mr` left join `department` `d` on((`mr`.`department_id` = `d`.`department_id`))) left join `user_info` `ui_creator` on((`mr`.`creator_id` = `ui_creator`.`user_id`))) left join `meetingroom_employee` `ce` on((`mr`.`meeting_room_id` = `ce`.`meeting_room_id`))) group by `mr`.`meeting_room_id`,`mr`.`meeting_room_name`,`mr`.`pricePerHour`,`mr`.`description`,`mr`.`creator_id`,`ui_creator`.`name`,`d`.`department_id`,`d`.`department_name`;

-- ----------------------------
-- View structure for v_meetingroom_info_with_employee
-- ----------------------------
DROP VIEW IF EXISTS `v_meetingroom_info_with_employee`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_meetingroom_info_with_employee` AS select `mr`.`meeting_room_id` AS `meeting_room_id`,`mr`.`meeting_room_name` AS `meeting_room_name`,`mr`.`pricePerHour` AS `pricePerHour`,`mr`.`description` AS `description`,`mr`.`creator_id` AS `creator_id`,`ui_creator`.`name` AS `creator_name`,`d`.`department_id` AS `department_id`,`d`.`department_name` AS `department_name`,`v_employee_info`.`user_id` AS `employee_id`,`v_employee_info`.`name` AS `employee_name`,`v_employee_info`.`title` AS `employee_title_name`,`v_employee_info`.`department_name` AS `employee_department_name`,count(`mr_selection`.`customer_id`) AS `customer_count` from (((((`meetingroom` `mr` left join `department` `d` on((`mr`.`department_id` = `d`.`department_id`))) left join `user_info` `ui_creator` on((`mr`.`creator_id` = `ui_creator`.`user_id`))) left join `meetingroom_employee` `mre` on((`mr`.`meeting_room_id` = `mre`.`meeting_room_id`))) left join `v_employee_info` on((`mre`.`user_id` = `v_employee_info`.`user_id`))) left join `meetingroom_selection` `mr_selection` on(((`mr`.`meeting_room_id` = `mr_selection`.`meeting_room_id`) and (`v_employee_info`.`user_id` = `mr_selection`.`employee_id`)))) group by `mr`.`meeting_room_id`,`mr`.`meeting_room_name`,`mr`.`pricePerHour`,`mr`.`description`,`mr`.`creator_id`,`ui_creator`.`name`,`d`.`department_id`,`d`.`department_name`,`v_employee_info`.`user_id`,`v_employee_info`.`name`,`v_employee_info`.`title`,`v_employee_info`.`department_name`;

-- ----------------------------
-- View structure for v_meetingroom_selection_info
-- ----------------------------
DROP VIEW IF EXISTS `v_meetingroom_selection_info`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_meetingroom_selection_info` AS select `cs`.`meeting_room_id` AS `meeting_room_id`,`mr`.`meeting_room_name` AS `meeting_room_name`,`mr`.`pricePerHour` AS `pricePerHour`,`mr`.`description` AS `description`,`cs`.`customer_id` AS `customer_id`,`ui_customer`.`name` AS `customer_name`,`cs`.`employee_id` AS `employee_id`,`ui_employee`.`name` AS `employee_name`,`cs`.`selection_time` AS `selection_time`,`cs`.`score` AS `score`,`d`.`department_name` AS `department_name` from ((((`meetingroom_selection` `cs` join `meetingroom` `mr` on((`cs`.`meeting_room_id` = `mr`.`meeting_room_id`))) left join `user_info` `ui_customer` on((`cs`.`customer_id` = `ui_customer`.`user_id`))) left join `user_info` `ui_employee` on((`cs`.`employee_id` = `ui_employee`.`user_id`))) left join `department` `d` on((`mr`.`department_id` = `d`.`department_id`)));

-- ----------------------------
-- View structure for v_user_info
-- ----------------------------
DROP VIEW IF EXISTS `v_user_info`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_user_info` AS select `user`.`user_id` AS `user_id`,`role`.`role_name` AS `role_name` from (`user` join `role` on((`user`.`role_id` = `role`.`role_id`)));

SET FOREIGN_KEY_CHECKS = 1;
