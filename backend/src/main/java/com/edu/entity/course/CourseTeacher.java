package com.edu.entity.course;

import com.baomidou.mybatisplus.annotation.TableName;
import com.github.jeffreyning.mybatisplus.anno.MppMultiId;
import lombok.Data;

@Data
@TableName("course_teacher")
public class CourseTeacher {
    @MppMultiId
    private Integer courseId;
    @MppMultiId
    private String userId;
}