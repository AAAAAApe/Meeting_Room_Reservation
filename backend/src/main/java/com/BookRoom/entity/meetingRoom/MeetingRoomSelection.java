package com.BookRoom.entity.meetingRoom;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.github.jeffreyning.mybatisplus.anno.MppMultiId;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
@TableName("meetingRoom_selection")
public class MeetingRoomSelection {

    @TableId(type = IdType.AUTO)
    private Long id;  // 与表主键一致

    private Integer meetingRoomId;

    private String customerId;
    
    private LocalDateTime selectionTime;

    private LocalDateTime startTime;

    private LocalDateTime endTime;

    private Integer attendeesCount;

    private String status;

    private BigDecimal totalPrice;

    private String paymentStatus;

    private LocalDateTime paymentTime;

    private LocalDateTime cancellationTime;

    private BigDecimal refundAmount;

    private LocalDateTime createdAt;

    private LocalDateTime updatedAt;
}