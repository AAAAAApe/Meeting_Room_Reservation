package com.BookRoom.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.time.LocalDateTime;

@Data
public class MeetingRoomFilterRequest {
    private Integer current = 1;
    private Integer size = 16;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime startTime;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime endTime;

    private Boolean hasProjector;
    private Boolean hasAudio;
    private Boolean hasNetwork;
}
