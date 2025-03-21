package com.edu.dto;

import com.edu.entity.course.Course;

import java.util.List;

public record CourseWithTeacherList(Course course, List<String> teacherIds) {}