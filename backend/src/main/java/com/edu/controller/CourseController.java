package com.edu.controller;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.edu.entity.view.CourseView;
import com.edu.service.CourseService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

/**
 * 课程控制器，处理课程相关的HTTP请求
 * 包括课程查询、分页获取等功能
 */
@RestController
public class CourseController {
    private final CourseService courseService;
    
    /**
     * 构造函数，通过依赖注入初始化服务
     *
     * @param courseService 课程服务，处理课程相关的业务逻辑
     */
    public CourseController(CourseService courseService) {
        this.courseService = courseService;
    }

    /**
     * 分页获取所有课程信息
     * <p>
     * 该方法用于分页获取系统中所有课程的基本信息。通过CourseService调用数据访问层，
     * 检索并返回指定页码和每页记录数的课程记录。
     *
     * @param current 当前页码，默认为1
     * @param size    每页记录数，默认为10
     * @return 包含分页课程信息的Page对象，包含总记录数、总页数、当前页数据等信息
     */
    @GetMapping("/course/getAll")
    public Page<CourseView> getAllCourse(
            @RequestParam(value = "current", defaultValue = "1") long current,
            @RequestParam(value = "size", defaultValue = "10") long size) {
        return courseService.getAllCoursesByPage(current, size);
    }
}
