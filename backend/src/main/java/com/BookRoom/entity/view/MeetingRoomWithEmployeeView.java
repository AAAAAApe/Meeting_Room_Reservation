package com.BookRoom.entity.view;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.math.BigInteger;

@Data
@TableName("v_meetingRoom_info_with_employee")
public class MeetingRoomWithEmployeeView {
    private Integer meetingRoomId;
    private String meetingRoomName;
    private Double credit;
    private String description;
    private String creatorId;
    private String creatorName;
    private String departmentId;
    private String departmentName;
    private String employeeId;
    private String employeeName;
    private String employeeTitleName;
    private String employeeDepartmentName;
    private BigInteger customerCount;
}
