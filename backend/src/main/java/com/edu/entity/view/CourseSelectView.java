package com.edu.entity.view;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("v_course_select_info")
public class CourseSelectView {
    @TableField(value = "course_id")
    private Integer courseId;         // 课程ID
    
    @TableField(value = "course_name")
    private String courseName;        // 课程名称
    
    @TableField(value = "course_department")
    private String courseDepartment;  // 课程所属院系
    
    @TableField(value = "credit")
    private Double credit;            // 学分
    
    @TableField(value = "student_id")
    private String studentId;         // 学生ID
    
    @TableField(value = "student_name")
    private String studentName;       // 学生姓名
    
    @TableField(value = "teacher_id")
    private String teacherId;         // 教师ID
    
    @TableField(value = "teacher_name")
    private String teacherName;       // 教师姓名
    
    @TableField(value = "selection_time")
    private LocalDateTime selectionTime;  // 选课时间
    
    @TableField(value = "score")
    private Double score;             // 成绩
    
    @TableField(value = "description")
    private String description;       // 课程描述
}
