package com.edu.utils;

/**
 * HTTP请求头工具类
 * <p>
 * 提供HTTP请求头的解析和验证功能，特别是处理Bearer Token的提取
 */
public class HttpHeaderUtils {
    private static final String BEARER_PREFIX = "Bearer ";

    /**
     * 从Authorization请求头中提取Bearer Token
     * 
     * @param authHeader Authorization请求头的值
     * @return 如果请求头格式正确，返回token值；否则返回null
     */
    public static String extractBearerToken(String authHeader) {
        if (authHeader == null || !authHeader.startsWith(BEARER_PREFIX)) {
            return null;
        }
        return authHeader.substring(BEARER_PREFIX.length());
    }
}