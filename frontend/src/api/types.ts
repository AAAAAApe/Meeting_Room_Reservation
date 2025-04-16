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
export interface UserBaseInfo {
  userId: string;
  name: string;
  roleName: 'admin' | 'teacher' | 'student';
}

export interface UserDetailInfo extends UserBaseInfo {
  gender?: string;
  birthday?: Date;
  phoneNumber?: string;
  email?: string;
  startYear?: number;
  departmentName?: string;
}

// 教师信息接口
export interface TeacherInfo extends UserDetailInfo {
  title?: string;
}

// 学生信息接口
export interface StudentInfo extends UserDetailInfo {
  major?: string;
  credit?: number;
}

export interface department {
  departmentId: string;
  departmentName: string;
}

// 课程信息接口
export interface CourseInfo {
  courseId: number;
  courseName: string;
  credit: number;
  description?: string;
  creatorId: string;
  creatorName?: string;
  departmentId: string;
  departmentName: string;
  teacherCount?: number;
}

export interface CourseWithTeacherInfo extends CourseInfo {
  teacherId: string;
  teacherName: string;
  teacherTitleName?: string;
  teacherDepartmentName?: string;
  studentCount?: number;
}

export interface StudentCourseSelection extends CourseWithTeacherInfo {
  studentId: string;
  studentName: string;
  selectionTime: Date;
  score: number;
}

export interface CourseAssignment {
  assignmentTitle: string;
  courseId: number;
  teacherId: string;
  submissionDeadline: Date;
  content: string;
  submissionUrl?: string;
}

export interface StudentCourseAssignment extends CourseAssignment {
  studentId: string;
  score?: 'A' | 'B' | 'C' | 'D' | 'E' | 'F';
}

export interface CoursePublishInfo {
  course: {
    courseId?: number;
    courseName: string;
    credit?: number;
    description?: string;
    departmentId?: string;
  },
  teacherIds: string[];
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