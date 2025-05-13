package com.BookRoom.service;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.BookRoom.entity.department.Department;
import com.BookRoom.mapper.DepartmentMapper;
import org.springframework.stereotype.Service;

@Service
public class DepartmentServiceImpl extends ServiceImpl<DepartmentMapper, Department> implements DepartmentService {
//    @Override
//    public List<Department> getDepartmentList() {
//        return List.of();
//    }
}
