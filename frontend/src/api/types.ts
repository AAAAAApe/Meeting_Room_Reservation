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
}

// 员工信息接口
export interface EmployeeInfo extends UserDetailInfo {
  title?: string;
}

// 顾客信息接口
export interface CustomerInfo extends UserDetailInfo {
  pricePerHour?: number;
}

// 会议室信息接口
export interface MeetingRoomInfo {
  meetingRoomId: number;
  meetingRoomName: string;
  pricePerHour: number;
  capacity: number;           // 新增
  type: 'classroom' | 'round_table'; // 新增
  status: 'available' | 'locked' | 'reserved' | 'in_use' | 'maintenance'; // 新增
  hasProjector: boolean;      // 新增
  hasAudio: boolean;          // 新增
  hasNetwork: boolean;        // 新增
}
//
// export interface MeetingRoomWithEmployeeInfo extends MeetingRoomInfo {
//   employeeId: string;
//   employeeName: string;
//   employeeTitleName?: string;
//   employeeDepartmentName?: string;
//   customerCount?: number;
// }

export interface CustomerMeetingRoomSelection {
  meetingRoomId: number;
  customerId: string;
  customerName: string;
  selectionTime: Date;
  startTime: Date;
  endTime: Date;
  totalPrice: number; //
  paymentStatus: 'unpaid' | 'paid' | 'refunded' | 'partial_refund';
  refundAmount?: number; //
  status: 'pending_payment' | 'confirmed' | 'cancelled' | 'completed'; //
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
    pricePerHour?: number;
    capacity: number;
    type: 'classroom' | 'round_table';
    status: 'available' | 'locked' | 'reserved' | 'in_use' | 'maintenance';
    hasProjector: boolean;
    hasAudio: boolean;
    hasNetwork: boolean;
  }
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

export interface CancelRequestInfo {
  id: number;
  meetingRoomId: number;
  customerId: string;
  requestTime: string; // ISO 日期字符串
  status: 'pending' | 'approved' | 'rejected';
  reviewTime: string | null;
  reason: string;
  refundAmount: number | null;
}
// 注册请求参数
export interface RegisterParams {
  roleType: 'employee' | 'customer';
  name: string;
  password: string;
  gender?: 0 | 1; // 0-女 1-男
  birthday?: string;
}

// 注册响应数据
export interface RegisterResult {
  userId: string;
}

