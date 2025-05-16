package com.BookRoom.entity.view;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
@TableName("v_meetingRoom_selection_info") // 确认视图名称与实际一致
public class MeetingRoomSelectView {
    // 会议室基础信息
    @TableField("meeting_room_id")
    private Integer meetingRoomId;

    @TableField("meeting_room_name")
    private String meetingRoomName;

    @TableField("price_per_hour")
    private BigDecimal pricePerHour; // 【修正】使用精确类型

    @TableField("capacity")
    private Integer capacity;

    @TableField("type")
    private String type;

    // 会议室状态（原 mr.status）
    @TableField("room_status")
    private String roomStatus; // 【修正】重命名字段

    @TableField("has_projector")
    private Boolean hasProjector;

    @TableField("has_audio")
    private Boolean hasAudio;

    @TableField("has_network")
    private Boolean hasNetwork;

    // 订单信息
    @TableField("customer_id")
    private String customerId;

    @TableField("customer_name")
    private String customerName;

    @TableField("selection_time")
    private LocalDateTime selectionTime;

    @TableField("start_time")
    private LocalDateTime startTime;

    @TableField("end_time")
    private LocalDateTime endTime;

    @TableField("attendees_count")
    private Integer attendeesCount;

    // 订单状态（原 cs.status）
    @TableField("order_status")
    private String orderStatus; // 【修正】重命名字段

    @TableField("total_price")
    private BigDecimal totalPrice;

    @TableField("payment_status")
    private String paymentStatus;

    @TableField("payment_time")
    private LocalDateTime paymentTime;

    @TableField("cancellation_time")
    private LocalDateTime cancellationTime;

    @TableField("refund_amount")
    private BigDecimal refundAmount;
}