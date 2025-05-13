package com.BookRoom.service;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.BookRoom.entity.teaching.Assignment;
import com.BookRoom.mapper.AssignmentMapper;
import com.github.jeffreyning.mybatisplus.service.MppServiceImpl;
import org.springframework.stereotype.Service;

@Service
public class AssignmentServiceImpl extends MppServiceImpl<AssignmentMapper, Assignment> implements AssignmentService {
    private final AssignmentMapper AssignmentMapper;

    public AssignmentServiceImpl(AssignmentMapper assignmentMapper) {
        AssignmentMapper = assignmentMapper;
    }

    @Override
    public Page<Assignment> getCourseAssignments(Integer courseId, String teacherId, long current, long size) {
        Page<Assignment> page = new Page<>(current, size);
        return AssignmentMapper.selectPage(page,
                new LambdaQueryWrapper<Assignment>()
                        .eq(Assignment::getCourseId, courseId)
                        .eq(Assignment::getTeacherId, teacherId)
                );
    }

//    @Override
//    public Boolean publicAssignment(Assignment assignment) {
//        return null;
//    }
}
