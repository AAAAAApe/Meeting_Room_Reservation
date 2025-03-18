package com.edu.service;

import com.edu.entity.account.User;
import com.edu.entity.course.Course;
import com.edu.entity.course.CourseSelection;
import com.edu.entity.course.CourseTeacher;
import com.edu.entity.view.TeacherView;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class CourseManagementServiceImpl implements CourseManagementService {
    private final CourseService courseService;
    private final CourseTeacherService courseTeacherService;
    private final CourseSelectionService courseSelectionService;
    private final UserService userService;

    public CourseManagementServiceImpl(CourseService courseService, 
                                      CourseTeacherService courseTeacherService,
                                      CourseSelectionService courseSelectionService,
                                      UserService userService) {
        this.courseService = courseService;
        this.courseTeacherService = courseTeacherService;
        this.courseSelectionService = courseSelectionService;
        this.userService = userService;
    }

    @Override
    @Transactional
    public boolean publishCourse(Course course, List<String> teacherIds) {
        // 1. 创建课程
        boolean courseCreated = courseService.createCourse(course);
        if (!courseCreated) {
            return false;
        }
        
        // 2. 分配教师
        if (teacherIds != null && !teacherIds.isEmpty()) {
            for (String teacherId : teacherIds) {
                CourseTeacher courseTeacher = new CourseTeacher();
                courseTeacher.setCourseId(course.getCourseId());
                courseTeacher.setUserId(teacherId);
                courseTeacherService.assignTeacherToCourse(courseTeacher);
            }
        }
        
        return true;
    }

    @Override
    @Transactional
    public boolean updateCourseInfo(Course course, List<String> teacherIds) {
        // 1. 更新课程基本信息
        boolean courseUpdated = courseService.updateCourse(course);
        if (!courseUpdated) {
            return false;
        }
        
        // 2. 获取当前课程的教师列表
        List<String> currentTeachers = courseTeacherService.getTeachersByCourse(course.getCourseId());
        
        // 3. 删除不再需要的教师关联
        for (String teacherId : currentTeachers) {
            if (!teacherIds.contains(teacherId)) {
                courseTeacherService.removeTeacherFromCourse(course.getCourseId(), teacherId);
            }
        }
        
        // 4. 添加新的教师关联
        for (String teacherId : teacherIds) {
            if (!currentTeachers.contains(teacherId)) {
                CourseTeacher courseTeacher = new CourseTeacher();
                courseTeacher.setCourseId(course.getCourseId());
                courseTeacher.setUserId(teacherId);
                courseTeacherService.assignTeacherToCourse(courseTeacher);
            }
        }
        
        return true;
    }

    @Override
    public List<Course> getCoursesByDepartment(String departmentId) {
        return courseService.getCoursesByDepartment(departmentId);
    }

    @Override
    public List<Map<String, Object>> getStudentCourseDetails(String studentId) {
        // 1. 获取学生已选课程列表
        List<CourseSelection> courseSelections = courseSelectionService.getStudentCourses(studentId);
        List<Map<String, Object>> courseDetails = new ArrayList<>();
        
        // 2. 获取每门课程的详细信息
        for (CourseSelection selection : courseSelections) {
            Map<String, Object> detail = new HashMap<>();
            
            // 课程基本信息
            Course course = courseService.getCourseById(selection.getCourseId());
            detail.put("course", course);
            
            // 教师信息
            TeacherView teacher = userService.getTeacherInfo(selection.getTeacherId());
            detail.put("teacher", teacher);
            
            // 选课信息（包括成绩）
            detail.put("selection", selection);
            
            courseDetails.add(detail);
        }
        
        return courseDetails;
    }

    @Override
    @Transactional
    public boolean studentSelectCourse(String courseId, String studentId, String teacherId) {
        // 1. 验证课程是否存在
        Course course = courseService.getCourseById(courseId);
        if (course == null) {
            return false;
        }
        
        // 2. 验证教师是否关联到该课程
        List<String> courseTeachers = courseTeacherService.getTeachersByCourse(courseId);
        if (!courseTeachers.contains(teacherId)) {
            return false;
        }
        
        // 3. 创建选课记录
        CourseSelection courseSelection = new CourseSelection();
        courseSelection.setCourseId(courseId);
        courseSelection.setStudentId(studentId);
        courseSelection.setTeacherId(teacherId);
        courseSelection.setSelectionTime(LocalDateTime.now());
        
        return courseSelectionService.selectCourse(courseSelection);
    }

    @Override
    public boolean studentDropCourse(String courseId, String studentId, String teacherId) {
        return courseSelectionService.dropCourse(courseId, studentId, teacherId);
    }
}