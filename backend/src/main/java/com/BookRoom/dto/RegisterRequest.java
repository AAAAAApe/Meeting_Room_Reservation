package com.BookRoom.dto;

import lombok.Data;

import java.time.LocalDate;

// 注册请求参数
@Data
public class RegisterRequest {
    // 注册类型
    private String roleType;
    // 用户基本信息
    private String name;
    private String password;
    // 可选信息
    private Integer gender;
    private LocalDate birthday;
    private String phoneNumber;
    private String email;
}