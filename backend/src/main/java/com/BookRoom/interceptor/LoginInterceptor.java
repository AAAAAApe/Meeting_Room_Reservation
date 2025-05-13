package com.BookRoom.interceptor;

import com.BookRoom.utils.JwtUtils;
import com.fasterxml.jackson.databind.ObjectMapper;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.JwtException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.http.HttpHeaders;
import org.springframework.web.servlet.HandlerInterceptor;

import java.io.IOException;
import java.util.Map;

/**
 * 登录拦截器
 * <p>
 * 该拦截器用于验证用户是否已登录。通过检查请求头中的JWT令牌来验证用户身份。
 * 白名单URL路径配置在WebConfig类中，这些路径将跳过此拦截器。
 * 对于需要验证的请求，将解析JWT令牌并将用户ID设置到请求属性中供后续处理使用。
 * </p>
 */
public class LoginInterceptor implements HandlerInterceptor {
    // 白名单配置已移至WebConfig类中的excludePathPatterns配置

    /**
     * 请求预处理方法
     * <p>
     * 在Controller处理请求前被调用，用于验证用户是否已登录。
     * 验证流程：
     * 1. 检查请求头中是否包含有效的Authorization头部
     * 2. 解析JWT令牌，验证其有效性
     * 3. 将用户ID设置到请求属性中供后续处理使用
     * </p>
     *
     * @param request  HTTP请求对象
     * @param response HTTP响应对象
     * @param handler  处理请求的处理器对象
     * @return 如果验证通过返回true，否则返回false
     * @throws Exception 处理过程中可能抛出的异常
     */
    @Override
    public boolean preHandle(HttpServletRequest request,
                             HttpServletResponse response,
                             Object handler) throws Exception {

        String authHeader = request.getHeader(HttpHeaders.AUTHORIZATION);
        // 检查请求头中是否包含有效的Authorization头部
        if (authHeader == null || !authHeader.startsWith("Bearer ")) {
            sendError(response, 401, "Missing authorization header");
            return false;
        }

        // 解析JWT令牌
        String token = authHeader.substring(7);
        try {
            Claims claims = JwtUtils.parseToken(token);
            request.setAttribute("userId", claims.getSubject());
            return true;
        } catch (ExpiredJwtException e) {
            sendError(response, 401, "Token expired");
            return false;
        } catch (JwtException e) {
            sendError(response, 401, "Invalid token");
            return false;
        }
    }

    /**
     * 发送错误响应
     * <p>
     * 当验证失败时，向客户端发送包含错误码和错误信息的JSON格式响应。
     * </p>
     *
     * @param response HTTP响应对象
     * @param code     HTTP状态码
     * @param message  错误信息
     * @throws IOException 写入响应时可能抛出的IO异常
     */
    private void sendError(HttpServletResponse response, int code, String message) throws IOException {
        response.setStatus(code);
        response.setContentType("application/json");
        response.getWriter().write(
                new ObjectMapper().writeValueAsString(Map.of(
                        "code", code,
                        "message", message
                )));
    }
}
