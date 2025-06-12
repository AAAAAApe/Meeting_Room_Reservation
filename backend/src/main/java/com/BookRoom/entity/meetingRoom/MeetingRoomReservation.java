package com.BookRoom.entity.meetingRoom;

import lombok.Data;

import java.time.LocalDateTime;


@Data
public class MeetingRoomReservation {
    private Long id;
    private Long roomId;
    private String userId;
    private LocalDateTime startTime;
    private LocalDateTime endTime;
}
