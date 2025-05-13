package com.BookRoom.entity.account;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

@Data
@TableName("role_id")
public class Role {
    @TableId
    private Byte roleId;
    private String roleName;
}
