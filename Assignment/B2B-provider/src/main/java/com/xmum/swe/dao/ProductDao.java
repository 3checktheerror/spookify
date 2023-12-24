package com.xmum.swe.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.xmum.swe.entities.DO.OrderDO;
import com.xmum.swe.entities.DO.ProductDO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ProductDao extends BaseMapper<ProductDO> {
}
