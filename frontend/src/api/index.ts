/**
 * API统一导出
 */
import userService from './service/user';
import courseService from './service/course';
import departmentService from './service/department';

// 导出所有API服务
export {
  userService,
  courseService,
  departmentService
};

// 导出API类型
export * from './types';