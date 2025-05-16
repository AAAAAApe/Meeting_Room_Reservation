package com.BookRoom.entity.view;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDate;

@Data
@TableName("v_customer_info")
public class CustomerView {
    @TableId(value = "user_id")
    private String userId;         // 用户ID
    private String name;    // 顾客姓名
    private String gender;        // 性别
    private LocalDate birthday;    // 生日
    private String phoneNumber;    // 电话号码
    private String email;          // 邮箱
    private Integer startYear;     // 入学年份
    private Double pricePerHour;         // 价格
} 