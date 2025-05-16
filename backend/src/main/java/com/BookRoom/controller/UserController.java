package com.BookRoom.controller;

import com.BookRoom.dto.RegisterRequest;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.BookRoom.constants.TokenConstants;
import com.BookRoom.dto.LoginRequest;
import com.BookRoom.entity.account.User;
import com.BookRoom.entity.view.CustomerView;
import com.BookRoom.entity.view.EmployeeView;
import com.BookRoom.entity.view.UserView;
import com.BookRoom.exception.UnauthorizedException;
import com.BookRoom.service.SequenceService;
import com.BookRoom.service.TokenService;
import com.BookRoom.service.UserService;
import com.BookRoom.utils.HttpHeaderUtils;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
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

    /**
     * 根据用户ID获取用户信息
     * <p>
     * 该方法通过路径参数中的用户ID查询并返回用户的详细信息，包括用户名等相关数据。
     * 如果指定ID的用户不存在，将根据服务层的实现返回相应的错误信息或空对象。
     *
     * @param userId 要查询的用户ID，作为路径变量传入
     * @return 返回包含用户详细信息的UserView对象
     */
    @GetMapping("/user/{userId}")
    public UserView getUserByUserId(@PathVariable String userId) {
        return userService.getUserInfoWithUserName(userId);
    }

    /**
     * 根据用户ID获取员工信息
     * <p>
     * 该方法通过路径参数中的用户ID查询并返回员工的详细信息，包括姓名、职称等相关数据。
     * 如果指定ID的员工不存在，将根据服务层的实现返回相应的错误信息或空对象。
     *
     * @param userId 要查询的员工用户ID，作为路径变量传入
     * @return 返回包含员工详细信息的EmployeeView对象
     */
    @GetMapping("/user/employee/{userId}")
    public EmployeeView getEmployeeByUserId(@PathVariable String userId) {
        return userService.getEmployeeInfoByUserId(userId);
    }

    /**
     * 根据用户ID获取顾客信息
     * <p>
     * 该方法通过路径参数中的用户ID查询并返回顾客的详细信息，包括姓名、班级等相关数据。
     * 如果指定ID的顾客不存在，将根据服务层的实现返回相应的错误信息或空对象。
     *
     * @param userId 要查询的顾客用户ID，作为路径变量传入
     * @return 返回包含顾客详细信息的CustomerView对象
     */
    @GetMapping("/user/customer/{userId}")
    public CustomerView getCustomerByUserId(@PathVariable String userId) {
        return userService.getCustomerInfoByUserId(userId);
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

    /**
     * 获取当前登录用户的信息
     * <p>
     * 该方法从HTTP请求中提取当前登录用户的ID，然后查询并返回该用户的详细信息。
     * 用户ID通常由认证过滤器在请求处理过程中设置到请求属性中。
     *
     * @param request HTTP请求对象，包含当前登录用户的ID信息
     * @return 返回包含当前登录用户详细信息的UserView对象
     */
    @GetMapping("/user")
    public UserView getCurrentUserInfo(HttpServletRequest request) {
        String userId = (String) request.getAttribute("userId");
        return userService.getUserInfoWithUserName(userId);
    }

    /**
     * 获取当前登录员工的个人资料信息
     * <p>
     * 该方法从HTTP请求中提取当前登录员工的用户ID，然后查询并返回该员工的详细个人资料信息。
     * 用户ID通常由认证过滤器在请求处理过程中设置到请求属性中。
     *
     * @param request HTTP请求对象，包含当前登录员工用户的ID信息
     * @return 返回包含当前登录员工详细个人资料信息的EmployeeView对象
     */
    @GetMapping("/user/employee/profile")
    public EmployeeView getEmployeeProfile(HttpServletRequest request) {
        String userId = (String) request.getAttribute("userId");
        return userService.getEmployeeInfoByUserId(userId);
    }

    /**
     * 获取当前登录顾客的个人资料信息
     * <p>
     * 该方法从HTTP请求中提取当前登录顾客的用户ID，然后查询并返回该顾客的详细个人资料信息。
     * 用户ID通常由认证过滤器在请求处理过程中设置到请求属性中。
     *
     * @param request HTTP请求对象，包含当前登录顾客的ID信息
     * @return 返回包含当前登录顾客详细个人资料信息的CustomerView对象
     */
    @GetMapping("/user/customer/profile")
    public CustomerView getCustomerProfile(HttpServletRequest request) {
        String userId = (String) request.getAttribute("userId");
        return userService.getCustomerInfoByUserId(userId);
    }

    /**
     * 分页获取所有用户信息
     * <p>
     * 该方法用于分页获取系统中所有注册用户的基本信息。通过UserService调用数据访问层，
     * 检索并返回指定页码和每页记录数的用户记录。
     *
     * @param current 当前页码，默认为1
     * @param size    每页记录数，默认为10
     * @return 包含分页用户信息的Page对象，包含总记录数、总页数、当前页数据等信息
     */
    @GetMapping("/user/getAll")
    public Page<User> getUsersByPage(
            @RequestParam(value = "current", defaultValue = "1") long current,
            @RequestParam(value = "size", defaultValue = "10") long size) {
        return userService.getAllUsersByPage(current, size);
    }

    /**
     * 分页获取所有用户信息
     * <p>
     * 该方法用于分页获取系统中所有注册员工的基本信息。通过UserService调用数据访问层，
     * 检索并返回指定页码和每页记录数的员工记录。
     *
     * @param current 当前页码，默认为1
     * @param size    每页记录数，默认为10
     * @return 包含分页员工信息的Page对象，包含总记录数、总页数、当前页数据等信息
     */
    @GetMapping("user/employee/getPage")
    public Page<EmployeeView> getAllEmployeesByPage(
            @RequestParam(value = "current", defaultValue = "1") long current,
            @RequestParam(value = "size", defaultValue = "16") long size,
            @RequestParam(value = "name", required = false) String name,
            @RequestParam(value = "userId", required = false) String userId,
            @RequestParam(value = "departmentNames", required = false) List<String> departmentNames,
            @RequestParam(value = "titles", required = false) List<String> titles) {
        return userService.getAllEmployeesByPage(current, size, name, userId, departmentNames, titles);
    }

    /**
     * 分页获取所有用户信息
     * <p>
     * 该方法用于分页获取系统中所有注册顾客的基本信息。通过UserService调用数据访问层，
     * 检索并返回指定页码和每页记录数的顾客记录。
     *
     * @param current 当前页码，默认为1
     * @param size    每页记录数，默认为10
     * @return 包含分页顾客信息的Page对象，包含总记录数、总页数、当前页数据等信息
     */
    @GetMapping("user/customer/getPage")
    public Page<CustomerView> getAllCustomersByPage(
            @RequestParam(value = "current", defaultValue = "1") long current,
            @RequestParam(value = "size", defaultValue = "16") long size,
            @RequestParam(value = "name", required = false) String name,
            @RequestParam(value = "userId", required = false) String userId,
            @RequestParam(value = "departmentNames", required = false) List<String> departmentNames) {
        return userService.getAllCustomersByPage(current, size, name, userId, departmentNames);
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
     * 此方法用于验证用户凭据并生成JWT令牌。
     * 登录成功后，JWT令牌将被返回在响应头和响应体中，以便客户端进行后续请求的身份验证。
     *
     * @param request  包含用户登录信息的请求对象，包括：
     *                 - userId: 用户唯一标识符
     *                 - password: 用户密码（明文，与数据库中加密密码进行比对）
     * @param response HTTP响应对象，用于设置cookie等信息
     * @return 响应实体，包含以下信息：
     * - 成功（状态码200）：
     * - token: JWT身份令牌
     * - roleName: 用户角色名称
     * - Authorization头部: Bearer格式的JWT令牌
     * - 失败（状态码401）：身份验证失败
     * - 错误（状态码500）：身份验证过程中发生错误
     * @throws Exception 在身份验证过程中发生的异常，例如数据库连接失败或令牌生成错误
     */
    @PostMapping("/login")
    public ResponseEntity<Map<String, Object>> login(@RequestBody LoginRequest request, HttpServletResponse
            response) {
        String userId = request.userId();
        String password = request.password();
        try {
            if (userService.validateUserCredentials(userId, password)) {
                // 一次性生成 access token 和 refresh token
                TokenService.TokenPair tokenPair = tokenService.createTokenPair(userId);
                String accessToken = tokenPair.accessToken();
                String refreshToken = tokenPair.refreshToken();

                // 设置refreshToken到httpOnly cookie
                Cookie refreshTokenCookie = new Cookie("refreshToken", refreshToken);
                refreshTokenCookie.setHttpOnly(true); // 防止JavaScript访问
                refreshTokenCookie.setPath("/"); // 所有路径都可以访问
                refreshTokenCookie.setMaxAge(TokenConstants.REFRESH_TOKEN_COOKIE_MAX_AGE); // 使用常量设置30天有效期
                refreshTokenCookie.setSecure(true); // 仅在HTTPS连接中传输
                response.addCookie(refreshTokenCookie);

                String roleName = userService.getUserRoleNameByUserId(userId);

                Map<String, Object> responseBody;
                responseBody = Map.of(
                        "token", accessToken,
                        "roleName", roleName);

                return ResponseEntity.ok()
                        .header(HttpHeaders.AUTHORIZATION, "Bearer " + accessToken)
                        .body(responseBody);
            }
            // 身份验证失败
            System.out.println("身份验证失败");
            return ResponseEntity.status((HttpStatus.UNAUTHORIZED)).build();
        } catch (Exception e) {
            // 身份验证过程中发生错误
            System.out.println("身份验证过程中发生错误");
            return ResponseEntity.internalServerError().build();
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
     * - 成功：状态码200（令牌有效）
     * - 失败：状态码401（令牌无效、过期或格式错误）
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
     * - 成功（状态码200）：
     * - code: 状态码(200)
     * - message: 成功信息("Logout successful")
     */
    @PostMapping("/logout")
    public ResponseEntity<Map<String, Object>> logout(
            @CookieValue(name = "refreshToken", required = false) String refreshToken,
            HttpServletResponse response) {
        // 创建一个同名的cookie，但将maxAge设置为0，使其立即过期
        Cookie refreshTokenCookie = new Cookie("refreshToken", "");
        refreshTokenCookie.setHttpOnly(true);
        refreshTokenCookie.setPath("/");
        refreshTokenCookie.setMaxAge(0); // 设置为0表示立即删除
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

    // 新增注册接口
    @PostMapping("/register/employee")
    public ResponseEntity<?> registerEmployee(@RequestBody RegisterRequest request) {
        return doRegister(request, "employee");
    }

    @PostMapping("/register/customer")
    public ResponseEntity<?> registerCustomer(@RequestBody RegisterRequest request) {
        return doRegister(request, "customer");
    }

    private ResponseEntity<?> doRegister(RegisterRequest request, String roleType) {
        try {
            String userId = userService.registerUser(request, roleType);
            return ResponseEntity.ok(Map.of("userId", userId));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(Map.of(
                    "code", 400,
                    "message", e.getMessage()
            ));
        }
    }
}
