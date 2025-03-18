package com.edu.service;

import com.edu.entity.course.CourseSelection;
import com.github.jeffreyning.mybatisplus.service.IMppService;

import java.util.List;

public interface CourseSelectionService extends IMppService<CourseSelection> {
    /**
     * 学生选课
     * @param courseSelection 选课信息（包含课程ID、学生ID和教师ID）
     * @return 是否选课成功
     */
    boolean selectCourse(CourseSelection courseSelection);
    
    /**
     * 学生退选课程
     * @param courseId 课程ID
     * @param studentId 学生ID
     * @param teacherId 教师ID
     * @return 是否退选成功
     */
    boolean dropCourse(String courseId, String studentId, String teacherId);
    
    /**
     * 获取学生已选课程列表
     * @param studentId 学生ID
     * @return 已选课程列表
     */
    List<CourseSelection> getStudentCourses(String studentId);
    
    /**
     * 获取教师教授的课程列表
     * @param teacherId 教师ID
     * @return 教授课程列表
     */
    List<CourseSelection> getTeacherCourses(String teacherId);
    
    /**
     * 更新学生成绩
     * @param courseId 课程ID
     * @param studentId 学生ID
     * @param teacherId 教师ID
     * @param score 成绩
     * @return 是否更新成功
     */
    boolean updateScore(String courseId, String studentId, String teacherId, Double score);
}
