package com.BookRoom.entity.account;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDate;

@Data
@TableName("user_info")
public class UserInfo {
    @TableId
    private String userId;
    private String name;
    private Boolean gender;
    private LocalDate birthday;
    private String phoneNumber;
    private String email;
    private Integer startYear;
}
