/**
 * API统一导出
 */
import userService from './service/user';
import meetingRoomService from './service/meetingRoom';

// 导出所有API服务
export {
  userService,
  meetingRoomService
};

// 导出API类型
export * from './types';