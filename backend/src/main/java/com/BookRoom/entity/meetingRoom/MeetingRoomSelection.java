package com.BookRoom.entity.meetingRoom;

import com.baomidou.mybatisplus.annotation.TableName;
import com.github.jeffreyning.mybatisplus.anno.MppMultiId;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("meetingRoom_selection")
public class MeetingRoomSelection {
    @MppMultiId
    private Integer meetingRoomId;
    
    @MppMultiId
    private String customerId;
    
    @MppMultiId
    private String employeeId;
    
    private LocalDateTime selectionTime;
    private Double score;
}