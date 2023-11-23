package com.xmum.swe.service.impl;

import cn.hutool.core.util.ObjectUtil;
import com.alibaba.fastjson2.JSON;
import com.alibaba.fastjson2.JSONObject;
import com.alibaba.fastjson2.filter.SimplePropertyPreFilter;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.xmum.swe.dao.CustomerDao;
import com.xmum.swe.entities.BO.CustomerBO;
import com.xmum.swe.entities.BO.CustomerNoMapBO;
import com.xmum.swe.entities.BO.VisitorBO;
import com.xmum.swe.entities.CommonResult;
import com.xmum.swe.entities.DO.CustomerDO;
import com.xmum.swe.entities.DO.ItemDO;
import com.xmum.swe.entities.DO.VisitorDO;
import com.xmum.swe.entities.VO.CustomerInsertVO;
import com.xmum.swe.entities.VO.CustomerModifyVO;
import com.xmum.swe.enums.IdPos;
import com.xmum.swe.exception.SpookifyBusinessException;
import com.xmum.swe.service.CustomerService;
import com.xmum.swe.service.IdService;
import com.xmum.swe.utils.JsonUtil;
import com.xmum.swe.utils.MapUtil;
import com.xmum.swe.utils.SpookifyTimeStamp;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import javax.annotation.Resource;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Service
@Slf4j
public class CustomerServiceImpl implements CustomerService {

    @Resource
    private CustomerDao customerDao;

    @Resource
    private IdService idService;

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
    public Map<String, Object> insertCustomer(CustomerInsertVO cusVO) {
        //Layer 1
        try {
            this.getCustomerName(cusVO.getName());
        }catch (Exception ex) {
            throw new SpookifyBusinessException("customer name cannot be duplicated!");
        }
        String nextId = idService.getNextId(this.getCustomerWithMaxId().getCId());
        //Layer 2
        CustomerBO cusBO = new CustomerBO();
        BeanUtils.copyProperties(cusVO, cusBO, "map");
        Timestamp curTime = SpookifyTimeStamp.getInstance().getTimeStamp();
        cusBO.setCId(nextId);
        cusBO.setCsCreate(curTime);
        cusBO.setCsModified(curTime);
        cusBO.setCsType("Insert");
        Map<String, Object> map = cusVO.getMap();
        SimplePropertyPreFilter filter = new SimplePropertyPreFilter();
        filter.getExcludes().add("data");
        filter.getExcludes().add("file");
        JSONObject obj = JSON.parseObject(JSON.toJSONString(cusBO, filter));
        if(ObjectUtil.isNotNull(map)) obj.putAll(map);
        cusBO.setData(obj.toJSONString());
        //Layer 3
        CustomerDO cusDO = new CustomerDO();
        BeanUtils.copyProperties(cusBO, cusDO);
        return this.insertICustomer(cusDO);
    }

    @Override
    public Map<String, Object> modifyCustomer(CustomerModifyVO cusVO) {
        //Layer 1
        CustomerDO preDO = this.getCustomerById(cusVO.getCId());
        JSONObject preData = JSON.parseObject(preDO.getData());
        SimplePropertyPreFilter filter = new SimplePropertyPreFilter();
        filter.getExcludes().add("map");
        JSONObject VO_data = JSON.parseObject(JSON.toJSONString(cusVO, filter));
        if(ObjectUtil.isNotNull(cusVO.getMap())) VO_data.putAll(cusVO.getMap());     //get whole VO data
        //Layer 2
        JsonUtil.merge(preData, VO_data);
        preData.put("status", "modified");
        preData.put("opType", "modify");
        preData.put("itModified", SpookifyTimeStamp.getInstance().getTimeStamp());
        CustomerBO cusBO = JSON.parseObject(preData.toJSONString(), CustomerBO.class);
        cusBO.setData(preData.toJSONString());
        //Layer 3
        CustomerDO cusDO = new CustomerDO();
        BeanUtils.copyProperties(cusBO, cusDO);
        return this.updateCustomerById(cusDO);
    }
}
