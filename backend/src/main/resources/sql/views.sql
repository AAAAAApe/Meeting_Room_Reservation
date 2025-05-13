CREATE OR REPLACE VIEW v_user_info AS
SELECT
    user.user_id,
    role.role_name
FROM
    user NATURAL JOIN role;

-- 顾客详细信息视图
CREATE OR REPLACE VIEW v_customer_info AS
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
    LEFT JOIN customer_info s ON u.user_id = s.user_id
    LEFT JOIN major m ON s.major_id = m.major_id
    LEFT JOIN department d ON m.department_id = d.department_id
WHERE 
    r.role_name = 'customer';

-- 员工详细信息视图
CREATE OR REPLACE VIEW v_employee_info AS
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
    LEFT JOIN employee_info ti ON u.user_id = ti.user_id
    LEFT JOIN title t ON ti.title_id = t.title_id
    LEFT JOIN department d ON ti.department_id = d.department_id
WHERE 
    r.role_name = 'employee';

-- 会议室详细信息视图
CREATE OR REPLACE VIEW v_meetingRoom_info AS
SELECT 
    c.meetingRoom_id,
    c.meetingRoom_name,
    c.credit,
    c.description,
    c.creator_id,
    ui_creator.name AS creator_name,
    d.department_id,
    d.department_name,
    COUNT(ct.user_id) AS employee_count
FROM 
    meetingRoom c
    LEFT JOIN department d ON c.department_id = d.department_id
    LEFT JOIN user_info ui_creator ON c.creator_id = ui_creator.user_id
    LEFT JOIN meetingRoom_employee ct ON c.meetingRoom_id = ct.meetingRoom_id
GROUP BY
    c.meetingRoom_id,
    c.meetingRoom_name,
    c.credit,
    c.description,
    c.creator_id,
    ui_creator.name,
    d.department_id,
    d.department_name;

CREATE OR REPLACE VIEW v_meetingRoom_info_with_employee AS
SELECT
    c.meetingRoom_id,
    c.meetingRoom_name,
    c.credit,
    c.description,
    c.creator_id,
    ui_creator.name AS creator_name,
    d.department_id,
    d.department_name,
    v_employee_info.user_id AS employee_id,
    v_employee_info.name AS employee_name,
    v_employee_info.title AS employee_title_name,
    v_employee_info.department_name AS employee_department_name,
    COUNT(cs.customer_id) AS customer_count
FROM
    meetingRoom c
        LEFT JOIN department d ON c.department_id = d.department_id
        LEFT JOIN user_info ui_creator ON c.creator_id = ui_creator.user_id
        LEFT JOIN meetingRoom_employee ct ON c.meetingRoom_id = ct.meetingRoom_id
        LEFT JOIN v_employee_info ON ct.user_id = v_employee_info.user_id
        LEFT JOIN meetingRoom_selection cs ON c.meetingRoom_id = cs.meetingRoom_id AND v_employee_info.user_id = cs.employee_id
GROUP BY
    c.meetingRoom_id,
    c.meetingRoom_name,
    c.credit,
    c.description,
    c.creator_id,
    ui_creator.name,
    d.department_id,
    d.department_name,
    v_employee_info.user_id,
    v_employee_info.name,
    v_employee_info.title,
    v_employee_info.department_name;

CREATE OR REPLACE VIEW v_meetingRoom_selection_info AS
SELECT 
    cs.meetingRoom_id,
    c.meetingRoom_name,
    c.credit,
    c.description,
    cs.customer_id,
    ui_customer.name AS customer_name,
    cs.employee_id,
    ui_employee.name AS employee_name,
    cs.selection_time,
    cs.score,
    d.department_name
FROM 
    meetingRoom_selection cs
    INNER JOIN meetingRoom c ON cs.meetingRoom_id = c.meetingRoom_id
    LEFT JOIN user_info ui_customer ON cs.customer_id = ui_customer.user_id
    LEFT JOIN user_info ui_employee ON cs.employee_id = ui_employee.user_id
    LEFT JOIN department d ON c.department_id = d.department_id;

-- 顾客作业信息视图
CREATE OR REPLACE VIEW v_customer_assignment_info AS
SELECT 
    a.assignment_title,
    a.meetingRoom_id,
    c.meetingRoom_name,
    a.employee_id,
    ui_employee.name AS employee_name,
    sa.customer_id,
    ui_customer.name AS customer_name,
    a.submission_deadline,
    a.content AS assignment_content,
    a.submission_url,
    sa.grade
FROM 
    assignment a
    INNER JOIN meetingRoom c ON a.meetingRoom_id = c.meetingRoom_id
    LEFT JOIN user_info ui_employee ON a.employee_id = ui_employee.user_id
    LEFT JOIN customer_assignment sa ON a.assignment_title = sa.assignment_title
        AND a.meetingRoom_id = sa.meetingRoom_id
        AND a.employee_id = sa.employee_id
    LEFT JOIN user_info ui_customer ON sa.customer_id = ui_customer.user_id;