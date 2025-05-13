package com.BookRoom.entity.view;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.math.BigInteger;

@Data
@TableName("v_course_info_with_teacher")
public class CourseWithTeacherView {
    private Integer courseId;
    private String courseName;
    private Double credit;
    private String description;
    private String creatorId;
    private String creatorName;
    private String departmentId;
    private String departmentName;
    private String teacherId;
    private String teacherName;
    private String teacherTitleName;
    private String teacherDepartmentName;
    private BigInteger studentCount;
}
