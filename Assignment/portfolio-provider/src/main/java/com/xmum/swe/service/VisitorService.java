package com.xmum.swe.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.xmum.swe.dao.ItemDao;
import com.xmum.swe.dao.VisitorDao;
import com.xmum.swe.entities.DO.VisitorDO;
import com.xmum.swe.exception.SpookifyBusinessException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Optional;

@Service
@Slf4j
public class VisitorService {
    @Resource
    private VisitorDao visitorDao;

    @Resource
    private ItemDao itemDao;


    public VisitorDO getVisitorById(String id) {
        VisitorDO visitor = visitorDao.selectById(id);
        Optional.ofNullable(visitor)
                .orElseThrow(() -> new SpookifyBusinessException("No such visitor!"));
        return visitor;
    }

    public List<VisitorDO> getAllVisitors() {
        List<VisitorDO> visitors = visitorDao.selectList(null);
        Optional.ofNullable(visitors)
                .orElseThrow(() -> new SpookifyBusinessException("items list is empty!"));
        return visitors;
    }

    public List<String> getIidsWithVid(String vid) {
//        VisitorDO visitor = this.getVisitorById(vid);
//        VisitorDO visitor = itemDao.selectList(new QueryWrapper<VisitorDO>().eq("v_id", vid).select("i_id_fk")).var
//        Optional.ofNullable(visitor)
//                .orElseThrow(() -> new SpookifyBusinessException("No such visitor!"));
//        return visitor;
    }
}
