package com.xmum.swe.service;

import cn.hutool.core.util.ObjectUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.xmum.swe.dao.ItemDao;
import com.xmum.swe.dao.VisitorDao;
import com.xmum.swe.entities.DO.ItemDO;
import com.xmum.swe.entities.DO.VisitorDO;
import com.xmum.swe.exception.SpookifyBusinessException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

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

    public List<ItemDO> getItemsWithVid(String vid){
        List<ItemDO> items = itemDao.selectList(new QueryWrapper<ItemDO>().and(i -> i.eq("v_id_fk", vid)));
        return items;
    }

    public List<String> getIidWithVid(String vid){
        List<ItemDO> items = this.getItemsWithVid(vid);
        List<String> res = items.stream().map(ItemDO::getIId).collect(Collectors.toList());
        return res;
    }

    public VisitorDO getVisitorWithMaxId() {
        return (VisitorDO) visitorDao.selectList(new QueryWrapper<VisitorDO>().orderByDesc("v_id"))
                .stream().
                limit(1)
                .toArray()[0];
    }

    public int insertVisitor(VisitorDO visitorDO) {
        int num = visitorDao.insert(visitorDO);
        return num;
    }

    public boolean checkVisitorName(String name) {
        VisitorDO visitor = visitorDao.selectOne(new QueryWrapper<VisitorDO>().eq("name", name));
        return !ObjectUtil.isNull(visitor);
    }
}
