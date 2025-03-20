import type { AxiosResponse } from 'axios';
import { BaseApi } from './baseApi';
import type { PageResponse } from './types';

// 课程视图接口
export interface CourseView {
  courseId: string;
  courseName: string;
  credit: number;
  description: string;
  creatorId: string;
  creatorName: string;
  departmentId: string;
  departmentName: string;
  teacherId: string;
  teacherName: string;
  studentCount: number;
}

/**
 * 课程API服务类
 */
class CourseApi extends BaseApi {
  /**
   * 获取所有课程（分页）
   * @param current 当前页码
   * @param size 每页大小
   * @returns 分页课程列表
   */
  getAllCourses(current: number = 1, size: number = 10): Promise<AxiosResponse<PageResponse<CourseView>>> {
    return this.getPage<CourseView>('/course/getAll', { current, size });
  }
}

// 创建课程API实例
export const courseApi = new CourseApi();