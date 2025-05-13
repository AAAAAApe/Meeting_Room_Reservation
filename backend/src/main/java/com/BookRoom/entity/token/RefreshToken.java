package com.BookRoom.entity.token;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * refresh token 实体类
 * <p>
 * 用于存储用户的 refresh token 信息，支持令牌刷新机制
 */
@Data
@TableName("refresh_token")
public class RefreshToken {
    @TableId
    private String userId;         // 用户ID，主键
    private String token;          // 刷新令牌
    private LocalDateTime expiresAt; // 过期时间
    private LocalDateTime createdAt; // 创建时间
}