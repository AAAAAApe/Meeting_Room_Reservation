/**
 * Token服务，用于管理token的存储、获取和清除
 */
import { useTokenStore } from '../../stores/tokenStore';
import axios from 'axios';
import baseConfig from './baseConfig';

const tokenService = {
  /**
   * 获取token
   * @returns token字符串或null
   */
  getToken(): string | null {
    const tokenStore = useTokenStore();
    return tokenStore.getToken();
  },

  /**
   * 设置token
   * @param token token字符串
   */
  setToken(token: string | null): void {
    const tokenStore = useTokenStore();
    tokenStore.setToken(token);
  },

  /**
   * 清除token
   */
  clearToken(): void {
    const tokenStore = useTokenStore();
    tokenStore.clearToken();
  },

  validateToken(): Promise<boolean> {
    return new Promise(async (resolve) => {
      try {
        // 发送请求验证token
        const response = await axios.post('/validate-token');
        // 如果验证成功，返回true
        if (response.data.code === 200) {
          resolve(true);
        } else {
          // 如果验证失败，返回false
          resolve(false);
        }
      } catch (error) {
        // 如果请求失败，返回false
        resolve(false);
      }
    });
  },

  /**
   * @description 刷新 access token
   * @returns {Promise<boolean>} - 返回刷新结果，true表示成功，false表示失败
   */
  async refreshToken(): Promise<boolean> {
    try {
      // 创建一个不带token的axios实例，专门用于刷新token
      // 避免使用已过期的token导致请求失败
      const refreshInstance = axios.create(baseConfig);

      /**
       * 发送刷新token请求
       * 注意：refreshToken通常由服务器通过httpOnly cookie管理
       * 所以这里只需要发送请求，不需要额外携带refreshToken
       */
      const response = await refreshInstance.post('/refresh-token');

      // 如果请求成功且返回了新token
      if (response.data.code === 200 && response.data.token) {
        // 更新存储中的token
        this.setToken(response.data.token);
        return true;
      }
      return false;
    } catch (error) {
      // 记录刷新token失败的错误
      console.error('刷新token失败', error);
      return false;
    }
  }
};

export default tokenService;