package com.BookRoom.service;

import com.BookRoom.entity.sequence.Sequence;
import com.github.jeffreyning.mybatisplus.service.IMppService;

/**
 * 序列号服务接口
 * 用于生成用户ID的序列号管理服务，继承自IMppService以支持多主键操作
 */
public interface SequenceService extends IMppService<Sequence> {
    /**
     * 生成用户ID
     * 根据年份和角色名生成唯一的用户ID，格式为：年份+角色ID+4位序号
     * 例如：2023010001 表示2023年第一个教师账号
     *
     * @param year 年份
     * @param role 角色名称
     * @return 生成的用户ID字符串
     * @throws com.BookRoom.exception.RoleNotFoundException 当指定的角色名不存在时抛出此异常
     */
    String generateUserId(int year, String role);
}
