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
  roleName: 'admin' | 'employee' | 'customer';
}

export interface UserDetailInfo extends UserBaseInfo {
  gender?: string;
  birthday?: Date;
  phoneNumber?: string;
  email?: string;
  startYear?: number;
  departmentName?: string;
}

// 员工信息接口
export interface EmployeeInfo extends UserDetailInfo {
  title?: string;
}

// 顾客信息接口
export interface CustomerInfo extends UserDetailInfo {
  major?: string;
  credit?: number;
}

export interface department {
  departmentId: string;
  departmentName: string;
}

// 会议室信息接口
export interface MeetingRoomInfo {
  meetingRoomId: number;
  meetingRoomName: string;
  credit: number;
  description?: string;
  creatorId: string;
  creatorName?: string;
  departmentId: string;
  departmentName: string;
  employeeCount?: number;
}

export interface MeetingRoomWithEmployeeInfo extends MeetingRoomInfo {
  employeeId: string;
  employeeName: string;
  employeeTitleName?: string;
  employeeDepartmentName?: string;
  customerCount?: number;
}

export interface CustomerMeetingRoomSelection extends MeetingRoomWithEmployeeInfo {
  customerId: string;
  customerName: string;
  selectionTime: Date;
  score: number;
}

export interface MeetingRoomAssignment {
  assignmentTitle: string;
  meetingRoomId: number;
  employeeId: string;
  submissionDeadline: Date;
  content: string;
  submissionUrl?: string;
}

export interface CustomerMeetingRoomAssignment extends MeetingRoomAssignment {
  customerId: string;
  score?: 'A' | 'B' | 'C' | 'D' | 'E' | 'F';
}

export interface MeetingRoomPublishInfo {
  meetingRoom: {
    meetingRoomId?: number;
    meetingRoomName: string;
    credit?: number;
    description?: string;
    departmentId?: string;
  },
  employeeIds: string[];
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