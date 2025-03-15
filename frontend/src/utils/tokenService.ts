import { useTokenStore } from '../stores/tokenStore'
import { useUserStore } from '../stores/userStore'
import router from '../router'
import { ElMessage } from 'element-plus'
import { requestWithRefreshOnly } from './request'

// 认证服务模块配置
const AUTH_API = {
  REFRESH_TOKEN: '/refresh-token',
  LOGOUT: '/logout',
  VALIDATE_TOKEN: '/validate-token'
}

// 是否正在刷新token
let isRefreshing = false
// 等待刷新token的请求队列
let requestsQueue: Array<() => void> = []

/**
 * Token服务类
 * 负责处理token的获取、设置、刷新和验证
 */
export class TokenService {

  /**
   * 设置 access token
   * @param token access token 字符串
   */
  public setToken(token: string): void {
    const tokenStore = useTokenStore()
    tokenStore.setToken(token)
  }

  /**
   * 获取 access token
   * @returns token字符串，如果不存在则返回null
   */
  public getToken(): string | null {
    const tokenStore = useTokenStore()
    // 如果store中没有token，尝试从localStorage加载
    if (!tokenStore.token) {
      tokenStore.loadTokenFromStorage()
    }
    return tokenStore.token
  }

  /**
   * 移除token
   */
  public removeToken(): void {
    const tokenStore = useTokenStore()
    tokenStore.clearToken()
  }

  /**
   * 检查是否已认证
   * @returns 是否已认证
   */
  public isAuthenticated(): boolean {
    const tokenStore = useTokenStore()
    // 如果store中没有token，尝试从localStorage加载
    if (!tokenStore.token) {
      tokenStore.loadTokenFromStorage()
    }
    return tokenStore.isAuthenticated
  }

  /**
   * 登出并清除服务器端的refreshToken
   */
  public async logout(): Promise<void> {
    const userStore = useUserStore()
    
    try {
      // 发送登出请求，清除服务器端的refreshToken cookie
      await requestWithRefreshOnly.post(AUTH_API.LOGOUT)
      
      // 清除本地token和用户信息
      this.removeToken()
      userStore.clearUser()
    } catch (error) {
      console.error('登出失败', error)
      
      // 即使请求失败，也清除本地token和用户信息
      this.removeToken()
      userStore.clearUser()
    }
  }

  /**
   * 刷新access token
   * @returns Promise<boolean> 刷新成功返回true，失败返回false
   */
  public async refreshToken(): Promise<boolean> {
    // 如果已经在刷新token，则将请求加入队列
    if (isRefreshing) {
      return new Promise(resolve => {
        requestsQueue.push(() => {
          resolve(true)
        })
      })
    }
    
    isRefreshing = true
    
    try {
      // 发送刷新token请求，refreshToken由浏览器自动通过cookie发送
      const response = await requestWithRefreshOnly.post(AUTH_API.REFRESH_TOKEN)
      
      if (response.data.code === 200) {
        // 更新token
        this.setToken(response.data.token)
        
        // 执行队列中的请求
        requestsQueue.forEach(callback => callback())
        requestsQueue = []
        
        isRefreshing = false
        return true
      } else {
        // 刷新失败，清除用户信息并跳转到登录页
        this.handleAuthFailure()
        return false
      }
    } catch (error) {
      // 刷新失败，清除用户信息并跳转到登录页
      this.handleAuthFailure()
      return false
    }
  }

  /**
   * 处理认证失败的情况
   */
  public handleAuthFailure(): void {
    const userStore = useUserStore()
    
    // 清除用户信息
    userStore.clearUser()
    this.removeToken()
    
    // 显示提示信息
    ElMessage.error('登录已过期，请重新登录')
    
    // 如果不是登录页面，则跳转到登录页
    if (router.currentRoute.value.path !== '/login') {
      router.push('/login')
    }
    
    isRefreshing = false
    requestsQueue = []
  }

  /**
   * 验证token是否有效
   * @returns Promise<boolean> token有效返回true，无效返回false
   */
  public async validateToken(): Promise<boolean> {
    try {
      const token = this.getToken()
      await requestWithRefreshOnly.get(AUTH_API.VALIDATE_TOKEN, {
        headers: {
          'Authorization': `Bearer ${token}`
        }
      })
      return true
    } catch (error) {
      return false
    }
  }
}

// 创建单例实例
const tokenService = new TokenService()

export default tokenService