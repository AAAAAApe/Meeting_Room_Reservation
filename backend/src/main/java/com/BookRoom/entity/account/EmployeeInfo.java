package com.BookRoom.entity.account;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

@Data
@TableName("employee_info")
public class EmployeeInfo {
    @TableId
    private String userId;
}
