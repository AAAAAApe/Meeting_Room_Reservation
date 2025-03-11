import axios from 'axios'
import type { AxiosInstance } from 'axios'
import { useUserStore } from '../stores/userStore'
import { ElMessage } from 'element-plus'
import router from '../router'

// 创建 axios 实例
const request: AxiosInstance = axios.create({
  baseURL: '/api',  // 基础URL 调试用
  timeout: 5000,    // 请求超时时间
  headers: {
    'Content-Type': 'application/json'
  }
})

// 请求拦截器
request.interceptors.request.use(
  config => {
    const token = localStorage.getItem('token')
    if (token) {
      config.headers['Authorization'] = `Bearer ${token}`
    }
    return config
  },
  error => {
    return Promise.reject(error)
  }
)

// 响应拦截器
request.interceptors.response.use(
  response => {
    return response
  },
  error => {
    if (error.response) {
      const { status } = error.response
      const userStore = useUserStore()

      // 处理 401 未授权错误（token 过期或无效）
      if (status === 401) {
        // 清除用户信息和 token
        userStore.clearUser()
        
        // 显示提示信息
        ElMessage.error('登录已过期，请重新登录')
        
        // 如果不是登录页面，则跳转到登录页
        if (router.currentRoute.value.path !== '/login') {
          router.push('/login')
        }
      }
    }
    return Promise.reject(error)
  }
)

export default request