-- 创建刷新令牌表
CREATE TABLE IF NOT EXISTS refresh_token
(
    user_id    CHAR(9)  NOT NULL,               -- 用户ID，主键
    token      CHAR(36) NOT NULL,               -- 刷新令牌
    expires_at DATETIME NOT NULL,               -- 过期时间
    created_at DATETIME NOT NULL DEFAULT NOW(), -- 创建时间
    PRIMARY KEY (user_id),
    FOREIGN KEY (user_id) REFERENCES user (user_id) ON DELETE CASCADE,
    UNIQUE (token)                              -- 确保令牌唯一
);