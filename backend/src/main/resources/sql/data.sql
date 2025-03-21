insert into role
values (0, 'admin'),
       (1, 'teacher'),
       (2, 'student');

insert into title
values (1, 'professor'),
       (2, 'associate_professor'),
       (3, 'senior_lecturer'),
       (4, 'lecturer');

insert into department
values ('01', '计算机学院'),
       ('02', '外国语学院'),
       ('03', '农学院'),
       ('04', '植物保护学院'),
       ('05', '工程学院'),
       ('06', '马克思注意学院'),
       ('07', '人文与法学学院'),
       ('08', '水利与土木工程学院'),
       ('09', '数学学院'),
       ('10', '公共管理学院');

insert into major
values ('0001', '计算机科学与技术', '01'),
       ('0002', '软件工程', '01'),
       ('0003', '人工智能', '01'),
       ('0101', '英语', '02'),
       ('0102', '日语', '02'),
       ('0201', '农学', '03'),
       ('0301', '植物保护', '04'),
       ('0401', '机械工程', '05'),
       ('0501', '马克思主义理论', '06'),
       ('0601', '法学', '07'),
       ('0701', '水利工程', '08'),
       ('0801', '应用数学', '09'),
       ('0901', '行政管理', '10');

insert into user
values ('202500001', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 0),
       ('202510001', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1),
       ('202510002', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1),
       ('202510003', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1),
       ('202510004', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1),
       ('202510005', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 1),
       ('202520001', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2),
       ('202520002', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2),
       ('202520003', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2),
       ('202520004', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2),
       ('202520005', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2),
       ('202520006', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2),
       ('202520007', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2),
       ('202520008', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 2);

insert into sequence
values ('2025', 0, 1),
       ('2025', 1, 5),
       ('2025', 2, 8);

insert into user_info
values ('202510001', '雷军', 1, '1969-12-16', '13720100406', 'leijun@xiaomi.com', '2025'),
       ('202510002', '马化腾', 1, '1971-10-29', '13720100408', 'pony@tencent.com', '2025'),
       ('202510003', '李娜', 0, '1982-02-26', '13720100409', 'lina@edu.cn', '2025'),
       ('202510004', '王刚', 1, '1975-07-18', '13720100410', 'wanggang@edu.cn', '2025'),
       ('202510005', '刘芳', 0, '1980-04-12', '13720100411', 'liufang@edu.cn', '2025'),
       ('202520001', '张三', 1, '2006-05-04', '13720100407', 'zhangsan@stu.edu.cn', '2025'),
       ('202520002', '李四', 1, '2006-08-15', '13720100412', 'lisi@stu.edu.cn', '2025'),
       ('202520003', '王五', 1, '2006-11-22', '13720100413', 'wangwu@stu.edu.cn', '2025'),
       ('202520004', '赵六', 1, '2007-01-30', '13720100414', 'zhaoliu@stu.edu.cn', '2025'),
       ('202520005', '钱七', 0, '2006-06-18', '13720100415', 'qianqi@stu.edu.cn', '2025'),
       ('202520006', '孙八', 1, '2006-09-25', '13720100416', 'sunba@stu.edu.cn', '2025'),
       ('202520007', '周九', 0, '2007-03-14', '13720100417', 'zhoujiu@stu.edu.cn', '2025'),
       ('202520008', '吴十', 1, '2006-12-05', '13720100418', 'wushi@stu.edu.cn', '2025');

insert into teacher_info
values ('202510001', 1, '01'),
       ('202510002', 1, '01'),
       ('202510003', 2, '02'),
       ('202510004', 3, '03'),
       ('202510005', 4, '04');

insert into student_info
values ('202520001', '0001', '0'),
       ('202520002', '0001', '12.5'),
       ('202520003', '0002', '25.0'),
       ('202520004', '0003', '18.5'),
       ('202520005', '0101', '30.0'),
       ('202520006', '0201', '15.0'),
       ('202520007', '0401', '22.5'),
       ('202520008', '0801', '28.0');

-- 重置AUTO_INCREMENT计数器，确保从1开始
ALTER TABLE course AUTO_INCREMENT = 1;

-- 添加课程数据
insert into course (course_name, creator_id, course_department, credit, description)
values ('数据结构', '202510001', '01', 4.0, '计算机科学与技术专业核心课程，介绍各种数据结构及其应用'),
       ('操作系统', '202510001', '01', 3.5, '计算机专业必修课程，介绍操作系统的基本原理和实现方法'),
       ('计算机网络', '202510002', '01', 3.0, '介绍计算机网络的基本概念、体系结构和协议'),
       ('高级英语', '202510003', '02', 2.0, '提高学生的英语听说读写能力'),
       ('农业生态学', '202510004', '03', 3.0, '研究农业生态系统的结构、功能及其与环境的关系'),
       ('植物病理学', '202510005', '04', 3.5, '研究植物疾病的发生、发展规律及防治方法');

-- 添加教师课程关联数据
insert into course_teacher
values (1, '202510001', 3),
       (2, '202510001', 2),
       (3, '202510002', 2),
       (4, '202510003', 1),
       (5, '202510004', 0),
       (6, '202510005', 0);

-- 添加选课数据
insert into course_selection
values (1, '202520001', '202510001', '2025-09-01 10:00:00', 85.5),
       (1, '202520002', '202510001', '2025-09-01 10:15:00', 92.0),
       (1, '202520003', '202510001', '2025-09-01 10:30:00', 78.5),
       (2, '202520001', '202510001', '2025-09-02 14:00:00', 88.0),
       (2, '202520002', '202510001', '2025-09-02 14:30:00', 90.5),
       (3, '202520003', '202510002', '2025-09-03 09:00:00', 82.0),
       (3, '202520004', '202510002', '2025-09-03 09:15:00', 75.5),
       (4, '202520005', '202510003', '2025-09-04 13:00:00', 95.0);

-- 添加教学资源数据
insert into teaching_resource
values ('a1b2c3d4-e5f6-7890-abcd-ef1234567890', '数据结构课件第一章', 1, '202510001', '/resources/data-structure/chapter1.pdf', '2025-08-25 08:30:00'),
       ('b2c3d4e5-f6a7-8901-bcde-f12345678901', '数据结构实验指导书', 1, '202510001', '/resources/data-structure/lab-guide.pdf', '2025-08-26 10:15:00'),
       ('c3d4e5f6-a7b8-9012-cdef-123456789012', '操作系统参考资料', 2, '202510001', '/resources/os/reference.pdf', '2025-08-27 14:20:00'),
       ('d4e5f6a7-b8c9-0123-defg-234567890123', '计算机网络课件', 3, '202510002', '/resources/network/slides.pptx', '2025-08-28 09:45:00');

-- 添加作业数据
insert into assignment
values ('数据结构第一次作业', 1, '202510001', '2025-09-15 23:59:59', '完成教材P25-P30的习题', '/assignments/ds-hw1', NULL),
       ('数据结构第二次作业', 1, '202510001', '2025-09-30 23:59:59', '实现一个简单的链表', '/assignments/ds-hw2', NULL),
       ('操作系统第一次作业', 2, '202510001', '2025-09-20 23:59:59', '分析进程调度算法', '/assignments/os-hw1', NULL),
       ('计算机网络作业', 3, '202510002', '2025-09-25 23:59:59', '分析TCP/IP协议', '/assignments/network-hw1', NULL);