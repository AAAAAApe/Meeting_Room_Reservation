package com.edu.entity.account;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

@Data
@TableName("student_info")
public class StudentInfo {
    @TableId
    private String userId;
    private String majorId;
    private Double credit;
}
