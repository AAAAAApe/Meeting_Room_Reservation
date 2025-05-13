/**
 * API统一导出
 */
import userService from './service/user';
import meetingRoomService from './service/meetingRoom';
import departmentService from './service/department';

// 导出所有API服务
export {
  userService,
  meetingRoomService,
  departmentService
};

// 导出API类型
export * from './types';