package com.BookRoom.service;

import com.BookRoom.entity.token.RefreshToken;

/**
 * 令牌服务接口
 * <p>
 * 提供 access token 和 refresh token 的生成、验证和刷新功能
 */
public interface TokenService {
    /**
     * 创建访问令牌
     * 
     * @param userId 用户ID
     * @return 访问令牌字符串
     */
    String createAccessToken(String userId);
    
    /**
     * 创建刷新令牌
     * 
     * @param userId 用户ID
     * @return 刷新令牌实体，包含令牌值和过期时间
     */
    RefreshToken createRefreshToken(String userId);
    
    /**
     * 一次性创建访问令牌和刷新令牌
     * 
     * @param userId 用户ID
     * @return 包含访问令牌和刷新令牌的令牌对
     */
    TokenPair createTokenPair(String userId);
    
    /**
     * 验证访问令牌
     * 
     * @param token 访问令牌
     * @return 如果令牌有效返回true，否则返回false
     */
    boolean verifyAccessToken(String token);
    
    /**
     * 验证刷新令牌
     * 
     * @param token 刷新令牌
     * @return 如果令牌有效返回用户ID，否则返回null
     */
    String verifyRefreshToken(String token);
    
    /**
     * 更新令牌
     * 
     * @param refreshToken 刷新令牌
     * @return 包含新的访问令牌和刷新令牌的对象，如果更新失败返回null
     */
    TokenPair renewTokens(String refreshToken);

    /**
     * 移除令牌
     *
     * @param token refresh token
     */
    void removeRefreshToken(String token);
    
    /**
     * 令牌对，包含访问令牌和刷新令牌
     */
    record TokenPair(String accessToken, String refreshToken) {}
}