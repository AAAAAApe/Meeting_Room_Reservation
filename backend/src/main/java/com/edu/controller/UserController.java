package com.edu.controller;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.edu.constants.TokenConstants;
import com.edu.dto.LoginRequest;
import com.edu.entity.account.User;
import com.edu.entity.view.UserView;
import com.edu.exception.UnauthorizedException;
import com.edu.service.SequenceService;
import com.edu.service.TokenService;
import com.edu.service.UserService;
import com.edu.utils.HttpHeaderUtils;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

/**
 * 用户控制器，处理用户相关的HTTP请求
 * 包括用户登录、验证、查询和更新等功能
 */
@RestController
public class UserController {
    private final UserService userService;
    private final SequenceService sequenceService;
    private final TokenService tokenService;

    /**
     * 构造函数，通过依赖注入初始化服务
     * 
     * @param userService     用户服务，处理用户相关的业务逻辑
     * @param sequenceService 序列服务，处理ID生成等功能
     * @param tokenService    令牌服务，处理令牌的生成、验证和刷新
     */
    public UserController(UserService userService, SequenceService sequenceService, TokenService tokenService) {
        this.userService = userService;
        this.sequenceService = sequenceService;
        this.tokenService = tokenService;
    }

    @GetMapping("/user/{userId}")
    public UserView getUserByUserId(@PathVariable String userId) {
        return userService.getUserInfoWithUserName(userId);
    }

    /**
     * 验证并提取token中的用户ID
     *
     * @param authHeader 包含Bearer令牌的Authorization请求头
     * @return 验证通过的用户ID
     * @throws UnauthorizedException 当令牌无效或验证失败时抛出
     */
    private String validateAndExtractUserId(String authHeader) {
        String token = HttpHeaderUtils.extractBearerToken(authHeader);
        if (token != null && tokenService.verifyAccessToken(token)) {
            return HttpHeaderUtils.extractBearerToken(authHeader);
        }
        throw new UnauthorizedException("Invalid or expired token");
    }

    @GetMapping("/user")
    public UserView getUserByRequest(@RequestHeader(HttpHeaders.AUTHORIZATION) String authHeader) {
        String userId = validateAndExtractUserId(authHeader);
        return userService.getUserInfoWithUserName(userId);
    }

    /**
     * 获取所有用户信息
     * <p>
     * 该方法用于获取系统中所有注册用户的基本信息。通过UserService调用数据访问层，
     * 检索并返回所有用户记录。
     * 
     * @return 返回包含所有用户信息的List集合，每个元素为User对象
     *         如果没有用户记录，将返回空列表
     */
    @GetMapping("/users")
    public List<User> getAllUsers() {
        return userService.getAllUsers();
    }
    
    /**
     * 分页获取所有用户信息
     * <p>
     * 该方法用于分页获取系统中所有注册用户的基本信息。通过UserService调用数据访问层，
     * 检索并返回指定页码和每页记录数的用户记录。
     * 
     * @param current 当前页码，默认为1
     * @param size 每页记录数，默认为10
     * @return 返回包含分页用户信息的Page对象，包含总记录数、总页数、当前页数据等信息
     */
    @GetMapping("/users/page")
    public Page<User> getUsersByPage(
            @RequestParam(value = "current", defaultValue = "1") long current,
            @RequestParam(value = "size", defaultValue = "10") long size) {
        return userService.getUsersByPage(current, size);
    }

    /**
     * 更新用户信息
     * <p>
     * 根据提供的用户对象更新数据库中对应用户的信息。如果用户不存在，则创建新用户。
     * 该方法支持部分字段更新，未提供的字段将保持原值不变。
     * 
     * @param user 需要更新的用户对象，包含用户ID和需要更新的字段
     *             用户对象必须包含有效的userId
     * @throws IllegalArgumentException 如果提供的用户对象为null或缺少必要字段
     * @throws RuntimeException         当数据库操作失败时抛出
     */
    @PutMapping("user/{userId}")
    public void updateUser(@RequestBody User user) {
        userService.createOrUpdateUser(user);
    }

    /**
     * 用户登录接口
     * <p>
     * 验证用户凭据并生成JWT令牌。根据用户角色（教师、学生或其他）返回相应的用户信息。
     * 登录成功后，JWT令牌将同时在响应头和响应体中返回，便于客户端后续请求的身份验证。
     * 
     * @param request 登录请求对象，包含以下必要信息：
     *                - userId: 用户唯一标识符
     *                - password: 用户密码（明文，将与数据库中加密密码进行比对）
     * @return 响应实体，包含以下信息：
     *         - 成功（状态码200）：
     *           - code: 状态码(200)
     *           - token: JWT身份令牌
     *           - role: 用户角色(admin/teacher/student/其他)
     *           - userName: 用户名称（教师/学生姓名或用户ID）
     *           - Authorization头部: Bearer格式的JWT令牌
     *         - 失败（状态码401）：
     *           - code: 状态码(401)
     *           - message: 错误信息("Invalid credentials")
     *         - 错误（状态码500）：
     *           - code: 状态码(500)
     *           - message: 错误信息("Authentication failed")
     * @throws Exception 身份验证过程中发生的异常，如数据库连接失败或令牌生成错误
     */
    @PostMapping("/login")
    public ResponseEntity<Map<String, Object>> login(@RequestBody LoginRequest request, HttpServletResponse response) {
        String userId = request.userId();
        String password = request.password();
        try {
            if (userService.validateUserCredentials(userId, password)) {
                System.out.println("验证通过");
                System.out.println("生成 access token 和 refresh token...");
                // 一次性生成 access token 和 refresh token
                System.out.println("generating...");
                TokenService.TokenPair tokenPair = tokenService.createTokenPair(userId);
                String accessToken = tokenPair.accessToken();
                System.out.println("access token: " + accessToken);
                String refreshToken = tokenPair.refreshToken();
                System.out.println("refresh token: " + refreshToken);
                System.out.println("ok");

                System.out.println("获取用户信息...");
                // 获取用户信息
                UserView userView = userService.getUserInfoWithUserName(userId);
                String roleName = userView.getRoleName();
                System.out.println("role name:" + roleName);
                String userName = userView.getUserName();
                System.out.println("user name:" + userName);
                System.out.println("ok");

                System.out.println("设置refreshToken到httpOnly cookie...");
                // 设置refreshToken到httpOnly cookie
                Cookie refreshTokenCookie = new Cookie("refreshToken", refreshToken);
                refreshTokenCookie.setHttpOnly(true);  // 防止JavaScript访问
                refreshTokenCookie.setPath("/");      // 所有路径都可以访问
                refreshTokenCookie.setMaxAge(TokenConstants.REFRESH_TOKEN_COOKIE_MAX_AGE);  // 使用常量设置30天有效期
                refreshTokenCookie.setSecure(true);   // 仅在HTTPS连接中传输
                response.addCookie(refreshTokenCookie);
                System.out.println("ok");

                // userName为可选值
                Map<String, Object> responseBody;
                if (userName != null && !userName.isEmpty()) {
                    responseBody = Map.of(
                            "code", 200,
                            "token", accessToken,
                            "roleName", roleName,
                            "userName", userName);
                } else {
                    responseBody = Map.of(
                            "code", 200,
                            "token", accessToken,
                            "roleName", roleName);
                }

                return ResponseEntity.ok()
                        .header(HttpHeaders.AUTHORIZATION, "Bearer " + accessToken)
                        .body(responseBody);
            }
            // 身份验证失败
            System.out.println("身份验证失败");
            return ResponseEntity.status((HttpStatus.UNAUTHORIZED))
                    .body(Map.of(
                            "code", 401,
                            "message", "Invalid credentials"));
        } catch (Exception e) {
            // 身份验证过程中发生错误
            System.out.println("身份验证过程中发生错误");
            return ResponseEntity.internalServerError()
                    .body(Map.of(
                            "code", 500,
                            "message", "Authentication failed"));
        }
    }

    /**
     * 验证JWT令牌的有效性
     * <p>
     * 从请求头中提取Bearer令牌并验证其有效性。该方法用于客户端验证当前持有的令牌是否仍然有效，
     * 通常在用户会话期间定期调用以确保会话的有效性。
     * 
     * @param authHeader 包含Bearer令牌的Authorization请求头
     *                   格式必须为："Bearer {token}"
     * @return 无内容的响应实体
     *         - 成功：状态码200（令牌有效）
     *         - 失败：状态码401（令牌无效、过期或格式错误）
     * @throws Exception 当令牌验证过程中发生未预期的错误时抛出
     *                   例如令牌格式错误或签名验证失败
     */
    @GetMapping("/validate-token")
    public ResponseEntity<Void> validateToken(@RequestHeader(HttpHeaders.AUTHORIZATION) String authHeader) {
        try {
            validateAndExtractUserId(authHeader);
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }
    }

    /**
     * 用户登出
     * <p>
     * 清除用户的refreshToken cookie
     * 
     * @param response HTTP响应对象，用于清除Cookie
     * @return 响应实体，包含以下信息：
     *         - 成功（状态码200）：
     *           - code: 状态码(200)
     *           - message: 成功信息("Logout successful")
     */
    @PostMapping("/logout")
    public ResponseEntity<Map<String, Object>> logout(
            @CookieValue(name = "refreshToken", required = false) String refreshToken,
            HttpServletResponse response) {
        // 创建一个同名的cookie，但将maxAge设置为0，使其立即过期
        Cookie refreshTokenCookie = new Cookie("refreshToken", "");
        refreshTokenCookie.setHttpOnly(true);
        refreshTokenCookie.setPath("/");
        refreshTokenCookie.setMaxAge(0);  // 设置为0表示立即删除
        refreshTokenCookie.setSecure(true);
        
        // 添加到响应中
        response.addCookie(refreshTokenCookie);

        // 如果请求中包含有效的refreshToken，则从数据库中删除它
        if (refreshToken != null && !refreshToken.isEmpty()) {
            System.out.println("deleting refresh token from database");
            // 删除数据库中的refreshToken
            tokenService.removeRefreshToken(refreshToken);
        }
        
        // 返回成功响应
        return ResponseEntity.ok()
                .body(Map.of(
                        "code", 200,
                        "message", "Logout successful"));
    }
}
