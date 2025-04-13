CREATE OR REPLACE VIEW v_user_info AS
SELECT
    user.user_id,
    role.role_name
FROM
    user NATURAL JOIN role;

-- 学生详细信息视图
CREATE OR REPLACE VIEW v_student_info AS
SELECT 
    u.user_id,
    ui.name,
    CASE WHEN ui.gender IS NULL THEN NULL WHEN ui.gender = 1 THEN '男' ELSE '女' END AS gender,
    ui.birthday,
    ui.phone_number,
    ui.email,
    ui.start_year,
    m.major_name AS major,
    d.department_name,
    s.credit
FROM 
    user u
    INNER JOIN role r ON u.role_id = r.role_id
    LEFT JOIN user_info ui ON u.user_id = ui.user_id
    LEFT JOIN student_info s ON u.user_id = s.user_id
    LEFT JOIN major m ON s.major_id = m.major_id
    LEFT JOIN department d ON m.department_id = d.department_id
WHERE 
    r.role_name = 'student';

-- 教师详细信息视图
CREATE OR REPLACE VIEW v_teacher_info AS
SELECT 
    u.user_id,
    ui.name,
    CASE WHEN ui.gender IS NULL THEN NULL WHEN ui.gender = 1 THEN '男' ELSE '女' END AS gender,
    ui.birthday,
    ui.phone_number,
    ui.email,
    ui.start_year,
    t.title_name AS title,
    d.department_name
FROM 
    user u
    INNER JOIN role r ON u.role_id = r.role_id
    LEFT JOIN user_info ui ON u.user_id = ui.user_id
    LEFT JOIN teacher_info ti ON u.user_id = ti.user_id
    LEFT JOIN title t ON ti.title_id = t.title_id
    LEFT JOIN department d ON ti.department_id = d.department_id
WHERE 
    r.role_name = 'teacher'; 

-- 课程详细信息视图
CREATE OR REPLACE VIEW v_course_info AS
SELECT 
    c.course_id,
    c.course_name,
    c.credit,
    c.description,
    c.creator_id,
    ui_creator.name AS creator_name,
    d.department_id,
    d.department_name,
    COUNT(ct.user_id) AS teacher_count
FROM 
    course c
    LEFT JOIN department d ON c.department_id = d.department_id
    LEFT JOIN user_info ui_creator ON c.creator_id = ui_creator.user_id
    LEFT JOIN course_teacher ct ON c.course_id = ct.course_id
GROUP BY
    c.course_id,
    c.course_name,
    c.credit,
    c.description,
    c.creator_id,
    ui_creator.name,
    d.department_id,
    d.department_name;

CREATE OR REPLACE VIEW v_course_info_with_teacher AS
SELECT
    c.course_id,
    c.course_name,
    c.credit,
    c.description,
    c.creator_id,
    ui_creator.name AS creator_name,
    d.department_id,
    d.department_name,
    v_teacher_info.user_id AS teacher_id,
    v_teacher_info.name AS teacher_name,
    v_teacher_info.title AS teacher_title_name,
    v_teacher_info.department_name AS teacher_department_name,
    COUNT(cs.student_id) AS student_count
FROM
    course c
        LEFT JOIN department d ON c.department_id = d.department_id
        LEFT JOIN user_info ui_creator ON c.creator_id = ui_creator.user_id
        LEFT JOIN course_teacher ct ON c.course_id = ct.course_id
        LEFT JOIN v_teacher_info ON ct.user_id = v_teacher_info.user_id
        LEFT JOIN course_selection cs ON c.course_id = cs.course_id AND v_teacher_info.user_id = cs.teacher_id
GROUP BY
    c.course_id,
    c.course_name,
    c.credit,
    c.description,
    c.creator_id,
    ui_creator.name,
    d.department_id,
    d.department_name,
    v_teacher_info.user_id,
    v_teacher_info.name,
    v_teacher_info.title,
    v_teacher_info.department_name;

CREATE OR REPLACE VIEW v_course_selection_info AS
SELECT 
    cs.course_id,
    c.course_name,
    c.credit,
    c.description,
    cs.student_id,
    ui_student.name AS student_name,
    cs.teacher_id,
    ui_teacher.name AS teacher_name,
    cs.selection_time,
    cs.score,
    d.department_name
FROM 
    course_selection cs
    INNER JOIN course c ON cs.course_id = c.course_id
    LEFT JOIN user_info ui_student ON cs.student_id = ui_student.user_id
    LEFT JOIN user_info ui_teacher ON cs.teacher_id = ui_teacher.user_id
    LEFT JOIN department d ON c.department_id = d.department_id;