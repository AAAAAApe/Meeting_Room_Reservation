package com.edu.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.edu.entity.account.User;
import com.edu.entity.view.StudentView;
import com.edu.entity.view.TeacherView;
import com.edu.entity.view.UserView;

import java.util.List;

public interface UserService {
    User findUserWithPasswordById(String userId);
    UserView getUserInfo(String userId);
    UserView getUserInfoWithUserName(String userId);
    TeacherView getTeacherInfo(String userId);
    StudentView getStudentInfo(String userId);
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
