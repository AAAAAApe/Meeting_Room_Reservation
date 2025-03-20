import axios from 'axios'
import type { AxiosInstance, AxiosRequestConfig, AxiosResponse, InternalAxiosRequestConfig } from 'axios'

/**
 * HTTP客户端配置选项
 */
export interface HttpClientOptions {
  // 基础配置
  baseURL?: string
  timeout?: number
  headers?: Record<string, string>
  
  // 拦截器配置
  enableErrorMessage?: boolean // 是否启用错误消息提示
  errorMessageMap?: Record<number, string> // 错误状态码对应的消息
} 

/**
 * 创建HTTP客户端的默认配置
 */
const defaultOptions: HttpClientOptions = {
  baseURL: '/api',
  timeout: 5000,
  headers: {
    'Content-Type': 'application/json'
  },
  enableErrorMessage: false,
  errorMessageMap: {
    400: '请求参数错误',
    401: '未授权，请登录',
    403: '没有权限访问该资源',
    404: '请求的资源不存在',
    500: '服务器内部错误'
  }
}

/**
 * HTTP客户端类
 * 提供基础的HTTP请求功能和拦截器管理
 */
export class HttpClient {
  // axios实例
  private instance: AxiosInstance
  // 配置选项
  private options: HttpClientOptions

  /**
   * 构造函数
   * @param options 客户端配置选项
   */
  constructor(options: HttpClientOptions = {}) {
    // 合并默认配置和用户配置
    this.options = { ...defaultOptions, ...options }
    
    // 创建axios实例
    this.instance = axios.create({
      baseURL: this.options.baseURL,
      timeout: this.options.timeout,
      headers: this.options.headers
    })
    
    // 添加基础响应拦截器
    this.setupBaseInterceptors()
  }

  /**
   * 设置基础响应拦截器
   * 处理基本的HTTP错误，显示友好的错误提示
   * 注意：认证相关的错误处理（如token刷新）由authInterceptor负责
   */
  private setupBaseInterceptors(): void {
    this.instance.interceptors.response.use(
      (response) => response,
      (error) => {
        // 如果启用了错误消息提示，则使用ErrorHandler处理错误
        if (this.options.enableErrorMessage) {
          // 动态导入ErrorHandler，避免循环依赖
          import('./errorHandler').then(({ default: ErrorHandler }) => {
            // 使用自定义错误消息映射（如果有）
            ErrorHandler.handleHttpError(error, this.options.errorMessageMap)
          })
        }
        // 继续传递错误，让后续拦截器处理
        return Promise.reject(error)
      }
    )
  }

  /**
   * 添加请求拦截器
   * @param onFulfilled 成功回调
   * @param onRejected 失败回调
   */
  public addRequestInterceptor(
    onFulfilled?: (config: InternalAxiosRequestConfig) => InternalAxiosRequestConfig | Promise<InternalAxiosRequestConfig>,
    onRejected?: (error: any) => any
  ): number {
    return this.instance.interceptors.request.use(onFulfilled, onRejected)
  }

  /**
   * 添加响应拦截器
   * @param onFulfilled 成功回调
   * @param onRejected 失败回调
   */
  public addResponseInterceptor(
    onFulfilled?: (response: AxiosResponse) => AxiosResponse | Promise<AxiosResponse>,
    onRejected?: (error: any) => any
  ): number {
    return this.instance.interceptors.response.use(onFulfilled, onRejected)
  }

  /**
   * 移除请求拦截器
   * @param id 拦截器ID
   */
  public removeRequestInterceptor(id: number): void {
    this.instance.interceptors.request.eject(id)
  }

  /**
   * 移除响应拦截器
   * @param id 拦截器ID
   */
  public removeResponseInterceptor(id: number): void {
    this.instance.interceptors.response.eject(id)
  }

  /**
   * 获取axios实例
   */
  public getAxiosInstance(): AxiosInstance {
    return this.instance
  }

  /**
   * 发送GET请求
   * @param url 请求URL
   * @param config 请求配置
   */
  public get<T = any>(url: string, config?: AxiosRequestConfig): Promise<AxiosResponse<T>> {
    return this.instance.get<T>(url, config)
  }

  /**
   * 发送POST请求
   * @param url 请求URL
   * @param data 请求数据
   * @param config 请求配置
   */
  public post<T = any>(url: string, data?: any, config?: AxiosRequestConfig): Promise<AxiosResponse<T>> {
    return this.instance.post<T>(url, data, config)
  }

  /**
   * 发送PUT请求
   * @param url 请求URL
   * @param data 请求数据
   * @param config 请求配置
   */
  public put<T = any>(url: string, data?: any, config?: AxiosRequestConfig): Promise<AxiosResponse<T>> {
    return this.instance.put<T>(url, data, config)
  }

  /**
   * 发送DELETE请求
   * @param url 请求URL
   * @param config 请求配置
   */
  public delete<T = any>(url: string, config?: AxiosRequestConfig): Promise<AxiosResponse<T>> {
    return this.instance.delete<T>(url, config)
  }
}

/**
 * 创建HTTP客户端实例
 * @param options 客户端配置选项
 */
export function createHttpClient(options?: HttpClientOptions): HttpClient {
  return new HttpClient(options)
}