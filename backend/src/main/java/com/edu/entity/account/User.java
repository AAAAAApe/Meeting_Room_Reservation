package com.edu.entity.account;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

@Data
@TableName("user")
public class User
{
    @TableId
    private String userId;
    private String hashedPassword;
    private String role;
}
