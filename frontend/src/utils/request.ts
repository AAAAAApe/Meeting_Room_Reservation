import { createHttpClient } from './httpClient'
import { createAuthInterceptor } from './authInterceptor'

/**
 * 创建预配置的HTTP客户端实例
 * 
 * 配置了基础URL、超时时间、默认请求头和认证拦截器
 * 用于整个应用的HTTP请求
 */
const httpClient = createHttpClient({
  baseURL: '/api',  // 基础URL，指向后端API服务
  timeout: 5000,    // 请求超时时间，单位毫秒
  headers: {
    'Content-Type': 'application/json'  // 默认请求头，指定内容类型为JSON
  },
  enableErrorMessage: true  // 启用错误消息提示
})

// 创建并应用认证拦截器
const authInterceptor = createAuthInterceptor({
  enableTokenAuth: true,     // 启用token自动添加
  enableTokenRefresh: true,  // 启用token自动刷新
  refreshTokenUrl: '/refresh-token'
})

// 将认证拦截器应用到HTTP客户端
authInterceptor.applyToClient(httpClient)

// 获取axios实例
const request = httpClient.getAxiosInstance()

/**
 * 导出请求实例
 * 可在应用中直接使用该实例发送HTTP请求
 * 所有请求都会自动应用上述拦截器的处理逻辑
 */
export default request

// 创建不带认证功能的HTTP客户端实例
const noAuthHttpClient = createHttpClient({
  baseURL: '/api',  // 基础URL，指向后端API服务
  timeout: 5000,    // 请求超时时间，单位毫秒
  headers: {
    'Content-Type': 'application/json'  // 默认请求头，指定内容类型为JSON
  },
  enableErrorMessage: true  // 启用错误消息提示
})

// 创建禁用token功能的认证拦截器
const noAuthInterceptor = createAuthInterceptor({
  enableTokenAuth: false,     // 禁用token自动添加
  enableTokenRefresh: false,  // 禁用token自动刷新
})

// 将禁用token功能的认证拦截器应用到HTTP客户端
noAuthInterceptor.applyToClient(noAuthHttpClient)

// 获取不带认证功能的axios实例
const requestWithoutAuth = noAuthHttpClient.getAxiosInstance()

// 导出HTTP客户端实例，方便需要更高级功能的模块使用
export { httpClient, noAuthHttpClient }

/**
 * 导出不带token认证的请求实例
 * 可用于不需要认证的API请求，如登录、注册等
 */
export { requestWithoutAuth }