package com.xmum.swe.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.xmum.swe.entities.DO.OrderDO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface VisitorDao extends BaseMapper<OrderDO> {
}
