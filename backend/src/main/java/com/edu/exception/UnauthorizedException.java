package com.edu.exception;

/**
 * 未授权异常
 * <p>
 * 当用户访问需要授权的资源但未提供有效凭证时抛出此异常
 * 通常在以下情况下使用：
 * - 访问令牌无效或已过期
 * - 用户未登录
 * - 用户没有访问特定资源的权限
 */
public class UnauthorizedException extends RuntimeException {
    
    /**
     * 使用指定的错误消息构造一个新的未授权异常
     *
     * @param message 详细描述异常原因的错误消息
     */
    public UnauthorizedException(String message) {
        super(message);
    }

    /**
     * 使用指定的错误消息和导致此异常的原因构造一个新的未授权异常
     *
     * @param message 详细描述异常原因的错误消息
     * @param cause   导致此异常的原因
     */
    public UnauthorizedException(String message, Throwable cause) {
        super(message, cause);
    }
}