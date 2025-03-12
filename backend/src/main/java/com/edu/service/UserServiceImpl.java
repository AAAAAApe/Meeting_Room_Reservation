package com.edu.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.edu.entity.account.User;
import com.edu.entity.view.StudentView;
import com.edu.entity.view.TeacherView;
import com.edu.entity.view.UserView;
import com.edu.mapper.UserMapper;
import com.edu.mapper.TeacherViewMapper;
import com.edu.mapper.StudentViewMapper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserServiceImpl implements UserService{
    private final UserMapper userMapper;
    private final TeacherViewMapper teacherViewMapper;
    private final StudentViewMapper studentViewMapper;

    public UserServiceImpl(UserMapper userMapper, TeacherViewMapper teacherViewMapper, StudentViewMapper studentViewMapper){
        this.userMapper = userMapper;
        this.teacherViewMapper = teacherViewMapper;
        this.studentViewMapper = studentViewMapper;
    }

    private final BCryptPasswordEncoder bCryptPasswordEncoder = new BCryptPasswordEncoder();

    @Override
    public User findUserWithPasswordById(String userId){
        return userMapper.selectOne(new QueryWrapper<User>().eq("user_id", userId));
    }

    @Override
    public UserView getUserInfo(String userId){
        return userMapper.getUserInfoById(userId);
    }

    @Override
    public TeacherView getTeacherInfo(String userId) {
        return teacherViewMapper.selectOne(new QueryWrapper<TeacherView>().eq("user_id", userId));
    }

    @Override
    public StudentView getStudentInfo(String userId) {
        return studentViewMapper.selectOne(new QueryWrapper<StudentView>().eq("user_id", userId));
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
