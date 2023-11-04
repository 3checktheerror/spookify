package com.xmum.swe.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface TestDao {
    void updateInfo(@Param("userName") String name, @Param("number") int num);
}
