package com.BookRoom.entity.view;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.math.BigInteger;

@Data
@TableName("v_course_info")
public class CourseView {
    private Integer courseId;
    private String courseName;
    private Double credit;
    private String description;
    private String creatorId;
    private String creatorName;
    private String departmentId;
    private String departmentName;
    private BigInteger teacherCount;
}
