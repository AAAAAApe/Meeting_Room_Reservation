package com.BookRoom.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.BookRoom.entity.account.Role;
import com.BookRoom.mapper.RoleMapper;
import org.springframework.stereotype.Service;

@Service
public class RoleServiceImpl implements RoleService {
    private final RoleMapper roleMapper;
    public RoleServiceImpl(RoleMapper roleMapper) { this.roleMapper = roleMapper; }

    @Override
    public Byte getRoleId(String roleName) {
        return roleMapper.selectOne(new QueryWrapper<Role>().eq("role_name", roleName)).getRoleId();
    }

    @Override
    public String getRoleName(Byte roleId) {
        return roleMapper.selectOne(new QueryWrapper<Role>().eq("role_id", roleId)).getRoleName();
    }
}
