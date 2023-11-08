package com.xmum.swe.service;

import cn.hutool.core.util.ObjectUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.xmum.swe.dao.CustomerDao;
import com.xmum.swe.entities.DO.CustomerDO;
import com.xmum.swe.exception.SpookifyBusinessException;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Service
public class CustomerService {
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
        return (CustomerDO) customerDao.selectList(new QueryWrapper<CustomerDO>().orderByDesc("c_id"))
                .stream().
                limit(1)
                .toArray()[0];
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
        if(ObjectUtil.isNotNull(res)) throw new SpookifyBusinessException("customer name cannot be duplicated!");
    }
}
