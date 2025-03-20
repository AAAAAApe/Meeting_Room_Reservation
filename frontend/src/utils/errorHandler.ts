import { ElMessage } from 'element-plus'
import tokenService from './tokenService'

/**
 * 错误处理服务
 * 提供统一的HTTP错误处理和消息提示功能
 */
export class ErrorHandler {
  // 错误状态码对应的默认消息
  private static readonly DEFAULT_ERROR_MESSAGES: Record<number, string> = {
    400: '请求参数错误',
    401: '账号或密码错误',
    403: '没有权限访问该资源',
    404: '请求的资源不存在',
    500: '服务器内部错误',
    502: '网关错误',
    503: '服务不可用',
    504: '网关超时'
  }

  // 特定错误码的自定义处理函数
  private static readonly ERROR_HANDLERS: Record<number, (error: any) => boolean> = {
    401: (error) => {
      // 如果是刷新token的请求失败，不显示错误消息，由tokenService处理
      if (error.config?.url?.includes('/refresh-token')) {
        return false
      }
      
      // 如果响应中包含特定的错误消息，则显示该消息
      if (error.response?.data?.message) {
        ElMessage.error(error.response.data.message)
        return true
      }
      
      // 否则显示默认的401错误消息
      ElMessage.error(ErrorHandler.DEFAULT_ERROR_MESSAGES[401])
      return true
    }
  }

  /**
   * 处理HTTP错误
   * @param error Axios错误对象
   * @param customErrorMessages 自定义错误消息映射
   * @returns 是否已处理错误
   */
  public static handleHttpError(error: any, customErrorMessages?: Record<number, string>): boolean {
    // 如果没有响应，可能是网络错误
    if (!error.response) {
      ElMessage.error('网络连接错误，请检查您的网络连接')
      return true
    }

    const { status } = error.response
    
    // 使用特定错误码的自定义处理函数
    if (status in this.ERROR_HANDLERS) {
      return this.ERROR_HANDLERS[status](error)
    }
    
    // 使用自定义错误消息或默认错误消息
    const errorMessages = { ...this.DEFAULT_ERROR_MESSAGES, ...customErrorMessages }
    
    // 如果响应中包含错误消息，优先使用响应中的错误消息
    if (error.response.data?.message) {
      ElMessage.error(error.response.data.message)
      return true
    }
    
    // 使用状态码对应的错误消息
    if (status in errorMessages) {
      ElMessage.error(errorMessages[status])
      return true
    }
    
    // 未知错误
    ElMessage.error('请求失败，请稍后重试')
    return true
  }
}

/**
 * 导出默认实例
 */
export default ErrorHandler