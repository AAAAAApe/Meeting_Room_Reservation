package com.BookRoom.entity.meetingRoom;

import com.baomidou.mybatisplus.annotation.TableName;
import com.github.jeffreyning.mybatisplus.anno.MppMultiId;
import lombok.Data;

@Data
@TableName("meetingRoom_employee")
public class MeetingRoomEmployee {
    @MppMultiId
    private Integer meetingRoomId;
    @MppMultiId
    private String userId;
}