package com.edu.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.edu.entity.account.User;
import com.edu.entity.view.StudentView;
import com.edu.entity.view.TeacherView;
import com.edu.entity.view.UserView;
import com.edu.mapper.UserMapper;
import com.edu.mapper.UserViewMapper;
import com.edu.mapper.TeacherViewMapper;
import com.edu.mapper.StudentViewMapper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserServiceImpl implements UserService{
    private final UserMapper userMapper;
    private final UserViewMapper userViewMapper;
    private final TeacherViewMapper teacherViewMapper;
    private final StudentViewMapper studentViewMapper;

    public UserServiceImpl(UserMapper userMapper, UserViewMapper userViewMapper, TeacherViewMapper teacherViewMapper, StudentViewMapper studentViewMapper){
        this.userMapper = userMapper;
        this.userViewMapper = userViewMapper;
        this.teacherViewMapper = teacherViewMapper;
        this.studentViewMapper = studentViewMapper;
    }

    private final BCryptPasswordEncoder bCryptPasswordEncoder = new BCryptPasswordEncoder();

    @Override
    public User findUserWithPasswordById(String userId){
        return userMapper.selectById(userId);
    }

    @Override
    public UserView getUserInfo(String userId){
        return userViewMapper.selectById(userId);
    }

    @Override
    public UserView getUserInfoWithUserName(String userId){
        UserView userView = userViewMapper.selectById(userId);
        if (userView == null) {
            return null;
        }
        userView.setUserName(switch (userView.getRoleName()) {
            case "teacher" -> teacherViewMapper.selectById(userId).getName();
            case "student" -> studentViewMapper.selectById(userId).getName();
            default -> null;
        });
        return userView;
    }

    @Override
    public TeacherView getTeacherInfo(String userId) {
        return teacherViewMapper.selectById(userId);
    }

    @Override
    public StudentView getStudentInfo(String userId) {
        return studentViewMapper.selectById(userId);
    }

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

    @Override
    public List<User> getAllUsers() {
        return userMapper.selectList(new QueryWrapper<User>().select("*"));
    }

    @Override
    public void createOrUpdateUser(User user) {
        userMapper.insertOrUpdate(user);
    }

    @Override
    public void removeUserById(String userId) {
        userMapper.deleteById(userId);
    }
}
