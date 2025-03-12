package com.edu.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.edu.entity.sequence.Sequence;
import com.edu.exception.RoleNotFoundException;
import com.edu.mapper.SequenceMapper;
import com.github.jeffreyning.mybatisplus.service.MppServiceImpl;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * 序列号服务实现类
 * 负责生成用户ID的具体实现逻辑，通过维护序列表来确保生成的ID唯一性
 * 继承自MppServiceImpl以支持多主键操作，实现SequenceService接口
 */
@Service
public class SequenceServiceImpl extends MppServiceImpl<SequenceMapper, Sequence> implements SequenceService {
    private final SequenceMapper sequenceMapper;
    private final RoleService roleService;

    public SequenceServiceImpl(SequenceMapper sequenceMapper, RoleService roleService) {
        this.sequenceMapper = sequenceMapper;
        this.roleService = roleService;
    }

    /**
     * 生成用户ID
     * 该方法通过年份和角色名生成唯一的用户ID，格式为：年份+角色ID+4位序号
     * 使用事务确保序列号的原子性更新
     *
     * @param year 年份，用于生成ID的前缀
     * @param roleName 角色名称，用于获取对应的角色ID
     * @return 生成的用户ID字符串，例如：2023010001表示2023年第一个教师账号
     * @throws RoleNotFoundException 当指定的角色名不存在时抛出此异常
     */
    @Override
    @Transactional
    public String generateUserId(int year, String roleName) {
        // 1. 通过角色名获取角色ID
        // 如果角色不存在，将抛出RoleNotFoundException异常
        Byte roleId = roleService.getRoleId(roleName);
        if (roleId == null) {
            throw new RoleNotFoundException("找不到对应的角色: " + roleName);
        }

        // 2. 查询当前年份和角色ID对应的序列记录
        QueryWrapper<Sequence> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("year", year).eq("role_id", roleId);
        Sequence sequence = sequenceMapper.selectOne(queryWrapper);

        // 3. 如果序列记录不存在，创建新的序列记录
        // 初始化序列值为0
        if (sequence == null) {
            sequence = new Sequence();
            sequence.setYear(year);
            sequence.setRoleId(roleId);
            sequence.setCurrentValue(0);
            sequenceMapper.insert(sequence);
        }

        // 4. 更新序列值
        // 在事务控制下，确保序列值的原子性更新
        int newValue = sequence.getCurrentValue() + 1;
        UpdateWrapper<Sequence> updateWrapper = new UpdateWrapper<>();
        updateWrapper.eq("year", year).eq("role_id", roleId).set("current_value", newValue);
        sequenceMapper.update(null, updateWrapper);

        // 5. 生成最终的用户ID
        // 格式：年份 + 角色ID + 4位序号
        String prefix = String.valueOf(year) + String.valueOf(roleId);

        return prefix + String.format("%04d", newValue);
    }
}
