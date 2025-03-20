import type { AxiosRequestConfig, AxiosResponse, InternalAxiosRequestConfig } from 'axios'
import axios from 'axios'
import tokenService from './tokenService'
import { HttpClient } from './httpClient'

/**
 * 认证拦截器配置选项
 */
export interface AuthInterceptorOptions {
  // 是否启用token自动添加
  enableTokenAuth?: boolean
  // 是否启用token自动刷新
  enableTokenRefresh?: boolean
  // 刷新token的URL路径
  refreshTokenUrl?: string
}

/**
 * 默认认证拦截器配置
 */
const defaultOptions: AuthInterceptorOptions = {
  enableTokenAuth: true,
  enableTokenRefresh: true,
  refreshTokenUrl: '/refresh-token'
}

/**
 * 认证拦截器类
 * 提供token自动添加和刷新功能
 */
export class AuthInterceptor {
  private options: AuthInterceptorOptions
  private requestInterceptorId: number | null = null
  private responseInterceptorId: number | null = null

  /**
   * 构造函数
   * @param options 认证拦截器配置选项
   */
  constructor(options: AuthInterceptorOptions = {}) {
    this.options = { ...defaultOptions, ...options }
  }

  /**
   * 应用认证拦截器到HTTP客户端
   * @param httpClient HTTP客户端实例
   */
  public applyToClient(httpClient: HttpClient): void {
    // 移除之前的拦截器（如果存在）
    this.removeFromClient(httpClient)

    // 添加请求拦截器（添加token到请求头）
    if (this.options.enableTokenAuth) {
      this.requestInterceptorId = httpClient.addRequestInterceptor(
        this.requestInterceptor.bind(this),
        this.requestErrorHandler.bind(this)
      )
    }

    // 添加响应拦截器（处理token过期）
    if (this.options.enableTokenRefresh) {
      this.responseInterceptorId = httpClient.addResponseInterceptor(
        this.responseInterceptor.bind(this),
        this.responseErrorHandler.bind(this)
      )
    }
  }

  /**
   * 从HTTP客户端移除认证拦截器
   * @param httpClient HTTP客户端实例
   */
  public removeFromClient(httpClient: HttpClient): void {
    if (this.requestInterceptorId !== null) {
      httpClient.removeRequestInterceptor(this.requestInterceptorId)
      this.requestInterceptorId = null
    }

    if (this.responseInterceptorId !== null) {
      httpClient.removeResponseInterceptor(this.responseInterceptorId)
      this.responseInterceptorId = null
    }
  }

  /**
   * 请求拦截器
   * 在请求发送前添加token到请求头
   */
  private requestInterceptor(config: InternalAxiosRequestConfig): InternalAxiosRequestConfig {
    const token = tokenService.getToken()
    if (token) {
      // 将token添加到请求头的Authorization字段
      config.headers = config.headers || {}
      config.headers['Authorization'] = `Bearer ${token}`
    }
    return config
  }

  /**
   * 请求错误处理器
   */
  private requestErrorHandler(error: any): Promise<any> {
    return Promise.reject(error)
  }

  /**
   * 响应拦截器
   */
  private responseInterceptor(response: AxiosResponse): AxiosResponse {
    return response
  }

  /**
   * 响应错误处理器
   * 处理token过期情况，自动刷新token并重试请求
   */
  private async responseErrorHandler(error: any): Promise<any> {
    if (!error.response) {
      return Promise.reject(error)
    }

    const { status, config } = error.response

    // 处理401未授权错误（token过期或无效）
    if (status === 401 && this.options.enableTokenRefresh) {
      // 避免在刷新token的请求中再次尝试刷新token，防止循环调用
      if (config.url === this.options.refreshTokenUrl) {
        tokenService.handleAuthFailure()
        return Promise.reject(error)
      }

      // 尝试刷新token
      const isRefreshed = await tokenService.refreshToken()

      if (isRefreshed) {
        // 如果刷新成功，重新发送之前的请求
        const newConfig = { ...config } as AxiosRequestConfig
        newConfig.headers = { ...config.headers }
        // 确保headers对象存在
        if (newConfig.headers) {
          // 使用新的token更新请求头
          newConfig.headers['Authorization'] = `Bearer ${tokenService.getToken()}`
        }

        // 重新发送请求
        return axios(newConfig)
      } else {
        // 如果刷新失败，交由handleAuthFailure处理
        tokenService.handleAuthFailure()
      }
    }

    // 对于非401错误或不需要刷新token的情况，直接返回错误
    // 错误消息提示由HttpClient的基础拦截器处理
    return Promise.reject(error)
  }
}

/**
 * 创建认证拦截器实例
 * @param options 认证拦截器配置选项
 */
export function createAuthInterceptor(options?: AuthInterceptorOptions): AuthInterceptor {
  return new AuthInterceptor(options)
}