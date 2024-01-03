package com.xmum.swe.service.impl;

import cn.hutool.core.util.ObjectUtil;
import com.alibaba.fastjson2.JSON;
import com.alibaba.fastjson2.JSONObject;
import com.alibaba.fastjson2.filter.SimplePropertyPreFilter;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.xmum.swe.dao.DetailDao;
import com.xmum.swe.entities.BO.DetailBO;
import com.xmum.swe.entities.DO.DetailDO;
import com.xmum.swe.entities.DO.OrderDO;
import com.xmum.swe.entities.VO.DetailInsertVO;
import com.xmum.swe.entities.VO.DetailModifyVO;
import com.xmum.swe.exception.SpookifyBusinessException;
import com.xmum.swe.service.IdService;
import com.xmum.swe.service.DetailService;
import com.xmum.swe.service.OrderService;
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
public class DetailServiceImpl implements DetailService {
    @Resource
    private DetailDao detailDao;

    @Resource
    private OrderService orderService;

    @Resource
    private IdService idService;

//    @Resource
//    private RedisTemplate redisTemplate;



    public DetailDO getDetailById(String id) {
//        if(redisTemplate.hasKey(id)) {
//            return (DetailDO)redisTemplate.opsForValue().get(id);
//        }
        DetailDO detail = detailDao.selectById(id);
        Optional.ofNullable(detail)
                .orElseThrow(() -> new SpookifyBusinessException("No such detail!"));
        return detail;
    }

    public List<DetailDO> getAllDetails() {
        List<DetailDO> details = detailDao.selectList(null);
        Optional.ofNullable(details)
                .orElseThrow(() -> new SpookifyBusinessException("Detail list is empty!"));
//        details.stream().forEach(detail -> {
//            redisTemplate.opsForValue().set(detail.getDId(), detail);
//        });
        return details;
    }

    public Map<String, Object> insertDetail(DetailDO detailDO) {
        int num = detailDao.insert(detailDO);
        Map<String, Object> map = new HashMap<>();
        map.put("num", num);
        map.put("id", detailDO.getDId());
        return map;
    }

    public DetailDO getDetailWithMaxId(){
        DetailDO[] arr = (DetailDO[])detailDao.selectList(new QueryWrapper<DetailDO>().orderByDesc("d_id"))
                .stream().
                limit(1)
                .toArray(DetailDO[]::new);
        if(ObjectUtil.isNotEmpty(arr)) return arr[0];
        else {
            DetailDO detailDO = new DetailDO();
            detailDO.setDId("SPDT000001");
            return detailDO;
        }
    }

    public Map<String, Object> updateDetailById(DetailDO detailDO) {
        int num = detailDao.updateById(detailDO);
        Map<String, Object> map = new HashMap<>();
        map.put("num", num);
        map.put("id", detailDO.getDId());
        return map;
    }

    private int getNumOfDetailsWithOid(String oid){
        return detailDao.selectList(new QueryWrapper<DetailDO>().eq("o_id_fk", oid)).size();
    }

    public int deleteDetailWithId(String id) {
        if(this.getNumOfDetailsWithOid(this.getOidWithDid(id)) == 1) {
            DetailDO detailDO = this.getDetailById(id);
            detailDao.deleteById(id);
            orderService.deleteOrderWithId(detailDO.getOIdFk());
            return 1;
        }
        String oid = getOidWithDid(id);
        int num = detailDao.deleteById(id);
        Map<String, Object> map = this.updateProductPrice(oid);
        if((int)map.get("num") == 0) {
            log.error("Update product price failed!");
            throw new SpookifyBusinessException("Update product price failed!");
        }
        return num;
    }

    @Override
    public Map<String, Object> insertDetail(DetailInsertVO detailVO) {
        //Layer 1
        try {
            orderService.getOrderById(detailVO.getOIdFk());    //check if the foreign key exists
        } catch (SpookifyBusinessException sp) {
            throw new SpookifyBusinessException("Foreign key: oIdFk doesn't exist");
        }
        String nextId = idService.getNextId(this.getDetailWithMaxId().getDId());
        //Layer 2
        DetailBO detailBO = new DetailBO();
        BeanUtils.copyProperties(detailVO, detailBO, "map");
        Timestamp curTime = SpookifyTimeStamp.getInstance().getTimeStamp();
        detailBO.setDId(nextId);
        detailBO.setDtCreate(curTime);
        detailBO.setDtModified(curTime);
        detailBO.setOpType("Insert");
        Map<String, Object> map = detailVO.getMap();
        SimplePropertyPreFilter filter = new SimplePropertyPreFilter();
        filter.getExcludes().add("data");
        JSONObject obj = JSON.parseObject(JSON.toJSONString(detailBO, filter));
        if(ObjectUtil.isNotNull(map)) obj.putAll(map);
        detailBO.setData(obj.toJSONString());
        //Layer 3
        DetailDO detailDO = new DetailDO();
        BeanUtils.copyProperties(detailBO, detailDO);
        DetailModifyVO detail = new DetailModifyVO();
        detail.setDId(detailDO.getDId());
        this.insertDetail(detailDO);
        return this.updateProductPrice(detail);
    }


    private Map<String, Object> modifyDetail(DetailModifyVO detailVO) {
        //Layer 1
        DetailDO preDO = this.getDetailById(detailVO.getDId());
        JSONObject preData = JSON.parseObject(preDO.getData());
        SimplePropertyPreFilter filter = new SimplePropertyPreFilter();
        filter.getExcludes().add("map");
        JSONObject VO_data = JSON.parseObject(JSON.toJSONString(detailVO, filter));
        if(ObjectUtil.isNotNull(detailVO.getMap())) VO_data.putAll(detailVO.getMap());     //get whole VO data
        //Layer 2
        JsonUtil.merge(preData, VO_data);
        preData.put("opType", "modify");
        preData.put("quantity", detailVO.getQuantity());
        preData.put("subtotal", this.getSubtotalByDid(detailVO.getDId(), detailVO.getQuantity()));
        preData.put("dtModified", SpookifyTimeStamp.getInstance().getTimeStamp());
        DetailBO detailBO = JSON.parseObject(preData.toJSONString(), DetailBO.class);
        detailBO.setData(preData.toJSONString());
        //Layer 3
        DetailDO detailDO = new DetailDO();
        BeanUtils.copyProperties(detailBO, detailDO);
        return this.updateDetailById(detailDO);
    }

    @Override
    public Map<String, Object> modifyMultiQuantities(Map<String, Object> map) {
        DetailModifyVO detailVO = new DetailModifyVO();
        for(Map.Entry<String, Object> entry : map.entrySet()) {
            detailVO.setDId(entry.getKey());
            detailVO.setQuantity((Integer)entry.getValue());
            //先入库
            this.modifyDetail(detailVO);
        }
        //更新order表
        Map<String, Object> res = this.updateProductPrice(detailVO);
        return res;
    }

    private Map<String, Object> updateProductPrice(DetailModifyVO detailVO) {
        OrderDO orderDO = orderService.getOrderById(this.getOidWithDid(detailVO.getDId()));
        return updateProductPriceWithOrderDO(orderDO);
    }

    private Map<String, Object> updateProductPriceWithOrderDO(OrderDO orderDO) {
        orderDO.setProductPrice(this.getProductPriceWithOid(orderDO.getOId()));
        orderDO.setOdModified(SpookifyTimeStamp.getInstance().getTimeStamp());
        orderDO.setOpType("modify");
        orderDO.setPaymentStatus("pending");
        JSONObject jsonObject = JSONObject.parseObject(orderDO.getData());
        jsonObject.put("odModified", SpookifyTimeStamp.getInstance().getTimeStamp());
        orderDO.setData(jsonObject.toString());
        Map<String, Object> res = orderService.updateOrderById(orderDO);
        res.put("status", "success");
        return res;
    }

    private Map<String, Object> updateProductPrice(String oid) {
        OrderDO orderDO = orderService.getOrderById(oid);
        return updateProductPriceWithOrderDO(orderDO);
    }

    public float getProductPriceWithOid(String oid) {
        if(!oid.startsWith("SPOD") || oid.length() != 10) throw new SpookifyBusinessException("Invalid order id");
        List<DetailDO> detailDOList = detailDao.selectList(new QueryWrapper<DetailDO>().eq("o_id_fk", oid));
        float productPrice = detailDOList.stream().
                map(detailDO -> this.getSubtotalByDid(detailDO.getDId())).
                reduce(0f, Float::sum);
        return productPrice;
    }

    private String getOidWithDid(String did) {
        DetailDO detailDO = this.getDetailById(did);
        return detailDO.getOIdFk();
    }

    private float getSubtotalByDid(String did) {
        DetailDO detailDO = this.getDetailById(did);
        float quantity = (float)detailDO.getQuantity();
        float unitPrice = detailDO.getUnitPrice();
        return quantity * unitPrice;
    }

    private float getSubtotalByDid(String did, float newQuantity) {
        DetailDO detailDO = this.getDetailById(did);
        float unitPrice = detailDO.getUnitPrice();
        return newQuantity * unitPrice;
    }

    public void deleteDetailWithOid(String oid) {
        List<DetailDO> detailDOList = detailDao.selectList(new QueryWrapper<DetailDO>().eq("o_id_fk", oid));
        detailDOList.forEach(detailDO -> this.deleteDetailWithId(detailDO.getDId()));
    }
}
