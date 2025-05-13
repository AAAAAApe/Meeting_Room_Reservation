package com.BookRoom.dto;

/**
 * 选课请求DTO
 */
public record MeetingRoomSelectRequest(
    Integer meetingRoomId,
    String employeeId
) {}