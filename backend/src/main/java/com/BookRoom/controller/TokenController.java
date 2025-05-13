package com.BookRoom.controller;

import com.BookRoom.constants.TokenConstants;
import com.BookRoom.service.TokenService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.CookieValue;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletResponse;
import java.util.Map;

/**
 * 令牌控制器
 * <p>
 * 处理令牌相关的HTTP请求，包括刷新令牌等功能
 */
@RestController
public class TokenController {
    private final TokenService tokenService;
    public TokenController(TokenService tokenService) {
        this.tokenService = tokenService;
    }
    
    /**
     * 刷新 access token 
     * <p>
     * 使用有效的刷新令牌获取新的 access token 和刷新令牌。
     * 如果刷新令牌有效，则返回新的令牌对；否则返回错误信息。
     * 
     * @param refreshToken 从Cookie中获取的刷新令牌
     * @param response HTTP响应对象，用于设置Cookie
     * @return 响应实体，包含以下信息：
     *         - 成功（状态码200）：
     *           - code: 状态码(200)
     *           - token: 新的 access token 
     *           - refreshToken: 新的刷新令牌
     *         - 失败（状态码401）：
     *           - code: 状态码(401)
     *           - message: 错误信息("Invalid refresh token")
     */
    @PostMapping("/refresh-token")
    public ResponseEntity<Map<String, Object>> refreshToken(
            @CookieValue(name = "refreshToken", required = false) String refreshToken,
            HttpServletResponse response) {
        
        if (refreshToken == null || refreshToken.isEmpty()) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                    .body(Map.of(
                            "code", 400,
                            "message", "Refresh token is required"));
        }
        
        TokenService.TokenPair tokenPair = tokenService.renewTokens(refreshToken);
        
        if (tokenPair != null) {
            // 设置 refresh token 到 httpOnly cookie
            Cookie refreshTokenCookie = new Cookie("refreshToken", tokenPair.refreshToken());
            refreshTokenCookie.setHttpOnly(true);  // 防止JavaScript访问
            refreshTokenCookie.setPath("/");      // 所有路径都可以访问
            refreshTokenCookie.setMaxAge(TokenConstants.REFRESH_TOKEN_COOKIE_MAX_AGE);  // 使用常量设置30天有效期
            refreshTokenCookie.setSecure(true);   // 仅在HTTPS连接中传输
            
            response.addCookie(refreshTokenCookie);
            
            // 返回响应，不再在响应体中包含 refresh token
            return ResponseEntity.ok()
                    .body(Map.of(
                            "code", 200,
                            "token", tokenPair.accessToken()));
        } else {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                    .body(Map.of(
                            "code", 401,
                            "message", "Invalid refresh token"));
        }
    }
}