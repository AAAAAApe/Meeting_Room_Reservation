package com.edu.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.edu.entity.sequence.Sequence;
import com.edu.mapper.SequenceMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class SequenceServiceImpl implements SequenceService {
    private final SequenceMapper sequenceMapper;

    public SequenceServiceImpl(SequenceMapper sequenceMapper) {
        this.sequenceMapper = sequenceMapper;
    }

    @Override
    @Transactional
    public String generateUserId(int year, String role) {
        QueryWrapper<Sequence> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("year", year).eq("role", role);
        Sequence sequence = sequenceMapper.selectOne(queryWrapper);

        // 如果序列不存在，则创建一个新的序列
        if (sequence == null) {
            sequence = new Sequence();
            sequence.setYear(year);
            sequence.setRole(role);
            sequence.setCurrentValue(0);
            sequenceMapper.insert(sequence);
        }

        // 更新序列值
        int newValue = sequence.getCurrentValue() + 1;
        UpdateWrapper<Sequence> updateWrapper = new UpdateWrapper<>();
        updateWrapper.eq("year", year).eq("role", role).set("current_value", newValue);
        sequenceMapper.update(null, updateWrapper);

        // 生成userId
        String prefix = switch (role) {
            case "admin" -> "00000";
            case "teacher" -> year + "1";
            case "student" -> year + "2";
            default -> throw new IllegalArgumentException("Invalid role: " + role);
        };

        return prefix + String.format("%04d", newValue);
    }
}
