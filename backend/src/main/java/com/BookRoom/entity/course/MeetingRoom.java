package com.BookRoom.entity.meetingRoom;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

@Data
@TableName("meetingRoom")
public class MeetingRoom {
    @TableId(type = IdType.AUTO)
    private Integer meetingRoomId;
    private String meetingRoomName;
    private String creatorId;
    private String departmentId;
    private Double credit;
    private String description;
}
