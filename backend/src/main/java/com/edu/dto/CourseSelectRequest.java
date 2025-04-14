package com.edu.dto;

/**
 * 选课请求DTO
 */
public record CourseSelectRequest(
    Integer courseId,
    String teacherId
) {}