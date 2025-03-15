package com.edu.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.edu.constants.TokenConstants;
import com.edu.entity.token.RefreshToken;
import com.edu.mapper.RefreshTokenMapper;
import com.edu.utils.JwtUtils;
import org.springframework.stereotype.Service;
import java.time.LocalDateTime;
import java.util.UUID;

/**
 * 令牌服务实现类
 * <p>
 * 实现AccessToken和 refresh token 的生成、验证和刷新功能
 */
@Service
public class TokenServiceImpl implements TokenService {
    
    /**
     *  refresh token 数据访问接口
     */
    private final RefreshTokenMapper refreshTokenMapper;
        
    /**
     * 构造函数，注入 refresh token 数据访问接口
     * @param refreshTokenMapper  refresh token 数据访问接口
     */
    public TokenServiceImpl(RefreshTokenMapper refreshTokenMapper) {
        this.refreshTokenMapper = refreshTokenMapper;
    }
    
    /**
     * 创建访问令牌 
     * @param userId 用户ID
     * @return 访问令牌字符串
     */
    @Override
    public String createAccessToken(String userId) {
        return JwtUtils.generateToken(userId);
    }
    
    /**
     * 创建刷新令牌
     * @param userId 用户ID
     * @return 刷新令牌实体
     */
    @Override
    public RefreshToken createRefreshToken(String userId) {
        // 生成随机令牌
        String tokenValue = UUID.randomUUID().toString();
        // 设置过期时间
        LocalDateTime expiresAt = LocalDateTime.now().plusDays(TokenConstants.REFRESH_TOKEN_VALIDITY_DAYS);
        
        // 创建 refresh token 实体
        RefreshToken refreshToken = new RefreshToken();
        refreshToken.setUserId(userId);
        refreshToken.setToken(tokenValue);
        refreshToken.setExpiresAt(expiresAt);
        refreshToken.setCreatedAt(LocalDateTime.now());

        // 保存到数据库（如果已存在则更新）
        refreshTokenMapper.insertOrUpdate(refreshToken);
        
        return refreshToken;
    }
    
    /**
     * 一次性创建访问令牌和刷新令牌
     * @param userId 用户ID
     * @return 包含访问令牌和刷新令牌的令牌对
     */
    @Override
    public TokenPair createTokenPair(String userId) {
        // 创建访问令牌
        String accessToken = JwtUtils.generateToken(userId);
        
        // 创建刷新令牌
        RefreshToken refreshToken = createRefreshToken(userId);
        
        // 返回令牌对
        return new TokenPair(accessToken, refreshToken.getToken());
    }
    
    /**
     * 验证访问令牌 
     * @param token 访问令牌字符串
     * @return 是否有效
     */
    @Override
    public boolean verifyAccessToken(String token) {
        return JwtUtils.validateToken(token);
    }
    
    /**
     * 验证刷新令牌
     * @param token 刷新令牌字符串
     * @return 如果有效返回用户ID，否则返回null
     */
    @Override
    public String verifyRefreshToken(String token) {
        // 根据令牌值查询 refresh token
        RefreshToken refreshToken = refreshTokenMapper.selectOne(
                new QueryWrapper<RefreshToken>().eq("token", token));
        
        // 验证 refresh token 是否存在且未过期
        if (refreshToken != null && refreshToken.getExpiresAt().isAfter(LocalDateTime.now())) {
            return refreshToken.getUserId();
        }
        
        return null;
    }
    
    /**
     * 更新令牌 
     * @param refreshToken 刷新令牌字符串
     * @return 新的令牌对，如果刷新令牌无效则返回null
     */
    @Override
    public TokenPair renewTokens(String refreshToken) {
        // 验证刷新令牌
        String userId = verifyRefreshToken(refreshToken);
        
        if (userId != null) {
            // 直接调用createTokenPair创建新的令牌对
            return createTokenPair(userId);
        }
        
        return null;
    }

    @Override
    public void removeRefreshToken(String token) {
        refreshTokenMapper.delete(new QueryWrapper<RefreshToken>().eq("token", token));
    }
}