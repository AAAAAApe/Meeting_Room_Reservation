package com.edu.entity.sequence;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.github.jeffreyning.mybatisplus.anno.MppMultiId;
import lombok.Data;

@Data
@TableName("sequence")
public class Sequence {
    // userId format: year+role_id(to int)+currentValue
    // example: 2023+1+0001 = 2023010001 means the first teacher in 2023
    @MppMultiId
    @TableField(value = "year")
    private Integer year;
    @MppMultiId
    @TableField(value = "role_id")
    private Byte roleId;
    @TableField(value = "current_value")
    private Integer currentValue;
}
