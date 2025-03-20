import { createHttpClient } from '../utils/httpClient';
import type { AxiosResponse } from 'axios';
import type { PageParams, PageResponse } from './types';

// 创建统一的HTTP客户端实例
// const httpClient = new HttpClient();
const httpClient = createHttpClient();

/**
 * 基础API类
 * 提供通用的API调用方法和错误处理
 */
export class BaseApi {
  /**
   * 发送GET请求
   * @param url 请求URL
   * @param params 请求参数
   * @returns Promise<AxiosResponse<T>>
   */
  protected get<T = any>(url: string, params?: any): Promise<AxiosResponse<T>> {
    return httpClient.get<T>(url, { params });
  }

  /**
   * 发送POST请求
   * @param url 请求URL
   * @param data 请求数据
   * @returns Promise<AxiosResponse<T>>
   */
  protected post<T = any>(url: string, data?: any): Promise<AxiosResponse<T>> {
    return httpClient.post<T>(url, data);
  }

  /**
   * 发送PUT请求
   * @param url 请求URL
   * @param data 请求数据
   * @returns Promise<AxiosResponse<T>>
   */
  protected put<T = any>(url: string, data?: any): Promise<AxiosResponse<T>> {
    return httpClient.put<T>(url, data);
  }

  /**
   * 发送DELETE请求
   * @param url 请求URL
   * @returns Promise<AxiosResponse<T>>
   */
  protected delete<T = any>(url: string, params?: any): Promise<AxiosResponse<T>> {
    return httpClient.delete<T>(url, { params });
  }

  /**
   * 发送分页GET请求
   * @param url 请求URL
   * @param params 分页参数
   * @returns Promise<AxiosResponse<PageResponse<T>>>
   */
  protected getPage<T = any>(url: string, params: PageParams): Promise<AxiosResponse<PageResponse<T>>> {
    return this.get<PageResponse<T>>(url, {
      current: params.current || 1,
      size: params.size || 10
    });
  }
}