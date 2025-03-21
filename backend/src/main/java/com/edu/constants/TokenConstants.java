package com.edu.constants;

/**
 * Token相关常量
 * <p>
 * 定义与Token相关的常量值，用于统一管理Token的有效期等配置
 */
public class TokenConstants {
    
    /**
     * refresh token 有效期（天）
     */
    public static final int REFRESH_TOKEN_VALIDITY_DAYS = 30;
    
    /**
     * refresh token cookie有效期（秒）
     * REFRESH_TOKEN_VALIDITY_DAYS * 24小时 * 60分钟 * 60秒
     */
    public static final int REFRESH_TOKEN_COOKIE_MAX_AGE = REFRESH_TOKEN_VALIDITY_DAYS * 24 * 60 * 60;
}