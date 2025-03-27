package com.edu.utils;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.JwtException;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.security.Keys;

import javax.crypto.SecretKey;
import java.nio.charset.StandardCharsets;
import java.util.Date;

/**
 * JWT（JSON Web Token）工具类
 * <p>
 * 提供JWT令牌的生成、解析和验证功能。使用HMAC-SHA算法进行签名，
 * 支持令牌的过期时间设置和验证。
 */
public class JwtUtils {
    /**
     * JWT签名密钥
     * 优先从环境变量JWT_SECRET获取，如果未设置则使用默认值
     */
    private static final String SECRET = System.getenv("JWT_SECRET") != null ?
            System.getenv("JWT_SECRET") : "defaultStrongSecretKeyWith32BytesLength!";

    /**
     * 用于签名的密钥对象
     * 使用HMAC-SHA算法，基于SECRET生成
     */
    private static final SecretKey KEY = Keys.hmacShaKeyFor(SECRET.getBytes(StandardCharsets.UTF_8));

    /**
     * 令牌过期时间（毫秒）
     * 当前设置为30分钟
     */
    private static final long EXPIRATION = 1000 * 60 * 30;

    /**
     * 生成JWT令牌
     * 
     * @param userId 用户ID，用作令牌的主题（subject）
     * @return 生成的JWT令牌字符串
     */
    public static String generateToken(String userId) {
        return Jwts.builder()
                .issuer("edu-system")
                .subject(userId)
                .expiration(new Date(System.currentTimeMillis() + EXPIRATION))
                .signWith(KEY)
                .compact();
    }

    /**
     * 解析JWT令牌
     * 
     * @param token JWT令牌字符串
     * @return Claims对象，包含令牌中的声明信息
     * @throws JwtException 当令牌无效或已过期时抛出
     */
    public static Claims parseToken(String token) {
        return Jwts.parser()
                .verifyWith(KEY)
                .requireIssuer("edu-system")
                .build()
                .parseSignedClaims(token)
                .getPayload();
    }

    /**
     * 验证JWT令牌的有效性
     * 
     * @param token JWT令牌字符串
     * @return 如果令牌有效返回true，否则返回false
     */
    public static boolean validateToken(String token) {
        try {
            parseToken(token);
            return true;
        } catch (JwtException e) {
            return false;
        }
    }
}
