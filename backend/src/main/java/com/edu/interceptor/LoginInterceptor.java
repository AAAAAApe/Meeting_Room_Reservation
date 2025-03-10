package com.edu.interceptor;

import com.edu.utils.JwtUtils;
import com.fasterxml.jackson.databind.ObjectMapper;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.JwtException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.http.HttpHeaders;
import org.springframework.web.servlet.HandlerInterceptor;

import java.io.IOException;
import java.util.List;
import java.util.Map;

public class LoginInterceptor implements HandlerInterceptor {
    private static final List<String> WHILE_LIST = List.of("/login");

    @Override
    public boolean preHandle(HttpServletRequest request,
                             HttpServletResponse response,
                             Object handler) throws Exception {
        if (WHILE_LIST.stream().anyMatch(request.getRequestURI()::startsWith)) {
            return true;
        }

        String authHeader = request.getHeader(HttpHeaders.AUTHORIZATION);
        if (authHeader == null || !authHeader.startsWith("Bearer ")) {
            sendError(response, 401, "Missing authorization header");
            return false;
        }

        String token = authHeader.substring(7);
        try {
            Claims claims = JwtUtils.parseToken(token);
            request.setAttribute("userId", claims.getSubject());
            return true;
        } catch (ExpiredJwtException e) {
            return false;
        } catch (JwtException e) {
            sendError(response, 401, "Invalid token");
            return false;
        }
    }

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
