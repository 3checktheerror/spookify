package com.xmum.swe.service.impl;

import cn.hutool.core.util.ObjectUtil;
import com.alibaba.fastjson2.JSON;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.xmum.swe.dao.CustomerDao;
import com.xmum.swe.entities.BO.CustomerBO;
import com.xmum.swe.entities.BO.CustomerNoMapBO;
import com.xmum.swe.entities.CommonResult;
import com.xmum.swe.entities.DO.CustomerDO;
import com.xmum.swe.entities.DO.ItemDO;
import com.xmum.swe.entities.VO.CustomerInsertVO;
import com.xmum.swe.entities.VO.CustomerModifyVO;
import com.xmum.swe.enums.IdPos;
import com.xmum.swe.exception.SpookifyBusinessException;
import com.xmum.swe.service.CustomerService;
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

@Service
@Slf4j
public class CustomerServiceImpl implements CustomerService {
    @Resource
    private CustomerDao customerDao;

    public CustomerDO getCustomerById(String id) {
        CustomerDO customer = customerDao.selectById(id);
        Optional.ofNullable(customer)
                .orElseThrow(() -> new SpookifyBusinessException("No such customer!"));
        return customer;
    }

    public List<CustomerDO> getAllCustomers(){
        List<CustomerDO> customers = customerDao.selectList(null);
        Optional.ofNullable(customers)
                .orElseThrow(() -> new SpookifyBusinessException("No customer!"));
        return customers;
    }

    public CustomerDO getCustomerWithMaxId() {
        CustomerDO[] arr = (CustomerDO[])customerDao.selectList(new QueryWrapper<CustomerDO>().orderByDesc("c_id"))
                .stream().
                limit(1)
                .toArray(CustomerDO[]::new);
        if(ObjectUtil.isEmpty(arr)) return arr[0];
        else {
            CustomerDO cusDO = new CustomerDO();
            cusDO.setCId("SPCT000001");
            return cusDO;
        }
    }
    public Map<String, Object> insertICustomer(CustomerDO cusDO){
        int num = customerDao.insert(cusDO);
        Map<String, Object> map = new HashMap<>();
        map.put("num", num);
        map.put("id", cusDO.getCId());
        return map;

    }

    public Map<String, Object> updateCustomerById(CustomerDO cusDO) {
        int num = customerDao.updateById(cusDO);
        Map<String, Object> map = new HashMap<>();
        map.put("num", num);
        map.put("id", cusDO.getCId());
        return map;
    }

    public int deleteCustomerWithId(String id) {
        int num = customerDao.deleteById(id);
        return num;
    }

    public void getCustomerName(String name) {
        Map<String, Object> map = new HashMap<>();
        map.put("name", name);
        List<CustomerDO> res = customerDao.selectByMap(map);
        if(!res.isEmpty()) throw new SpookifyBusinessException("customer name cannot be duplicated!");
    }

    @Override
    public Map<String, Object> insertItem(CustomerInsertVO cusVO) {
        //check if customer name already exists
        this.getCustomerName(cusVO.getName());
        //get new id
        CustomerDO maxIdCus = this.getCustomerWithMaxId();
        String cusId = maxIdCus.getCId();
        String oldSubString = cusId.substring(IdPos.ID_ENTITY_NUM.getPos(), IdPos.ID_END.getPos());
        String newSubString = String.valueOf(String.format("%06d", Integer.parseInt(oldSubString) + 1));
        String newCusId = StringUtils.replace(cusId, oldSubString, newSubString);
        log.info("----------ItemId:old-new: " + cusId + "-" + newCusId + "------------------");
        //Eliminate and store map
        Map<String, Object> preMap = cusVO.getMap();
        CustomerNoMapBO cusNoMapBO = new CustomerNoMapBO();
        BeanUtils.copyProperties(cusVO, cusNoMapBO);  //filter
        //Insert user input fields (exclude data)
        CustomerBO cusBO = new CustomerBO();
        BeanUtils.copyProperties(cusNoMapBO, cusBO);
        cusBO.setCId(newCusId);
        cusBO.setCsCreate(SpookifyTimeStamp.getInstance().getTimeStamp());
        cusBO.setCsModified(SpookifyTimeStamp.getInstance().getTimeStamp());
        cusBO.setCsType(cusVO.getCsType());
        //Insert data (updated fields + user input)
        if(ObjectUtil.isNotNull(preMap)){
            Map curMap = MapUtil.merge(JSON.parseObject(JSON.toJSONString(cusBO), Map.class), preMap);
            cusBO.setData(JSON.toJSONString(curMap));
        } else {
            cusBO.setData(JSON.toJSONString(cusBO));
        }
        CustomerDO cusDO = new CustomerDO();
        BeanUtils.copyProperties(cusBO, cusDO);
        Map<String, Object> map = this.insertICustomer(cusDO);
        return map;
    }

    @Override
    public Map<String, Object> modifyItem(CustomerModifyVO cusVO) {
        String id = cusVO.getCId();
        CustomerDO preDO = this.getCustomerById(id);
        Map preMap = JSON.parseObject(preDO.getData(), Map.class);
        CustomerNoMapBO cusNoMapBO = new CustomerNoMapBO();
        BeanUtils.copyProperties(cusVO, cusNoMapBO);
        Map map1 = JSON.parseObject(JSON.toJSONString(cusNoMapBO), Map.class);
        Map map2 = MapUtil.merge(map1, cusVO.getMap());
        Map map = MapUtil.merge(preMap, map2);
        map.put("csModified", SpookifyTimeStamp.getInstance().getTimeStamp());
        CustomerBO cusBO = JSON.parseObject(JSON.toJSONString(map), CustomerBO.class);
        cusBO.setData(JSON.toJSONString(map));
        CustomerDO cusDO = new CustomerDO();
        BeanUtils.copyProperties(cusBO, cusDO);
        Map<String, Object> res = this.updateCustomerById(cusDO);
        return res;
    }
}
