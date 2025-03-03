package com.edu.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.edu.entity.account.User;
import com.edu.mapper.UserMapper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService{
    private final UserMapper userMapper;
    public UserServiceImpl(UserMapper userMapper){ this.userMapper = userMapper; }

    private final BCryptPasswordEncoder bCryptPasswordEncoder = new BCryptPasswordEncoder();

    @Override
    public User findUserById(String userId){
        return userMapper.selectOne(new QueryWrapper<User>().eq("userId", userId));
    }

    @Override
    public boolean validateUser(String userId, String password) {
        User user = findUserById(userId);
        if (user == null) {
            return false;
        }
        return bCryptPasswordEncoder.matches(password, user.getEncryptedPassword());
    }
}
