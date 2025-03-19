package com.edu.entity.course;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.math.BigDecimal;

@Data
@TableName("course")
public class Course {
    @TableId
    private Integer courseId;
    private String courseName;
    private String creatorId;
    private String courseDepartment;
    private BigDecimal credit;
    private String description;
}
