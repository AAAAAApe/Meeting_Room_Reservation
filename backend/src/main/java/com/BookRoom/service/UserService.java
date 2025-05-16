package com.BookRoom.service;

import com.BookRoom.dto.RegisterRequest;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.BookRoom.entity.account.User;
import com.BookRoom.entity.view.CustomerView;
import com.BookRoom.entity.view.EmployeeView;
import com.BookRoom.entity.view.UserView;

import java.util.List;

public interface UserService {
    /**
     * 根据用户ID查找用户信息（包含密码）
     * @param userId 用户ID
     * @return 用户对象
     */
    User findUserWithPasswordById(String userId);
    
    /**
     * 获取用户基本信息
     * @param userId 用户ID
     * @return 用户视图对象
     */
    UserView getUserInfoByUserId(String userId);
    
    /**
     * 获取包含用户名的用户信息
     * @param userId 用户ID
     * @return 包含用户名的用户视图对象
     */
    UserView getUserInfoWithUserName(String userId);
    
    /**
     * 根据用户ID获取用户角色名称
     * @param userId 用户ID
     * @return 角色名称
     */
    String getUserRoleNameByUserId(String userId);
    
    /**
     * 获取员工信息
     * @param userId 用户ID
     * @return 员工视图对象
     */
    EmployeeView getEmployeeInfoByUserId(String userId);
    
    /**
     * 获取顾客信息
     * @param userId 用户ID
     * @return 顾客视图对象
     */
    CustomerView getCustomerInfoByUserId(String userId);
    
    /**
     * 验证用户凭证
     * @param userId 用户ID
     * @param password 密码
     * @return 验证是否成功
     */
    boolean validateUserCredentials(String userId, String password);

    /**
     * 分页获取所有用户信息
     * @param current 当前页码
     * @param size 每页记录数
     * @return 包含分页用户信息的Page对象，包含总记录数、总页数、当前页数据等信息
     */
    Page<User> getAllUsersByPage(long current, long size);

    /**
     * 分页获取所有员工信息
     * @param current 当前页码
     * @param size 每页记录数
     * @return 包含分页员工信息的Page对象，包含总记录数、总页数、当前页数据等信息
     */
    Page<EmployeeView> getAllEmployeesByPage(long current, long size, String name, String userId, List<String> departmentNames, List<String> titles);

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
    Page<CustomerView> getAllCustomersByPage(long current, long size, String name, String userId, List<String> departmentNames);

    void createOrUpdateUser(User user);
    void removeUserById(String userId);
    String registerUser(RegisterRequest request, String roleType);
}
