package com.BookRoom.entity.view;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("v_customer_assignment_info")
public class CustomerAssignmentView {
    String assignmentTitle;
    Integer meetingRoomId;
    String meetingRoomName;
    String employeeId;
    String employeeName;
    String customerId;
    String customerName;
    LocalDateTime submissionDeadline;
    String assignmentContent;
    String submissionUrl;
    String grade;
}
