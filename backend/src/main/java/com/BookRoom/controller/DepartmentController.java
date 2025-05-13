package com.BookRoom.controller;

import com.BookRoom.entity.department.Department;
import com.BookRoom.service.DepartmentService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class DepartmentController {
    private final DepartmentService departmentService;

    public DepartmentController(DepartmentService departmentService) {
        this.departmentService = departmentService;
    }

    @GetMapping("/department/getAll")
    public List<Department> getDepartmentList() {
        return departmentService.list();
    }
}
