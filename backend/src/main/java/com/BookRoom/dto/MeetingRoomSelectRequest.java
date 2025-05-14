package com.BookRoom.dto;

/**
 * 选会议室请求DTO
 */
public record MeetingRoomSelectRequest(
    Integer meetingRoomId,
    String startTime, // 使用 LocalDateTime.parse()
    String endTime
) {}