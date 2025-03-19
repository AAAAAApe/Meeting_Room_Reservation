CREATE TABLE IF NOT EXISTS role
(
    role_id   TINYINT PRIMARY KEY,                                 -- 角色 ID
    role_name ENUM ('admin', 'student', 'teacher') NOT NULL UNIQUE -- 角色名称，唯一约束
);

CREATE TABLE IF NOT EXISTS title
(
    title_id   TINYINT PRIMARY KEY,                                                                     -- 职称 ID
    title_name ENUM ('professor', 'associate_professor', 'senior_lecturer', 'lecturer') NOT NULL UNIQUE -- 职称名称，唯一约束
);

CREATE TABLE IF NOT EXISTS sequence
(
    year          YEAR    NOT NULL, -- 年份，用于生成序列号
    role_id       TINYINT NOT NULL, -- 角色 ID，对应 role_id 表
    current_value INTEGER NOT NULL, -- 当前序列值
    PRIMARY KEY (year, role_id),
    FOREIGN KEY (role_id) REFERENCES role (role_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS user
(
    user_id            CHAR(9)     NOT NULL, -- 用户 ID，唯一标识用户
    encrypted_password VARCHAR(60) NOT NULL, -- 加密后的密码
    role_id            TINYINT     NOT NULL, -- 角色 ID，外键关联 role_id 表
    PRIMARY KEY (user_id),
    FOREIGN KEY (role_id) REFERENCES role (role_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS user_info
(
    user_id      CHAR(9)     NOT NULL, -- 用户 ID
    name         VARCHAR(20) NOT NULL, -- 姓名
    gender       BIT,                  -- 性别（0/1 表示）
    birthday     DATE,                 -- 生日
    phone_number VARCHAR(20),          -- 手机号
    email        VARCHAR(50),          -- 邮箱
    start_year   YEAR,                 -- 入学/入职年份
    PRIMARY KEY (user_id),
    FOREIGN KEY (user_id) REFERENCES user (user_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS department
(
    department_id   CHAR(2)     NOT NULL, -- 院系 ID
    department_name VARCHAR(20) NOT NULL, -- 院系名称
    PRIMARY KEY (department_id)
);

CREATE TABLE IF NOT EXISTS major
(
    major_id      CHAR(4)     NOT NULL, -- 专业 ID
    major_name    VARCHAR(20) NOT NULL, -- 专业名称
    department_id CHAR(2)     NOT NULL, -- 所属院系 ID
    PRIMARY KEY (major_id),
    FOREIGN KEY (department_id) REFERENCES department (department_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS student_info
(
    user_id  CHAR(9)       NOT NULL,                               -- 学生 ID
    major_id CHAR(4)       NOT NULL,                               -- 专业 ID
    credit   DECIMAL(4, 1) NOT NULL CHECK (credit >= 0) DEFAULT 0, -- 学分，初始值 0
    PRIMARY KEY (user_id),
    FOREIGN KEY (user_id) REFERENCES user (user_id) ON DELETE CASCADE,
    FOREIGN KEY (major_id) REFERENCES major (major_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS teacher_info
(
    user_id       CHAR(9) NOT NULL, -- 教师 ID
    title_id      TINYINT,          -- 职称
    department_id CHAR(2),          -- 所属院系
    PRIMARY KEY (user_id),
    FOREIGN KEY (user_id) REFERENCES user (user_id) ON DELETE CASCADE,
    FOREIGN KEY (department_id) REFERENCES department (department_id) ON DELETE SET NULL,
    FOREIGN KEY (title_id) REFERENCES title (title_id) ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS course
(
    course_id         INTEGER       NOT NULL AUTO_INCREMENT,      -- 课程 ID，自增
    course_name       VARCHAR(20)   NOT NULL,                     -- 课程名称
    creator_id        CHAR(9)       NOT NULL,                     -- 创建者 ID（教师/管理员）
    course_department CHAR(2)       NOT NULL,                     -- 所属院系 ID
    credit            DECIMAL(2, 1) NOT NULL CHECK (credit >= 0), -- 课程学分
    description       TEXT,                                       -- 课程描述
    PRIMARY KEY (course_id),
    FOREIGN KEY (creator_id) REFERENCES user (user_id) ON DELETE CASCADE,
    FOREIGN KEY (course_department) REFERENCES department (department_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS course_teacher
(
    course_id     INTEGER NOT NULL,                    -- 课程 ID
    user_id       CHAR(9) NOT NULL,                    -- 教师 ID
    student_count INTEGER NOT NULL DEFAULT 0,          -- 选课人数
    PRIMARY KEY (course_id, user_id),
    FOREIGN KEY (course_id) REFERENCES course (course_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES user (user_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS course_selection
(
    course_id      INTEGER       NOT NULL,                                 -- 课程 ID
    student_id     CHAR(9)       NOT NULL,                                 -- 学生 ID
    teacher_id     CHAR(9)       NOT NULL,                                 -- 教师 ID
    selection_time DATETIME      NOT NULL DEFAULT NOW(),                   -- 选课时间
    score          DECIMAL(4, 1) NOT NULL CHECK (score BETWEEN 0 AND 100), -- 课程成绩
    PRIMARY KEY (course_id, student_id, teacher_id),
    FOREIGN KEY (course_id) REFERENCES course (course_id) ON DELETE CASCADE,
    FOREIGN KEY (student_id) REFERENCES user (user_id) ON DELETE CASCADE,
    FOREIGN KEY (teacher_id) REFERENCES user (user_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS teaching_resource
(
    resource_id   CHAR(36)     NOT NULL,               -- 资源唯一 ID
    resource_name VARCHAR(100) NOT NULL,               -- 资源名称
    course_id     INTEGER      NOT NULL,               -- 课程 ID
    uploader_id   CHAR(9)      NOT NULL,               -- 上传者 ID
    resource_url  VARCHAR(255) NOT NULL,               -- 资源存储路径
    upload_time   DATETIME     NOT NULL DEFAULT NOW(), -- 上传时间
    PRIMARY KEY (resource_id),
    FOREIGN KEY (course_id) REFERENCES course (course_id) ON DELETE CASCADE,
    FOREIGN KEY (uploader_id) REFERENCES user (user_id) ON DELETE CASCADE,
    UNIQUE (resource_name, course_id, uploader_id)     -- 确保同一教师的某门课程的资源名称唯一
);

CREATE TABLE IF NOT EXISTS assignment
(
    assignment_title    VARCHAR(100) NOT NULL,                            -- 作业标题
    course_id           INTEGER      NOT NULL,                            -- 课程 ID
    teacher_id          CHAR(9)      NOT NULL,                            -- 教师 ID
    submission_deadline DATETIME     NOT NULL,                            -- 学生提交截止时间
    content             TEXT,                                             -- 作业内容
    submission_url      VARCHAR(255),                                     -- 提交链接
    grade               ENUM ('A', 'B', 'C', 'D', 'E', 'F') DEFAULT NULL, -- 评分
    PRIMARY KEY (assignment_title, course_id, teacher_id),
    FOREIGN KEY (course_id) REFERENCES course (course_id) ON DELETE CASCADE,
    FOREIGN KEY (teacher_id) REFERENCES user (user_id) ON DELETE CASCADE
);

-- 创建触发器：当学生选课时，自动增加对应教师课程的选课人数
DELIMITER //
CREATE TRIGGER IF NOT EXISTS after_course_selection_insert
AFTER INSERT ON course_selection
FOR EACH ROW
BEGIN
    UPDATE course_teacher
    SET student_count = student_count + 1
    WHERE course_id = NEW.course_id AND user_id = NEW.teacher_id;
END //
DELIMITER ;

-- 创建触发器：当学生退课时，自动减少对应教师课程的选课人数
DELIMITER //
CREATE TRIGGER IF NOT EXISTS after_course_selection_delete
AFTER DELETE ON course_selection
FOR EACH ROW
BEGIN
    UPDATE course_teacher
    SET student_count = student_count - 1
    WHERE course_id = OLD.course_id AND user_id = OLD.teacher_id;
END //
DELIMITER ;