import type { AxiosRequestConfig, InternalAxiosRequestConfig, AxiosResponse } from 'axios';
import { request, requestWithoutAuth } from './index';
import type { BaseResponse } from '../../api';

/**
 * 请求配置接口，扩展AxiosRequestConfig
 */
interface RequestOptions extends AxiosRequestConfig {
  withToken?: boolean; // 是否携带token
}

/**
 * HTTP请求类
 */
class HttpRequest {
  /**
   * GET请求
   * @param url 请求地址
   * @param params 请求参数
   * @param options 请求配置
   * @returns Promise
   */
  get<T = any>(url: string, params?: any, options?: RequestOptions): Promise<AxiosResponse<T>> {
    const withToken = options?.withToken !== false; // 默认携带token
    const instance = withToken ? request : requestWithoutAuth;
    
    return instance.get(url, {
      params,
      ...options
    });
  }

  /**
   * POST请求
   * @param url 请求地址
   * @param data 请求数据
   * @param options 请求配置
   * @returns Promise
   */
  post<T = any>(url: string, data?: any, options?: RequestOptions): Promise<AxiosResponse<T>> {
    const withToken = options?.withToken !== false; // 默认携带token
    const instance = withToken ? request : requestWithoutAuth;
    
    return instance.post(url, data, options);
  }

  /**
   * PUT请求
   * @param url 请求地址
   * @param data 请求数据
   * @param options 请求配置
   * @returns Promise
   */
  put<T = any>(url: string, data?: any, options?: RequestOptions): Promise<AxiosResponse<T>> {
    const withToken = options?.withToken !== false; // 默认携带token
    const instance = withToken ? request : requestWithoutAuth;
    
    return instance.put(url, data, options);
  }

  /**
   * DELETE请求
   * @param url 请求地址
   * @param options 请求配置
   * @returns Promise
   */
  delete<T = any>(url: string, options?: RequestOptions): Promise<AxiosResponse<T>> {
    const withToken = options?.withToken !== false; // 默认携带token
    const instance = withToken ? request : requestWithoutAuth;
    
    return instance.delete(url, options);
  }
}

// 导出HTTP请求实例
export default new HttpRequest();

// 导出类型
export type { BaseResponse, RequestOptions };