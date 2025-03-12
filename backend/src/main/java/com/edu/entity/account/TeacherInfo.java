package com.edu.entity.account;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

@Data
@TableName("teacher_info")
public class TeacherInfo {
    @TableId
    private String userId;
    private String title;
    private String departmentId;
}
