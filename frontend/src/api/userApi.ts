import type { AxiosResponse } from 'axios';
import { BaseApi } from './baseApi';
import type { ApiResponse, PageResponse } from './types';

/**
 * 用户视图接口
 */
export interface UserView {
  userId: string;
  username: string;
  realName: string;
  email: string;
  phone: string;
  role: string;
  departmentId: string;
  departmentName: string;
  status: number;
  createTime: string;
}

/**
 * 用户登录参数
 */
export interface LoginParams {
  username: string;
  password: string;
}

/**
 * 用户登录响应
 */
export interface LoginResponse {
  token: string;
  user: UserView;
}

/**
 * 用户API服务类
 */
class UserApi extends BaseApi {
  /**
   * 用户登录
   * @param params 登录参数
   * @returns 登录响应
   */
  login(params: LoginParams): Promise<AxiosResponse<ApiResponse<LoginResponse>>> {
    return this.post<ApiResponse<LoginResponse>>('/user/login', params);
  }

  /**
   * 获取用户信息
   * @param userId 用户ID
   * @returns 用户信息
   */
  getUserInfo(userId: string): Promise<AxiosResponse<ApiResponse<UserView>>> {
    return this.get<ApiResponse<UserView>>(`/user/${userId}`);
  }

  /**
   * 获取所有用户（分页）
   * @param current 当前页码
   * @param size 每页大小
   * @returns 分页用户列表
   */
  getAllUsers(current: number = 1, size: number = 10): Promise<AxiosResponse<PageResponse<UserView>>> {
    return this.getPage<UserView>('/user/getAll', { current, size });
  }
}

// 创建用户API实例
export const userApi = new UserApi();