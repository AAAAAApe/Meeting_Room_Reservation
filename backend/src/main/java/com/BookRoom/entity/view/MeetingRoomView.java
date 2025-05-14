package com.BookRoom.entity.view;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.math.BigInteger;

@Data
@TableName("v_meetingRoom_info")
public class MeetingRoomView {
    private Integer meetingRoomId;
    private String meetingRoomName;
    private Double pricePerHour;
    private String description;
    private Integer capacity;
    private String type;
    private String status;
    private Boolean hasProjector;   
    private Boolean hasAudio;       
    private Boolean hasNetwork;     
    private String creatorId;
    private String creatorName;
    private String departmentId;
    private String departmentName;
    private BigInteger employeeCount;
}
