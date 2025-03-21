/**
 * @description 创建axios实例的基础配置
 * @property {string} baseURL - API的基础URL，优先从环境变量获取，默认为'/api'
 * @property {number} timeout - 请求超时时间，单位毫秒
 * @property {object} headers - 请求头配置
 */
const baseConfig = {
  baseURL: import.meta.env.VITE_API_BASE_URL || '/api', // 从环境变量获取API基础URL
  timeout: 10000, // 请求超时时间
  headers: {
    'Content-Type': 'application/json' // 默认请求内容类型为JSON
  }
};

export default baseConfig;