import axios from 'axios';
import qs from 'qs';
import type { AxiosInstance, InternalAxiosRequestConfig, AxiosResponse } from 'axios';
import tokenService from './tokenService';
import { useUserStore } from '../../stores/userStore';
import { useRouter } from 'vue-router';
import errorHandler from './errorHandler';
import baseConfig from './baseConfig';

/**
 * @description 创建带有token验证的axios实例
 * @param {boolean} withToken - 是否在请求中携带token，默认为true
 * @returns {AxiosInstance} - 返回配置好的axios实例
 */
const createAxiosInstance = (withToken: boolean = true): AxiosInstance => {
  // 使用基础配置创建axios实例
  const instance = axios.create(baseConfig);

  /**
   * 请求拦截器
   * 在发送请求前执行，可以修改请求配置
   */
  instance.interceptors.request.use(
    (config: InternalAxiosRequestConfig) => {
      // 如果需要携带token
      if (withToken) {
        // 获取token
        const token = tokenService.getToken();

        // 如果token存在，添加到请求头中
        if (token) {
          config.headers = config.headers || {};
          config.headers['Authorization'] = `Bearer ${token}`;
        }
      }
      
      /**
       * 对GET请求参数进行序列化处理
       * 使用qs库的stringify方法将参数对象转换为URL查询字符串
       * 设置arrayFormat为'repeat'模式，避免默认的'brackets'模式生成非法字符
       * 例如：{ids: [1,2]} 会转换为 'ids=1&ids=2' 而不是 'ids[]=1&ids[]=2'
       */
      if (config.method?.toLowerCase() === 'get' && config.params) {
        config.paramsSerializer = params => qs.stringify(params, { arrayFormat: 'repeat' });
      }
      
      return config;
    },
    (error) => {
      // 请求错误处理
      return Promise.reject(error);
    }
  );

  /**
   * 响应拦截器
   * 在接收响应后执行，可以处理响应数据或错误
   */
  instance.interceptors.response.use(
    (response: AxiosResponse) => {
      // 直接返回响应数据
      return response;
    },
    async (error) => {
      // 如果没有响应对象，说明是网络错误
      if (!error.response) {
        // 调用网络错误处理函数
        errorHandler.handleNetworkError(error);
        return Promise.reject(error);
      }

      const { status } = error.response;

      /**
       * 处理401未授权错误
       * 1. 如果是不带token的请求(status === 401 && !withToken)，直接跳过处理
       * 2. 如果是带token的请求，尝试刷新token
       * 3. 如果刷新成功，重试原请求
       * 4. 如果刷新失败，跳转到登录页
       */
      if (status === 401) {
        if (!withToken) {
          // 跳过处理，直接返回错误
          return Promise.reject(error);
        }
        try {
          // 尝试刷新token
          const refreshResult = await tokenService.refreshToken();
          if (refreshResult) {
            // 刷新成功，使用新token重试原请求
            const config = error.config as InternalAxiosRequestConfig;
            config.headers['Authorization'] = `Bearer ${tokenService.getToken()}`;
            return axios(config);
          } else {
            // 刷新失败，处理认证错误
            handleAuthError();
          }
        } catch (refreshError) {
          // 刷新token过程中出错，处理认证错误
          handleAuthError();
          return Promise.reject(refreshError);
        }
      } else {
        // 其他错误交给错误处理器处理
        errorHandler.handleResponseError(error);
      }

      return Promise.reject(error);
    }
  );

  return instance;
};



/**
 * @description 处理认证错误
 * 清除用户信息并跳转到登录页
 */
function handleAuthError() {
  // 获取必要的store和router
  const userStore = useUserStore();
  const router = useRouter();

  // 清除token和用户信息
  tokenService.clearToken();
  userStore.clearUser();

  // 跳转到登录页
  router.push('/login');
}

// 创建默认的axios实例（带token验证）
const request = createAxiosInstance(true);

// 创建不带token验证的axios实例（用于登录、注册等不需要认证的请求）
const requestWithoutAuth = createAxiosInstance(false);

// 导出两种请求实例，供不同场景使用
export { request, requestWithoutAuth };