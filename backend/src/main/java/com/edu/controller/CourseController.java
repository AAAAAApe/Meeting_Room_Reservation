package com.edu.controller;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.edu.entity.view.CourseView;
import com.edu.service.CourseService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class CourseController {
    private final CourseService courseService;
    
    public CourseController(CourseService courseService) {
        this.courseService = courseService;
    }

    @GetMapping("/course/getAll")
    public Page<CourseView> getAllCourse(
            @RequestParam(value = "current", defaultValue = "1") long current,
            @RequestParam(value = "size", defaultValue = "10") long size) {
        return courseService.getAllCoursesPage(current, size);
    }
}
