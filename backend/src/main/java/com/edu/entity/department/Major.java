package com.edu.entity.department;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

@Data
@TableName("major")
public class Major {
    @TableId
    private String majorId;
    private String majorName;
    private String departmentId;
}
