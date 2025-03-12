package com.edu.entity.course;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.github.jeffreyning.mybatisplus.anno.MppMultiId;
import lombok.Data;

@Data
@TableName("course_teacher")
public class CourseTeacher {
    @MppMultiId
    @TableField(value = "course_id")
    private String courseId;
    
    @MppMultiId
    @TableField(value = "user_id")
    private String userId;
} 