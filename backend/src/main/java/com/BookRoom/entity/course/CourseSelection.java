package com.BookRoom.entity.course;

import com.baomidou.mybatisplus.annotation.TableName;
import com.github.jeffreyning.mybatisplus.anno.MppMultiId;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("course_selection")
public class CourseSelection {
    @MppMultiId
    private Integer courseId;
    
    @MppMultiId
    private String studentId;
    
    @MppMultiId
    private String teacherId;
    
    private LocalDateTime selectionTime;
    private Double score;
}