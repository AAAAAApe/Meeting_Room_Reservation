package com.edu.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.edu.entity.account.User;
import com.edu.entity.view.UserView;
import org.apache.ibatis.annotations.Param;

public interface UserMapper extends BaseMapper<User> {
    UserView getUserInfoById(@Param("userId") String userId);
}
