package com.BookRoom.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.BookRoom.entity.teaching.Assignment;
import com.github.jeffreyning.mybatisplus.service.IMppService;

public interface AssignmentService extends IMppService<Assignment> {
    public Page<Assignment> getCourseAssignments(Integer courseId, String teacherId, long current, long size);
//    public Boolean publicAssignment(Assignment assignment);
}
