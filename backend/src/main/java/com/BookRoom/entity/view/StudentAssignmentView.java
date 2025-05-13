package com.BookRoom.entity.view;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("v_student_assignment_info")
public class StudentAssignmentView {
    String assignmentTitle;
    Integer courseId;
    String courseName;
    String teacherId;
    String teacherName;
    String studentId;
    String studentName;
    LocalDateTime submissionDeadline;
    String assignmentContent;
    String submissionUrl;
    String grade;
}
