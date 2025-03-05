package com.edu.service;

import com.edu.entity.account.User;

import java.util.List;

public interface UserService {
    User findUserById(String userId);
    boolean validateUser(String userId, String password);
    List<User> findAllUsers();
    void insertUser(User user);
    void deleteUser(String userId);
}
