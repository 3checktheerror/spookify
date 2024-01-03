package com.xmum.swe.service.impl;

import cn.hutool.core.util.ObjectUtil;
import com.alibaba.fastjson2.JSON;
import com.alibaba.fastjson2.JSONObject;
import com.alibaba.fastjson2.filter.SimplePropertyPreFilter;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.xmum.swe.dao.OrderDao;
import com.xmum.swe.entities.BO.OrderBO;
import com.xmum.swe.entities.DO.OrderDO;
import com.xmum.swe.entities.VO.OrderInsertVO;
import com.xmum.swe.entities.VO.OrderModifyVO;
import com.xmum.swe.enums.IdPos;
import com.xmum.swe.exception.SpookifyBusinessException;
import com.xmum.swe.service.DetailService;
import com.xmum.swe.service.OrderService;
import com.xmum.swe.service.IdService;
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

@Service
@Slf4j
public class OrderServiceImpl implements OrderService {

    @Resource
    private OrderDao orderDao;

    @Resource
    private IdService idService;

    @Resource
    private DetailService detailService;

//    @Resource
//    private RedisTemplate redisTemplate;

    public OrderDO getOrderById(String id) {
//        if(redisTemplate.hasKey(id)) {
//            return (OrderDO)redisTemplate.opsForValue().get(id);
//        }
        OrderDO order = orderDao.selectById(id);
        Optional.ofNullable(order)
                .orElseThrow(() -> new SpookifyBusinessException("No such order!"));
        return order;
    }

    public List<OrderDO> getAllOrders(){
        List<OrderDO> orders = orderDao.selectList(null);
        Optional.ofNullable(orders)
                .orElseThrow(() -> new SpookifyBusinessException("No orders!"));
//        orders.stream().forEach(order -> {
//            redisTemplate.opsForValue().set(order.getOId(), order);
//        });
        return orders;
    }

    public OrderDO getOrderWithMaxId() {
        OrderDO[] arr = (OrderDO[])orderDao.selectList(new QueryWrapper<OrderDO>().orderByDesc("o_id"))
                .stream().
                limit(1)
                .toArray(OrderDO[]::new);
        if(!ObjectUtil.isEmpty(arr)) return arr[0];
        else {
            OrderDO orderDO = new OrderDO();
            orderDO.setOId("SPOD000001");
            return orderDO;
        }
    }
    public Map<String, Object> insertIOrder(OrderDO orderDO){
        int num = orderDao.insert(orderDO);
        Map<String, Object> map = new HashMap<>();
        map.put("num", num);
        map.put("id", orderDO.getOId());
        return map;
    }

    public Map<String, Object> updateOrderById(OrderDO orderDO) {
        int num = orderDao.updateById(orderDO);
        Map<String, Object> map = new HashMap<>();
        map.put("num", num);
        map.put("id", orderDO.getOId());
        return map;
    }

    public int deleteOrderWithId(String id) {
        int num = orderDao.deleteById(id);
        detailService.deleteDetailWithOid(id);
        return num;
    }

    public void updateBalanceOfCustomer(String cusId, float deductNum) {
        if(!cusId.startsWith("SPCS") || cusId.length() != IdPos.ID_END.getPos()) throw new SpookifyBusinessException("cusId is not valid");
        OrderDO orderDO = orderDao.selectOne(new QueryWrapper<OrderDO>().and((i) -> {
            i.eq("customer_id", cusId);
        }));
        if(ObjectUtil.isNull(orderDO)) throw new SpookifyBusinessException("no such customer!");
        float remainNum = orderDO.getBalance() - deductNum;
        OrderDO updateEntity = new OrderDO();
        updateEntity.setBalance(remainNum);
        updateEntity.setOpType("Modified");
        updateEntity.setOdModified(SpookifyTimeStamp.getInstance().getTimeStamp());
        orderDao.update(updateEntity, new UpdateWrapper<OrderDO>().eq("customer_id", cusId));
    }

    @Override
    public Map<String, Object> insertOrder(OrderInsertVO orderVO) {
        //Layer 1
        String nextId = idService.getNextId(this.getOrderWithMaxId().getOId());
        //Layer 2
        OrderBO orderBO = new OrderBO();
        BeanUtils.copyProperties(orderVO, orderBO, "map");
        Timestamp curTime = SpookifyTimeStamp.getInstance().getTimeStamp();
        orderBO.setOId(nextId);
        orderBO.setOdCreate(curTime);
        orderBO.setOdModified(curTime);
        orderBO.setOpType("Insert");
        orderBO.setPaymentStatus("created");
        Map<String, Object> map = orderVO.getMap();
        SimplePropertyPreFilter filter = new SimplePropertyPreFilter();
        filter.getExcludes().add("data");
        JSONObject obj = JSON.parseObject(JSON.toJSONString(orderBO, filter));
        if(ObjectUtil.isNotNull(map)) obj.putAll(map);
        orderBO.setData(obj.toJSONString());
        //Layer 3
        OrderDO orderDO = new OrderDO();
        BeanUtils.copyProperties(orderBO, orderDO);
        return this.insertIOrder(orderDO);
    }

    @Override
    public Map<String, Object> modifyOrder(OrderModifyVO orderVO) {
        //Layer 1
        OrderDO preDO = this.getOrderById(orderVO.getOId());
        JSONObject preData = JSON.parseObject(preDO.getData());
        SimplePropertyPreFilter filter = new SimplePropertyPreFilter();
        filter.getExcludes().add("map");
        JSONObject VO_data = JSON.parseObject(JSON.toJSONString(orderVO, filter));
        if(ObjectUtil.isNotNull(orderVO.getMap())) VO_data.putAll(orderVO.getMap());     //get whole VO data
        //Layer 2
        JsonUtil.merge(preData, VO_data);
        preData.put("paymentStatus", "completed");
        preData.put("opType", "modify");
        preData.put("odModified", SpookifyTimeStamp.getInstance().getTimeStamp());
        preData.put("productPrice", detailService.getProductPriceWithOid((orderVO.getOId())));
        OrderBO orderBO = JSON.parseObject(preData.toJSONString(), OrderBO.class);
        orderBO.setData(preData.toJSONString());
        //Layer 3
        OrderDO orderDO = new OrderDO();
        BeanUtils.copyProperties(orderBO, orderDO);
        this.updateBalanceOfCustomer(this.findCustomerIdWithOid(orderVO.getOId()), orderVO.getActualAmount());
        return this.updateOrderById(orderDO);
    }

    private String findCustomerIdWithOid(String oid) {
        OrderDO orderDO = orderDao.selectOne(new QueryWrapper<OrderDO>().and((i) -> {
            i.eq("o_id", oid);
        }));
        if(ObjectUtil.isNull(orderDO)) throw new SpookifyBusinessException("no such order!");
        return orderDO.getCustomerId();
    }
}
