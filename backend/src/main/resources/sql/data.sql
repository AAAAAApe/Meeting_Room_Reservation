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
values ('01', '计算机学院');

insert into major
values ('0001', '计算机科学与技术', '01');

insert into user
values ('202500001', '$2a$10$4/dFbgH9MJ.RjFyPb8iFjOCbtlOYljZzrnyMGyau0hAkNdMZ2yoRO', 0),
       ('202510001', '$2a$10$XGVquL1/qRuKvJIqbCMdx.h.Ot09Fw9A0HTab.ENhg5lsJy9nxvtu', 1),
       ('202520001', '$2a$10$g/WZUoH2Uo5.o/zf0r0CBO/CCpfZE3wMf8NxtpLjb51m8ggMZc6bW', 2);

insert into sequence
values ('2025', 0, 1),
       ('2025', 1, 1),
       ('2025', 2, 1);

insert into user_info
values ('202510001', '雷军', 1, '1969-12-16', '13720100406', 'leijun@xiaomi.com', '2025'),
       ('202520001', '张三', 1, '2006-05-04', '13720100407', 'zhangsan@stu.edu.cn', '2025');

insert into teacher_info
values ('202510001', 1, '01');

insert into student_info
values ('202520001', '0001', '0');