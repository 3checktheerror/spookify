package com.xmum.swe.service.impl;

import cn.hutool.core.util.ObjectUtil;
import com.alibaba.fastjson2.JSON;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.xmum.swe.dao.ItemDao;
import com.xmum.swe.dao.VisitorDao;
import com.xmum.swe.entities.BO.VisitorBO;
import com.xmum.swe.entities.BO.VisitorNoMapBO;
import com.xmum.swe.entities.CommonResult;
import com.xmum.swe.entities.DO.ItemDO;
import com.xmum.swe.entities.DO.VisitorDO;
import com.xmum.swe.entities.VO.VisitorInsertVO;
import com.xmum.swe.entities.VO.VisitorModifyVO;
import com.xmum.swe.enums.IdPos;
import com.xmum.swe.exception.SpookifyBusinessException;
import com.xmum.swe.service.VisitorService;
import com.xmum.swe.utils.MapUtil;
import com.xmum.swe.utils.SpookifyTimeStamp;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@Slf4j
public class VisitorServiceImpl implements VisitorService {
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

    public Map<String, Object> insertVisitor(VisitorDO visitorDO) {
        int num = visitorDao.insert(visitorDO);
        Map<String, Object> map = new HashMap<>();
        map.put("num", num);
        map.put("id", visitorDO.getVId());
        return map;
    }

    public boolean checkVisitorName(String name) {
        VisitorDO visitor = visitorDao.selectOne(new QueryWrapper<VisitorDO>().eq("name", name));
        return !ObjectUtil.isNull(visitor);
    }


    public Map<String, Object> updateVisitorById(VisitorDO visitorDO) {
        int num = visitorDao.updateById(visitorDO);
        Map<String, Object> map = new HashMap<>();
        map.put("num", num);
        map.put("id", visitorDO.getVId());
        return map;
    }

    public Map<String, Object> deleteVisitorWithItems(String id) {
        int itemNum = itemDao.delete(new QueryWrapper<ItemDO>().and(i -> i.eq("v_id_fk", id)));
        int visitorNum = visitorDao.delete(new QueryWrapper<VisitorDO>().and(i -> i.eq("v_id", id)));
        if(visitorNum != 1) throw new SpookifyBusinessException("delete more than one visitor at time???");
        Map<String, Object> map = new HashMap<>();
        map.put("itemNum", itemNum);
        map.put("visitorNum", visitorNum);
        return map;
    }

    @Override
    public Map<String, Object> insertVisitor(VisitorInsertVO visitorVO) {
        //first check if vistor's name exists
        if(this.checkVisitorName(visitorVO.getName())) {
            Map<String, Object> map = new HashMap<>();
            map.put("Error", "visitor name exists!");
            return map;
        }
        //get new id
        VisitorDO maxIdVt = this.getVisitorWithMaxId();
        String visitorId = maxIdVt.getVId();
        String oldSubString = visitorId.substring(IdPos.ID_ENTITY_NUM.getPos(), IdPos.ID_END.getPos());
        String newSubString = String.valueOf(String.format("%06d", Integer.parseInt(oldSubString) + 1));
        String newVisitorId = StringUtils.replace(visitorId, oldSubString, newSubString);
        log.info("----------VisitorId:old-new: " + visitorId + "-" + newVisitorId + "------------------");
        //Eliminate and store map
        Map<String, Object> preMap = visitorVO.getMap();
        VisitorNoMapBO visitorNoMapBO = new VisitorNoMapBO();
        BeanUtils.copyProperties(visitorVO, visitorNoMapBO);  //filter
        //Insert user input fields (exclude data)
        VisitorBO visitorBO = new VisitorBO();
        BeanUtils.copyProperties(visitorNoMapBO, visitorBO);
        visitorBO.setVId(newVisitorId);
        visitorBO.setVtCreate(SpookifyTimeStamp.getInstance().getTimeStamp());
        visitorBO.setVtModified(SpookifyTimeStamp.getInstance().getTimeStamp());
        visitorBO.setOpType("Insert");
        //Insert data (updated fields + user input)
        if(ObjectUtil.isNotNull(preMap)) {
            Map curMap = MapUtil.merge(JSON.parseObject(JSON.toJSONString(visitorBO), Map.class), preMap);
            visitorBO.setData(JSON.toJSONString(curMap));
        } else {
            visitorBO.setData(JSON.toJSONString(visitorBO));
        }
        VisitorDO visitorDO = new VisitorDO();
        BeanUtils.copyProperties(visitorBO, visitorDO);
        Map<String, Object> map = this.insertVisitor(visitorDO);
        return map;
    }

    @Override
    public Map<String, Object> modifyVisitor(VisitorModifyVO visitorVO) {
        String id = visitorVO.getVId();
        VisitorDO preDO = this.getVisitorById(id);
        Map preMap = JSON.parseObject(preDO.getData(), Map.class);
        VisitorNoMapBO visitorNoMapBO = new VisitorNoMapBO();
        BeanUtils.copyProperties(visitorVO, visitorNoMapBO);
        Map map1 = JSON.parseObject(JSON.toJSONString(visitorNoMapBO), Map.class);
        Map map2 = MapUtil.merge(map1, visitorVO.getMap());
        Map map = MapUtil.merge(preMap, map2);
        map.put("vtModified", SpookifyTimeStamp.getInstance().getTimeStamp());
        map.put("status", "modified");
        map.put("opType", "modify");
        VisitorBO visitorBO = JSON.parseObject(JSON.toJSONString(map), VisitorBO.class);
        visitorBO.setData(JSON.toJSONString(map));
        VisitorDO visitorDO = new VisitorDO();
        BeanUtils.copyProperties(visitorBO, visitorDO);
        Map<String, Object> res = this.updateVisitorById(visitorDO);
        return res;
    }
}
