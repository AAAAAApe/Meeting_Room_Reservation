package com.BookRoom.entity.meetingRoom;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.math.BigDecimal;

@Data
@TableName("meetingRoom")
public class MeetingRoom {
    @TableId(type = IdType.AUTO)
    private Integer meetingRoomId;
    private String meetingRoomName;
    private BigDecimal pricePerHour;
    private String type;
    private Integer capacity;
    private String status;
    private Boolean hasProjector;
    private Boolean hasAudio;
    private Boolean hasNetwork;
}