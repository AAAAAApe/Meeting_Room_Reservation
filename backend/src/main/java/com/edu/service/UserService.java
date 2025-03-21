package com.edu.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.edu.entity.account.User;
import com.edu.entity.view.StudentView;
import com.edu.entity.view.TeacherView;
import com.edu.entity.view.UserView;

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
    UserView getUserInfo(String userId);
    
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
     * 获取教师信息
     * @param userId 用户ID
     * @return 教师视图对象
     */
    TeacherView getTeacherInfo(String userId);
    
    /**
     * 获取学生信息
     * @param userId 用户ID
     * @return 学生视图对象
     */
    StudentView getStudentInfo(String userId);
    
    /**
     * 验证用户凭证
     * @param userId 用户ID
     * @param password 密码
     * @return 验证是否成功
     */
    boolean validateUserCredentials(String userId, String password);
    /**
     * 获取所有用户信息（不分页）
     * @return 所有用户列表
     */
    List<User> getAllUsers();
    
    /**
     * 分页获取所有用户信息
     * @param current 当前页码
     * @param size 每页记录数
     * @return 分页用户列表
     */
    Page<User> getUsersByPage(long current, long size);
    
    void createOrUpdateUser(User user);
    void removeUserById(String userId);
}
