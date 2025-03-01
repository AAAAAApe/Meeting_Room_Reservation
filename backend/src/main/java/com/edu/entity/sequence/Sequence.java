package com.edu.entity.sequence;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

@Data
@TableName("sequence")
public class Sequence {
    // userId format: year+role(to int)+currentValue
    // example: 2023+1+0001 = 2023010001 means the first teacher in 2023
    @TableId
    private Integer year;
    @TableId
    private String role;
    private Integer currentValue;
}
