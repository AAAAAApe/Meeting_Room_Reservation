package com.BookRoom.entity.view;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("v_meetingRoom_selection_info")
public class MeetingRoomSelectView {
    private Integer meetingRoomId;
    private String meetingRoomName;
    private Double credit;
    private String description;
    private String customerId;
    private String customerName;
    private String employeeId;
    private String employeeName;
    private LocalDateTime selectionTime;
    private Double score;
    private String departmentName;
}
