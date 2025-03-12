package com.edu.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.edu.dto.UserDTO;
import com.edu.entity.account.User;
import org.apache.ibatis.annotations.Param;

public interface UserMapper extends BaseMapper<User> {
    UserDTO getStudentInfo(@Param("userId") String userId);
    UserDTO getTeacherInfo(@Param("userId") String userId);
}
