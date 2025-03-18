package com.edu.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.edu.entity.course.Course;

import java.util.List;

public interface CourseService extends IService<Course>{
    /**
     * 根据部门ID获取课程列表
     * @param departmentId 部门ID
     * @return 课程列表
     */
    List<Course> getCoursesByDepartment(String departmentId);
    
    /**
     * 根据课程ID获取课程信息
     * @param courseId 课程ID
     * @return 课程信息
     */
    Course getCourseById(String courseId);
    
    /**
     * 创建新课程
     * @param course 课程信息
     * @return 是否创建成功
     */
    boolean createCourse(Course course);
    
    /**
     * 更新课程信息
     * @param course 课程信息
     * @return 是否更新成功
     */
    boolean updateCourse(Course course);
    
    /**
     * 删除课程
     * @param courseId 课程ID
     * @return 是否删除成功
     */
    boolean deleteCourse(String courseId);
}
