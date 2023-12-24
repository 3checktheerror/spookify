package com.xmum.swe.service.impl;

import cn.hutool.core.util.ObjectUtil;
import com.alibaba.fastjson2.JSON;
import com.alibaba.fastjson2.JSONObject;
import com.alibaba.fastjson2.filter.SimplePropertyPreFilter;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.xmum.swe.dao.ItemDao;
import com.xmum.swe.dao.VisitorDao;
import com.xmum.swe.entities.BO.VisitorBO;
import com.xmum.swe.entities.DO.DetailDO;
import com.xmum.swe.entities.DO.OrderDO;
import com.xmum.swe.entities.VO.VisitorInsertVO;
import com.xmum.swe.entities.VO.VisitorModifyVO;
import com.xmum.swe.exception.SpookifyBusinessException;
import com.xmum.swe.service.IdService;
import com.xmum.swe.service.VisitorService;
import com.xmum.swe.utils.JsonUtil;
import com.xmum.swe.utils.SpookifyTimeStamp;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.sql.Timestamp;
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

    @Resource
    private IdService idService;


    public OrderDO getVisitorById(String id) {
        OrderDO visitor = visitorDao.selectById(id);
        Optional.ofNullable(visitor)
                .orElseThrow(() -> new SpookifyBusinessException("No such visitor!"));
        return visitor;
    }

    public List<OrderDO> getAllVisitors() {
        List<OrderDO> visitors = visitorDao.selectList(null);
        Optional.ofNullable(visitors)
                .orElseThrow(() -> new SpookifyBusinessException("items list is empty!"));
        return visitors;
    }

    public List<DetailDO> getItemsWithVid(String vid){
        List<DetailDO> items = itemDao.selectList(new QueryWrapper<DetailDO>().and(i -> i.eq("v_id_fk", vid)));
        return items;
    }

    public List<String> getIidWithVid(String vid){
        List<DetailDO> items = this.getItemsWithVid(vid);
        List<String> res = items.stream().map(DetailDO::getIId).collect(Collectors.toList());
        return res;
    }

    public OrderDO getVisitorWithMaxId() {
        OrderDO[] arr = (OrderDO[])visitorDao.selectList(new QueryWrapper<OrderDO>().orderByDesc("v_id"))
                .stream().
                limit(1)
                .toArray(OrderDO[]::new);
        if(ObjectUtil.isNotEmpty(arr)) return arr[0];
        else {
            OrderDO orderDO = new OrderDO();
            orderDO.setVId("SPVT000001");
            return orderDO;
        }
    }

    public Map<String, Object> insertVisitor(OrderDO orderDO) {
        int num = visitorDao.insert(orderDO);
        Map<String, Object> map = new HashMap<>();
        map.put("num", num);
        map.put("id", orderDO.getVId());
        return map;
    }

    public boolean checkVisitorName(String name) {
        OrderDO visitor = visitorDao.selectOne(new QueryWrapper<OrderDO>().eq("name", name));
        return !ObjectUtil.isNull(visitor);
    }


    public Map<String, Object> updateVisitorById(OrderDO orderDO) {
        int num = visitorDao.updateById(orderDO);
        Map<String, Object> map = new HashMap<>();
        map.put("num", num);
        map.put("id", orderDO.getVId());
        return map;
    }

    public Map<String, Object> deleteVisitorWithItems(String id) {
        int itemNum = itemDao.delete(new QueryWrapper<DetailDO>().and(i -> i.eq("v_id_fk", id)));
        int visitorNum = visitorDao.delete(new QueryWrapper<OrderDO>().and(i -> i.eq("v_id", id)));
        if(visitorNum != 1) throw new SpookifyBusinessException("delete more than one visitor at time???");
        Map<String, Object> map = new HashMap<>();
        map.put("itemNum", itemNum);
        map.put("visitorNum", visitorNum);
        return map;
    }

    @Override
    public Map<String, Object> insertVisitor(VisitorInsertVO visitorVO) {
        //Layer 1
        if(this.checkVisitorName(visitorVO.getName())) {
            Map<String, Object> map = new HashMap<>();
            map.put("Error", "visitor name exists!");
            return map;
        }
        String nextId = idService.getNextId(this.getVisitorWithMaxId().getVId());
        //Layer 2
        VisitorBO visitorBO = new VisitorBO();
        BeanUtils.copyProperties(visitorVO, visitorBO, "map");
        Timestamp curTime = SpookifyTimeStamp.getInstance().getTimeStamp();
        visitorBO.setVId(nextId);
        visitorBO.setVtCreate(curTime);
        visitorBO.setVtModified(curTime);
        visitorBO.setOpType("Insert");
        Map<String, Object> map = visitorVO.getMap();
        SimplePropertyPreFilter filter = new SimplePropertyPreFilter();
        filter.getExcludes().add("data");
        filter.getExcludes().add("file");
        JSONObject obj = JSON.parseObject(JSON.toJSONString(visitorBO, filter));
        if(ObjectUtil.isNotNull(map)) obj.putAll(map);
        visitorBO.setData(obj.toJSONString());
        //Layer 3
        OrderDO orderDO = new OrderDO();
        BeanUtils.copyProperties(visitorBO, orderDO);
        return this.insertVisitor(orderDO);
    }

    @Override
    public Map<String, Object> modifyVisitor(VisitorModifyVO visitorVO) {
        //Layer 1
        OrderDO preDO = this.getVisitorById(visitorVO.getVId());
        JSONObject preData = JSON.parseObject(preDO.getData());
        SimplePropertyPreFilter filter = new SimplePropertyPreFilter();
        filter.getExcludes().add("map");
        JSONObject VO_data = JSON.parseObject(JSON.toJSONString(visitorVO, filter));
        if(ObjectUtil.isNotNull(visitorVO.getMap())) VO_data.putAll(visitorVO.getMap());     //get whole VO data
        //Layer 2
        JsonUtil.merge(preData, VO_data);
        preData.put("status", "modified");
        preData.put("opType", "modify");
        preData.put("itModified", SpookifyTimeStamp.getInstance().getTimeStamp());
        VisitorBO visitorBO = JSON.parseObject(preData.toJSONString(), VisitorBO.class);
        visitorBO.setData(preData.toJSONString());
        //Layer 3
        OrderDO orderDO = new OrderDO();
        BeanUtils.copyProperties(visitorBO, orderDO);
        return this.updateVisitorById(orderDO);
    }
}
