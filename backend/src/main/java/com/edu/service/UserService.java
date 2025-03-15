package com.edu.service;

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
    List<User> getAllUsers();
    void createOrUpdateUser(User user);
    void removeUserById(String userId);
}
