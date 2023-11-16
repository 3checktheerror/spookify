package com.xmum.swe.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.xmum.swe.dao.SaveMapper;
import com.xmum.swe.entities.DO.Save;
import com.xmum.swe.service.SaveService;
import org.springframework.stereotype.Service;

@Service
public class SaveServiceImpl extends ServiceImpl<SaveMapper, Save> implements SaveService{
}
