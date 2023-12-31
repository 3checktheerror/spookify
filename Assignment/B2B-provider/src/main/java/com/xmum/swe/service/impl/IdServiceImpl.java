package com.xmum.swe.service.impl;

import com.xmum.swe.enums.IdPos;
import com.xmum.swe.service.IdService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import javax.annotation.Resource;

@Service
@Slf4j
public class IdServiceImpl implements IdService {

    @Override
    public String getNextId(String curMaxId) {
        String oldSubString = curMaxId.substring(IdPos.ID_ENTITY_NUM.getPos(), IdPos.ID_END.getPos());
        String newSubString = String.valueOf(String.format("%06d", Integer.parseInt(oldSubString) + 1));
        String newItemId = StringUtils.replace(curMaxId, oldSubString, newSubString);
        log.info("----------ItemId:old-new: " + curMaxId + "-" + newItemId + "------------------");
        return newItemId;
    }
}
