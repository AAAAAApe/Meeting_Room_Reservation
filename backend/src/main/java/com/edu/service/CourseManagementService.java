package com.edu.service;

import com.edu.entity.course.Course;
import com.edu.entity.course.CourseSelection;
import com.edu.entity.course.CourseTeacher;

import java.util.List;
import java.util.Map;

public interface CourseManagementService {
    /**
     * 发布课程（包括创建课程和分配教师）
     * @param course 课程信息
     * @param teacherIds 教师ID列表
     * @return 是否发布成功
     */
    boolean publishCourse(Course course, List<String> teacherIds);
    
    /**
     * 更新课程信息（包括课程基本信息和教师分配）
     * @param course 课程信息
     * @param teacherIds 教师ID列表
     * @return 是否更新成功
     */
    boolean updateCourseInfo(Course course, List<String> teacherIds);
    
    /**
     * 根据部门ID获取课程列表
     * @param departmentId 部门ID
     * @return 课程列表
     */
    List<Course> getCoursesByDepartment(String departmentId);
    
    /**
     * 获取学生已选课程详细信息（包括课程信息、教师信息、成绩等）
     * @param studentId 学生ID
     * @return 课程详细信息列表
     */
    List<Map<String, Object>> getStudentCourseDetails(String studentId);
    
    /**
     * 学生选课（必须关联教师）
     * @param courseId 课程ID
     * @param studentId 学生ID
     * @param teacherId 教师ID
     * @return 是否选课成功
     */
    boolean studentSelectCourse(String courseId, String studentId, String teacherId);
    
    /**
     * 学生退选课程
     * @param courseId 课程ID
     * @param studentId 学生ID
     * @param teacherId 教师ID
     * @return 是否退选成功
     */
    boolean studentDropCourse(String courseId, String studentId, String teacherId);
}
