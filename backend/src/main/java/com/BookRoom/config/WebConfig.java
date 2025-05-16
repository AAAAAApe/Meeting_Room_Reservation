package com.BookRoom.config;

import com.BookRoom.interceptor.LoginInterceptor;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(new LoginInterceptor())
                .addPathPatterns("/**")  // 拦截所有请求
                .excludePathPatterns(     // 允许访问的路径
                        "/login",
                        "/refresh-token",
                        "/swagger-ui/**",
                        "/webjars/**",
                        "/v3/api-docs/**",
                        "/hello",
                        "/validate-token",
                        "/logout",
                        "/register/employee",
                        "/register/customer"
                );
    }
}