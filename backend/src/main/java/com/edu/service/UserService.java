package com.edu.service;

import com.edu.entity.account.User;

public interface UserService {
    User findUserById(String userId);
    boolean validateUser(String userId, String password);
}
