package com.BookRoom.dto;

import com.BookRoom.entity.course.Course;

import java.util.List;

/**
 * 课程请求数据传输对象
 * 用于接收创建或更新课程的请求参数
 */
public record CourseRequest(Course course, List<String> teacherIds) {}