package com.BookRoom.entity.teaching;

import com.baomidou.mybatisplus.annotation.TableName;
import com.github.jeffreyning.mybatisplus.anno.MppMultiId;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("assignment")
public class Assignment {
    @MppMultiId
    private String assignmentTitle;
    
    @MppMultiId
    private String courseId;
    
    @MppMultiId
    private String teacherId;
    
    private LocalDateTime submissionDeadline;
    private String content;
    private String submissionUrl;
    private String grade;
} 