/**
 * 用户相关API
 */
import request from '../../utils/http/request';
import type { LoginParams, LoginResult, StudentInfo, TeacherInfo, UserBaseInfo } from '../types';
import { useUserStore } from '../../stores/userStore';

/**
 * 用户API服务
 */
const userService = {
  /**
   * 用户登录
   * @param params 登录参数
   * @returns Promise<LoginResult> 包含登录结果的Promise对象
   */
  login(params: LoginParams) {
    return request.post<LoginResult>('/login', params, { withToken: false });
  },

  /**
   * 退出登录
   * @returns Promise<void> 无返回值的Promise对象
   */
  logout() {
    return request.post<void>('/logout');
  },

  /**
   * 获取当前用户信息
   * @returns Promise<UserBaseInfo> 包含用户基本信息的Promise对象
   */
  getCurrentUser() {
    return request.get<UserBaseInfo>('/user');
  },

  /**
   * 获取并更新当前用户信息到用户存储
   * @returns Promise<void> 无返回值的Promise对象
   */
  async fetchCurrentUser() {
    const userStore = useUserStore();
    userStore.setUser((await this.getCurrentUser()).data);
  },

  /**
   * 获取教师详细信息
   * @returns Promise<TeacherInfo> 包含教师详细信息的Promise对象
   */
  getTeacherProfile() {
    return request.get<TeacherInfo>('/user/teacher/profile');
  },

  /**
   * 获取学生详细信息
   * @returns Promise<StudentInfo> 包含学生详细信息的Promise对象
   */
  getStudentProfile() {
    return request.get<StudentInfo>('/user/student/profile');
  },

  /**
   * 刷新token
   * @returns Promise<{ token: string }> 包含新token的Promise对象
   */
  refreshToken() {
    return request.post<{ token: string }>('/refresh-token', {}, { withToken: false });
  },

  /**
   * 修改密码
   * @param oldPassword 旧密码
   * @param newPassword 新密码
   * @returns Promise<void> 无返回值的Promise对象
   */
  changePassword(oldPassword: string, newPassword: string) {
    return request.put<void>('/user/password', {
      oldPassword,
      newPassword
    });
  },

  /**
   * 更新用户信息
   * @param userInfo 用户信息
   * @returns Promise<void> 无返回值的Promise对象
   */
  updateUserInfo(userInfo: Partial<UserBaseInfo>) {
    return request.put<void>('/user', userInfo);
  }
};

export default userService;