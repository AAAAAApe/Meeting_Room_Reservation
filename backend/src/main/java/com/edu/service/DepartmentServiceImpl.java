package com.edu.service;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.edu.entity.department.Department;
import com.edu.mapper.DepartmentMapper;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DepartmentServiceImpl extends ServiceImpl<DepartmentMapper, Department> implements DepartmentService {
//    @Override
//    public List<Department> getDepartmentList() {
//        return List.of();
//    }
}
