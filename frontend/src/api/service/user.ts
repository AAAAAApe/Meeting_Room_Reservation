/**
 * 用户相关API
 */
import request from '../../utils/http/request';
import type { LoginParams, LoginResult, UserBaseInfo } from '../types';

/**
 * 用户API服务
 */
const userService = {
  /**
   * 用户登录
   * @param params 登录参数
   * @returns Promise
   */
  login(params: LoginParams) {
    return request.post<LoginResult>('/login', params, { withToken: false });
  },

  /**
   * 退出登录
   * @returns Promise
   */
  logout() {
    return request.post<void>('/logout');
  },

  /**
   * 获取当前用户信息
   * @returns Promise
   */
  getCurrentUser() {
    return request.get<UserBaseInfo>('/user');
  },

  /**
   * 刷新token
   * @returns Promise
   */
  refreshToken() {
    return request.post<{ token: string }>('/refresh-token', {}, { withToken: false });
  },

  /**
   * 修改密码
   * @param oldPassword 旧密码
   * @param newPassword 新密码
   * @returns Promise
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
   * @returns Promise
   */
  updateUserInfo(userInfo: Partial<UserBaseInfo>) {
    return request.put<void>('/user', userInfo);
  }
};

export default userService;