package com.edu.entity.teaching;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("teaching_resource")
public class TeachingResource {
    @TableId
    private String resourceId;
    private String resourceName;
    private String courseId;
    private String uploaderId;
    private String resourceUrl;
    private LocalDateTime uploadTime;
} 