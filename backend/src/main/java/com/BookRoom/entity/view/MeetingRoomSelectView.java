package com.BookRoom.entity.view;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
@TableName("v_meetingRoom_selection_info")
public class MeetingRoomSelectView {
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
    private String customerId;
    private String customerName;
    private LocalDateTime selectionTime;
    private Double score;
    private String departmentName;

    private LocalDateTime startTime;
    private LocalDateTime endTime;
    private Integer attendeesCount;
    private BigDecimal totalPrice;
    private String paymentStatus;
    private LocalDateTime paymentTime;
    private LocalDateTime cancellationTime;
    private BigDecimal refundAmount;

}