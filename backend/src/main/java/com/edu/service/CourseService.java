package com.edu.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.edu.entity.course.Course;
import com.edu.entity.course.CourseSelection;
import com.edu.entity.view.CourseSelectView;
import com.edu.entity.view.CourseView;

import java.util.List;

/**
 * 课程服务接口
 * 定义了课程管理相关的业务逻辑方法，包括课程的增删改查、选课、退课和成绩管理等功能
 */
public interface CourseService {
    /**
     * 根据课程ID获取课程信息
     *
     * @param courseId 课程ID
     * @return 课程信息
     */
    CourseView getCourseById(String courseId);

    /**
     * 根据部门ID获取课程列表
     *
     * @param departmentId 部门ID
     * @return 课程列表
     */
    List<CourseView> getCoursesByDepartment(String departmentId);

    /**
     * 根据部门ID获取课程列表（分页）
     *
     * @param departmentId 部门ID
     * @param current      当前页码
     * @param size         每页大小
     * @return 分页课程列表
     */
    Page<CourseView> getCoursesByDepartmentPage(String departmentId, long current, long size);

    /**
     * 根据教师ID获取课程列表
     *
     * @param teacherId 教师ID
     * @return 课程列表
     */
    List<CourseView> getCoursesByTeacher(String teacherId);

    /**
     * 根据教师ID获取课程列表（分页）
     *
     * @param teacherId 教师ID
     * @param current   当前页码
     * @param size      每页大小
     * @return 分页课程列表
     */
    Page<CourseView> getCoursesByTeacherPage(String teacherId, long current, long size);

    /**
     * 根据学生ID获取课程列表
     *
     * @param studentId 学生ID
     * @return 课程列表
     */
    List<CourseSelectView> getCoursesByStudent(String studentId);

    /**
     * 根据学生ID获取课程列表（分页）
     *
     * @param studentId 学生ID
     * @param current   当前页码
     * @param size      每页大小
     * @return 分页课程列表
     */
    Page<CourseSelectView> getCoursesByStudentPage(String studentId, long current, long size);

    /**
     * 获取所有课程列表
     *
     * @return 所有课程列表
     */
    List<CourseView> getAllCourses();

    /**
     * 获取所有课程（分页）
     *
     * @param current 当前页码
     * @param size    每页大小
     * @return 分页课程列表
     */
    Page<CourseView> getAllCoursesPage(long current, long size);

    /**
     * 创建新课程
     *
     * @param course 课程信息
     * @return 是否创建成功
     */
    boolean createOrUpdateCourse(Course course, List<String> teacherIds);

    /**
     * 创建或更新课程信息
     *
     * @param course 课程信息
     * @return 是否创建或更新成功
     */
    boolean createOrUpdateCourse(Course course);

    /**
     * 删除课程
     *
     * @param courseId 课程ID
     * @return 是否删除成功
     */
    boolean deleteCourse(Integer courseId);

    /**
     * 学生选课
     *
     * @param courseSelection 选课信息（包含课程ID、学生ID和教师ID）
     * @return 是否选课成功
     */
    boolean selectCourse(CourseSelection courseSelection);

    /**
     * 学生退选课程
     *
     * @param courseSelection 选课信息（包含课程ID、学生ID和教师ID）
     * @return 是否退选成功
     */
    boolean dropCourse(CourseSelection courseSelection);

    /**
     * 获取学生已选课程列表
     *
     * @param studentId 学生ID
     * @return 已选课程列表
     */
    List<CourseSelectView> getStudentCourses(String studentId);

    /**
     * 获取学生已选课程列表（分页）
     *
     * @param studentId 学生ID
     * @param current   当前页码
     * @param size      每页大小
     * @return 分页已选课程列表
     */
    Page<CourseSelectView> getStudentCoursesPage(String studentId, long current, long size);

    /**
     * 获取教师教授的课程列表
     *
     * @param teacherId 教师ID
     * @return 教授课程列表
     */
    List<CourseView> getTeacherCourses(String teacherId);

    /**
     * 获取教师教授的课程列表（分页）
     *
     * @param teacherId 教师ID
     * @param current   当前页码
     * @param size      每页大小
     * @return 分页教授课程列表
     */
    Page<CourseView> getTeacherCoursesPage(String teacherId, long current, long size);

    /**
     * 更新学生成绩
     *
     * @param courseSelection 选课信息（包含课程ID、学生ID、教师ID和成绩）
     * @return 是否更新成功
     */
    boolean updateScore(CourseSelection courseSelection);
}
