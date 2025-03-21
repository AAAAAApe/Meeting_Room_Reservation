/**
 * API通用类型定义
 */

// 通用响应接口
export interface BaseResponse<T = any> {
  code: number;
  message: string;
  data: T;
}

// 分页请求参数
export interface PaginationParams {
  current: number;
  size: number;
}

// 分页响应数据
export interface PaginationResult<T> {
  total: number;
  size: number;
  current: number;
  pages: number;
  records: T[];
}

// 用户信息接口
export interface UserInfo {
  userId: string;
  userName: string;
  roleName: 'admin' | 'teacher' | 'student';
  lastLoginTime?: string;
}

// 学生信息接口
export interface StudentInfo extends UserInfo {
  studentName: string;
  departmentName: string;
  major: string;
  credit: number;
}

// 教师信息接口
export interface TeacherInfo extends UserInfo {
  birthday?: string;
  phoneNumber?: string;
  departmentName: string;
  startYear?: number;
  title?: string;
}

// 课程信息接口
export interface CourseInfo {
  courseId: number;
  courseName: string;
  credit: number;
  description?: string;
  createrId: string;
  createrName: string;
  departmentId: string;
  departmentName: string;
  teacherId: string;
  teacherName: string;
  studentCount: number;
}

// 登录请求参数
export interface LoginParams {
  userId: string;
  password: string;
}

// 登录响应数据
export interface LoginResult {
  token: string;
  roleName: string;
}