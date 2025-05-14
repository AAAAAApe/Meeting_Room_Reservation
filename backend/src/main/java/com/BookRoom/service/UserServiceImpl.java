package com.BookRoom.service;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.BookRoom.entity.account.User;
import com.BookRoom.entity.view.CustomerView;
import com.BookRoom.entity.view.EmployeeView;
import com.BookRoom.entity.view.UserView;
import com.BookRoom.mapper.*;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserServiceImpl implements UserService{
    private final UserMapper userMapper;
    private final UserViewMapper userViewMapper;
    private final EmployeeViewMapper employeeViewMapper;
    private final CustomerViewMapper customerViewMapper;

    public UserServiceImpl(UserMapper userMapper, UserViewMapper userViewMapper, EmployeeViewMapper employeeViewMapper, CustomerViewMapper customerViewMapper){
        this.userMapper = userMapper;
        this.userViewMapper = userViewMapper;
        this.employeeViewMapper = employeeViewMapper;
        this.customerViewMapper = customerViewMapper;
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
        
        // 添加部门名称条件查询
        if (departmentNames != null && !departmentNames.isEmpty()) {
            queryWrapper.in(EmployeeView::getDepartmentName, departmentNames);
        }

        // 按职称筛选
        if (titles != null && !titles.isEmpty()) {
            queryWrapper.in(EmployeeView::getTitle, titles);
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

        // 添加部门名称条件查询
        if (departmentNames != null && !departmentNames.isEmpty()) {
            queryWrapper.in(CustomerView::getDepartmentName, departmentNames);
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
}
