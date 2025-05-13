package com.BookRoom.dto;

/**
 * 选课请求DTO
 */
public record CourseSelectRequest(
    Integer courseId,
    String teacherId
) {}