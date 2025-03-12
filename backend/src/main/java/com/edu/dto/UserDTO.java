package com.edu.dto;

import lombok.Data;

@Data
public class UserDTO {
    private String userId;      // 用户ID
    private String role;        // 角色 (admin, student, teacher)

    // 学生相关信息
    private String studentName;
    private String major;
    private String phoneNumber;
    private String email;
    private Integer startYear;

    // 教师相关信息
    private String teacherName;
    private String title;
    private String departmentName;
}