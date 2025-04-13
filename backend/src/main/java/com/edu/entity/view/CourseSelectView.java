package com.edu.entity.view;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("v_course_select_info")
public class CourseSelectView {
    private Integer courseId;
    private String courseName;
    private Double credit;
    private String description;
    private String studentId;
    private String studentName;
    private String teacherId;
    private String teacherName;
    private LocalDateTime selectionTime;
    private Double score;
    private String departmentName;
}
