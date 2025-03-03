package com.edu.service;

import com.edu.entity.account.User;

public interface UserService {
    public User findUserById(String userId);
    public boolean validateUser(String userId, String password);
}
