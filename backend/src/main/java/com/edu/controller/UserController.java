package com.edu.controller;

import com.edu.dto.LoginRequest;
import com.edu.entity.account.User;
import com.edu.entity.view.StudentView;
import com.edu.entity.view.TeacherView;
import com.edu.entity.view.UserView;
import com.edu.service.SequenceService;
import com.edu.service.UserService;
import com.edu.utils.JwtUtils;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;
import java.util.Objects;

/**
 * 用户控制器，处理用户相关的HTTP请求
 * 包括用户登录、验证、查询和更新等功能
 */
@RestController
public class UserController {
    private final UserService userService;
    private final SequenceService sequenceService;

    /**
     * 构造函数，通过依赖注入初始化服务
     * 
     * @param userService 用户服务，处理用户相关的业务逻辑
     * @param sequenceService 序列服务，处理ID生成等功能
     */
    public UserController(UserService userService, SequenceService sequenceService) {
        this.userService = userService;
        this.sequenceService = sequenceService;
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
     * 更新用户信息
     * <p>
     * 根据提供的用户对象更新数据库中对应用户的信息。如果用户不存在，则创建新用户。
     * 该方法支持部分字段更新，未提供的字段将保持原值不变。
     * 
     * @param user 需要更新的用户对象，包含用户ID和需要更新的字段
     *            用户对象必须包含有效的userId
     * @throws IllegalArgumentException 如果提供的用户对象为null或缺少必要字段
     * @throws RuntimeException 当数据库操作失败时抛出
     */
    @PutMapping("user/{userId}")
    public void updateUser(@RequestBody User user) {
        userService.createOrUpdateUser(user);
    }

    /**
     * 用户登录接口
     * <p>
     * 验证用户凭据，生成JWT令牌，并根据用户角色返回不同的用户信息视图。
     * 支持教师、学生和其他类型用户的登录。登录成功后，会生成JWT令牌并返回用户详细信息。
     * 
     * @param request 包含用户ID和密码的登录请求对象
     *               - userId: 用户唯一标识
     *               - password: 用户密码（未加密）
     * @return 包含状态码、令牌和用户信息的响应实体
     *         - 成功：状态码200，包含以下信息：
     *           - JWT令牌（在Authorization头部和响应体中）
     *           - 用户角色（teacher/student/其他）
     *           - 根据角色返回对应的用户详细信息（TeacherView/StudentView/UserView）
     *         - 失败：
     *           - 状态码401：用户凭据无效
     *           - 状态码500：服务器内部错误
     * @throws Exception 当验证过程中发生未预期的错误时抛出
     */
    @PostMapping("/login")
    public ResponseEntity<Map<String, Object>> login(@RequestBody LoginRequest request) {
        try {
            if (userService.validateUserCredentials(request.userId(), request.password())) {
                String token = JwtUtils.generateToken(request.userId());
                String role = userService.getUserInfo(request.userId()).getRoleName();
                Map<String, Object> responseBody;

                if (Objects.equals(role, "teacher")) {
                    TeacherView teacherView = userService.getTeacherInfo(request.userId());
                    responseBody = Map.of(
                            "code", 200,
                            "token", token,
                            "role", role,
                            "userInfo", teacherView);
                } else if (Objects.equals(role, "student")) {
                    StudentView studentView = userService.getStudentInfo(request.userId());
                    responseBody = Map.of(
                            "code", 200,
                            "token", token,
                            "role", role,
                            "userInfo", studentView);
                } else {
                    UserView userView = userService.getUserInfo(request.userId());
                    responseBody = Map.of(
                            "code", 200,
                            "token", token,
                            "role", role,
                            "userInfo", userView);
                }

                return ResponseEntity.ok()
                        .header(HttpHeaders.AUTHORIZATION, "Bearer " + token)
                        .body(responseBody);
            }
            return ResponseEntity.status((HttpStatus.UNAUTHORIZED))
                    .body(Map.of(
                            "code", 401,
                            "message", "Invalid credentials"));
        } catch (Exception e) {
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
     *                  格式必须为："Bearer {token}"
     * @return 无内容的响应实体
     *         - 成功：状态码200（令牌有效）
     *         - 失败：状态码401（令牌无效、过期或格式错误）
     * @throws Exception 当令牌验证过程中发生未预期的错误时抛出
     *                  例如令牌格式错误或签名验证失败
     */
    @GetMapping("/validate-token")
    public ResponseEntity<Void> validateToken(@RequestHeader(HttpHeaders.AUTHORIZATION) String authHeader) {
        try {
            if (authHeader != null && authHeader.startsWith("Bearer ")) {
                String token = authHeader.substring(7);
                if (JwtUtils.validateToken(token)) {
                    return ResponseEntity.ok().build();
                }
            }
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }
    }
}
