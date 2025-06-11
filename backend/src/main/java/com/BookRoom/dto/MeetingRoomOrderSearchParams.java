package com.BookRoom.dto;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class MeetingRoomOrderSearchParams {
    private Integer meetingRoomId;
    private String customerId;
    private String status;
    private LocalDateTime startTime;
    private LocalDateTime endTime;

    // getter & setter 省略，可用 @Data 注解
}
