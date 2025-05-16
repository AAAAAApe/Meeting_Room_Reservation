package com.BookRoom.service;

import com.BookRoom.dto.RegisterRequest;
import com.BookRoom.entity.account.CustomerInfo;
import com.BookRoom.entity.account.EmployeeInfo;
import com.BookRoom.entity.account.UserInfo;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.BookRoom.entity.account.User;
import com.BookRoom.entity.view.CustomerView;
import com.BookRoom.entity.view.EmployeeView;
import com.BookRoom.entity.view.UserView;
import com.BookRoom.mapper.*;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Year;
import java.util.List;

@Service
public class UserServiceImpl implements UserService{
    private final UserMapper userMapper;
    private final UserViewMapper userViewMapper;
    private final EmployeeViewMapper employeeViewMapper;
    private final CustomerViewMapper customerViewMapper;
    private final EmployeeInfoMapper employeeInfoMapper;
    private final CustomerInfoMapper customerInfoMapper;
    private final UserInfoMapper userInfoMapper;
    private final SequenceService sequenceService;
    private final RoleService roleService;

    public UserServiceImpl(UserMapper userMapper, UserViewMapper userViewMapper, EmployeeViewMapper employeeViewMapper, CustomerViewMapper customerViewMapper, EmployeeInfoMapper employeeInfoMapper, CustomerInfoMapper customerInfoMapper, UserInfoMapper userInfoMapper, SequenceService sequenceService, RoleService roleService){
        this.userMapper = userMapper;
        this.userViewMapper = userViewMapper;
        this.employeeViewMapper = employeeViewMapper;
        this.customerViewMapper = customerViewMapper;
        this.employeeInfoMapper = employeeInfoMapper;
        this.customerInfoMapper = customerInfoMapper;
        this.userInfoMapper = userInfoMapper;
        this.sequenceService = sequenceService;
        this.roleService = roleService;
    }

    private final BCryptPasswordEncoder bCryptPasswordEncoder = new BCryptPasswordEncoder();

    /**
     * 根据用户ID查找用户信息（包含密码）
     * @param userId 用户ID
     * @return 用户对象
     */
    @Override
    public User findUserWithPasswordById(String userId){
        return userMapper.selectById(userId);
    }

    /**
     * 获取用户基本信息
     * @param userId 用户ID
     * @return 用户视图对象
     */
    @Override
    public UserView getUserInfoByUserId(String userId){
        return userViewMapper.selectById(userId);
    }

    /**
     * 获取包含用户名的用户信息
     * @param userId 用户ID
     * @return 包含用户名的用户视图对象
     */
    @Override
    public UserView getUserInfoWithUserName(String userId){
        UserView userView = userViewMapper.selectById(userId);
        if (userView == null) {
            return null;
        }
        userView.setName(switch (userView.getRoleName()) {
            case "employee" -> employeeViewMapper.selectById(userId).getName();
            case "customer" -> customerViewMapper.selectById(userId).getName();
            default -> null;
        });
        return userView;
    }

    /**
     * 根据用户ID获取用户角色名称
     * @param userId 用户ID
     * @return 角色名称
     */
    @Override
    public String getUserRoleNameByUserId(String userId) {
        return userViewMapper.selectById(userId).getRoleName();
    }

    /**
     * 获取员工信息
     * @param userId 用户ID
     * @return 员工视图对象
     */
    @Override
    public EmployeeView getEmployeeInfoByUserId(String userId) {
        return employeeViewMapper.selectById(userId);
    }

    /**
     * 获取顾客信息
     * @param userId 用户ID
     * @return 顾客视图对象
     */
    @Override
    public CustomerView getCustomerInfoByUserId(String userId) {
        return customerViewMapper.selectById(userId);
    }

    /**
     * 验证用户凭证
     * @param userId 用户ID
     * @param password 密码
     * @return 验证是否成功
     */
    @Override
    public boolean validateUserCredentials(String userId, String password) {
        // debug
        System.out.println("Validating user: " + userId);
        System.out.println("Password: " + password);

        User user = findUserWithPasswordById(userId);
        if (user == null) {
            System.out.println("User not found");
            return false;
        }
        return bCryptPasswordEncoder.matches(password, user.getEncryptedPassword());
    }
    
    /**
     * 分页获取所有用户信息
     * @param current 当前页码
     * @param size 每页记录数
     * @return 包含分页用户信息的Page对象，包含总记录数、总页数、当前页数据等信息
     */
    @Override
    public Page<User> getAllUsersByPage(long current, long size) {
        Page<User> page = new Page<>(current, size);
        return userMapper.selectPage(page, null);
    }

    /**
     * 分页获取所有用户信息
     * @param current 当前页码
     * @param size 每页记录数
     * @return 包含分页员工信息的Page对象，包含总记录数、总页数、当前页数据等信息
     */
    @Override
    public Page<EmployeeView> getAllEmployeesByPage(long current, long size, String name, String userId, List<String> departmentNames, List<String> titles) {
        Page<EmployeeView> page = new Page<>(current, size);
        LambdaQueryWrapper<EmployeeView> queryWrapper = new LambdaQueryWrapper<>();
        
        // 添加姓名模糊查询条件
        if (name != null && !name.isEmpty()) {
            queryWrapper.like(EmployeeView::getName, name);
        }
        
        // 添加用户ID模糊查询条件
        if (userId != null && !userId.isEmpty()) {
            queryWrapper.like(EmployeeView::getUserId, userId);
        }

        return employeeViewMapper.selectPage(page, queryWrapper);
    }

    /**
     * 分页获取所有顾客信息
     *
     * @param current         当前页码
     * @param size            每页记录数
     * @param name
     * @param userId
     * @param departmentNames
     * @return 包含分页顾客信息的Page对象，包含总记录数、总页数、当前页数据等信息
     */
    @Override
    public Page<CustomerView> getAllCustomersByPage(long current, long size, String name, String userId, List<String> departmentNames) {
        Page<CustomerView> page = new Page<>(current, size);
        LambdaQueryWrapper<CustomerView> queryWrapper = new LambdaQueryWrapper<>();

        // 添加姓名模糊查询条件
        if (name != null && !name.isEmpty()) {
            queryWrapper.like(CustomerView::getName, name);
        }

        // 添加用户ID模糊查询条件
        if (userId != null && !userId.isEmpty()) {
            queryWrapper.like(CustomerView::getUserId, userId);
        }

        return customerViewMapper.selectPage(page, queryWrapper);
    }

    /**
     * 创建或更新用户信息
     * @param user 用户对象
     */
    @Override
    public void createOrUpdateUser(User user) {
        userMapper.insertOrUpdate(user);
    }

    /**
     * 根据用户ID删除用户
     * @param userId 用户ID
     */
    @Override
    public void removeUserById(String userId) {
        userMapper.deleteById(userId);
    }

    // 新增注册方法
    @Override
    @Transactional
    public String registerUser(RegisterRequest request, String roleType) {
        try {
            // 1. 生成用户ID（使用您的SequenceService）
            int currentYear = Year.now().getValue();
            String userId = sequenceService.generateUserId(currentYear, roleType);

            // 2. 创建用户主体
            User user = new User();
            user.setUserId(userId);
            user.setRoleId(getRoleId(roleType)); // 需要实现getRoleId方法
            user.setEncryptedPassword(bCryptPasswordEncoder.encode(request.getPassword()));
            userMapper.insert(user);

            // 3. 创建用户信息
            UserInfo userInfo = new UserInfo();
            userInfo.setUserId(userId);
            userInfo.setName(request.getName());
            userInfo.setGender(convertGender(request.getGender()));
            userInfo.setBirthday(request.getBirthday());
            userInfoMapper.insert(userInfo);

            // 4. 创建角色特定信息
            createRoleSpecificInfo(roleType, userId);

            return userId;
        } catch (Exception e) {
            throw new RuntimeException("注册失败: " + e.getMessage());
        }
    }

    private Byte getRoleId(String roleType) {
        return roleService.getRoleId(roleType);
    }

    private Boolean convertGender(Integer gender) {
        return gender != null ? gender == 1 : null;
    }

    private void createRoleSpecificInfo(String roleType, String userId) {
        switch (roleType.toLowerCase()) {
            case "employee":
                EmployeeInfo employeeInfo = new EmployeeInfo();
                employeeInfo.setUserId(userId);
                employeeInfoMapper.insert(employeeInfo);
                break;
            case "customer":
                CustomerInfo customerInfo = new CustomerInfo();
                customerInfo.setUserId(userId);
                customerInfoMapper.insert(customerInfo);
                break;
            default:
                throw new IllegalArgumentException("无效的用户类型");
        }
    }
}
