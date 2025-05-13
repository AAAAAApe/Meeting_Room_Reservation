package com.BookRoom.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.BookRoom.entity.token.RefreshToken;
import org.apache.ibatis.annotations.Mapper;

/**
 * refresh token 数据访问接口
 * <p>
 * 提供对 refresh token 表的基本CRUD操作
 */
@Mapper
public interface RefreshTokenMapper extends BaseMapper<RefreshToken> {
}