package com.BookRoom.dto;


import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("cancellation_request")
public class CancelRequest {
    @TableId(type = IdType.AUTO)
    private Long id;

    private Integer meetingRoomId;

    private String customerId;

    private LocalDateTime requestTime;

    private String status; // 'pending', 'approved', 'rejected'

    private LocalDateTime reviewTime;

    private String reason; // 可选填写理由

    private Double refundAmount;
}


// 新增字段：取消的预约开始
