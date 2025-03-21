/**
 * 课程相关API
 */
import request from '../../utils/http/request';
import type { CourseInfo, PaginationParams, PaginationResult } from '../types';

/**
 * 课程API服务
 */
const courseService = {
  /**
   * 获取课程列表
   * @param params 分页参数
   * @returns Promise
   */
  getCourseList(params: PaginationParams & { keyword?: string }) {
    return request.get<PaginationResult<CourseInfo>>('/courses', params);
  },

  /**
   * 获取课程详情
   * @param courseId 课程ID
   * @returns Promise
   */
  getCourseDetail(courseId: string) {
    return request.get<CourseInfo>(`/courses/${courseId}`);
  },

  /**
   * 创建课程
   * @param courseInfo 课程信息
   * @returns Promise
   */
  createCourse(courseInfo: Omit<CourseInfo, 'courseId' | 'enrolled'>) {
    return request.post<{ courseId: string }>('/courses', courseInfo);
  },

  /**
   * 更新课程
   * @param courseId 课程ID
   * @param courseInfo 课程信息
   * @returns Promise
   */
  updateCourse(courseId: string, courseInfo: Partial<CourseInfo>) {
    return request.put<void>(`/courses/${courseId}`, courseInfo);
  },

  /**
   * 删除课程
   * @param courseId 课程ID
   * @returns Promise
   */
  deleteCourse(courseId: string) {
    return request.delete<void>(`/courses/${courseId}`);
  },

  /**
   * 学生选课
   * @param courseId 课程ID
   * @returns Promise
   */
  enrollCourse(courseId: string) {
    return request.post<void>(`/student/courses/${courseId}/enroll`);
  },

  /**
   * 学生退课
   * @param courseId 课程ID
   * @returns Promise
   */
  dropCourse(courseId: string) {
    return request.post<void>(`/student/courses/${courseId}/drop`);
  },

  /**
   * 获取学生已选课程
   * @returns Promise
   */
  getStudentCourses() {
    return request.get<CourseInfo[]>('/student/courses');
  },

  /**
   * 获取教师教授的课程
   * @returns Promise
   */
  getTeacherCourses() {
    return request.get<CourseInfo[]>('/teacher/courses');
  }
};

export default courseService;