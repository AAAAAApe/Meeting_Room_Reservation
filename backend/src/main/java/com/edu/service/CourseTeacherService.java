package com.edu.service;

import com.edu.entity.course.CourseTeacher;
import com.github.jeffreyning.mybatisplus.service.IMppService;

import java.util.List;

public interface CourseTeacherService extends IMppService<CourseTeacher> {
    /**
     * 为课程分配教师
     * @param courseTeacher 课程教师关联信息
     * @return 是否分配成功
     */
    boolean assignTeacherToCourse(CourseTeacher courseTeacher);
    
    /**
     * 取消教师与课程的关联
     * @param courseId 课程ID
     * @param userId 教师ID
     * @return 是否取消成功
     */
    boolean removeTeacherFromCourse(String courseId, String userId);
    
    /**
     * 获取课程的所有教师
     * @param courseId 课程ID
     * @return 教师ID列表
     */
    List<String> getTeachersByCourse(String courseId);
    
    /**
     * 获取教师教授的所有课程
     * @param userId 教师ID
     * @return 课程ID列表
     */
    List<String> getCoursesByTeacher(String userId);
}
