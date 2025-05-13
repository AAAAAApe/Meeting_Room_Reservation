package com.BookRoom.entity.view;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("v_course_selection_info")
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
