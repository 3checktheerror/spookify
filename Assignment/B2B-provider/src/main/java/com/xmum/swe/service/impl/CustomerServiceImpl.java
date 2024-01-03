package com.xmum.swe.service.impl;

import cn.hutool.core.util.ObjectUtil;
import cn.hutool.system.UserInfo;
import com.alibaba.druid.util.StringUtils;
import com.alibaba.fastjson2.JSON;
import com.alibaba.fastjson2.JSONObject;
import com.alibaba.fastjson2.filter.SimplePropertyPreFilter;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.xmum.swe.dao.CustomerDao;
import com.xmum.swe.entities.BO.CustomerBO;
import com.xmum.swe.entities.DO.CustomerDO;
import com.xmum.swe.entities.VO.CustomerInsertVO;
import com.xmum.swe.entities.VO.CustomerModifyVO;
import com.xmum.swe.exception.SpookifyBusinessException;
import com.xmum.swe.service.CustomerService;
import com.xmum.swe.service.IdService;
import com.xmum.swe.utils.JsonUtil;
import com.xmum.swe.utils.SpookifyTimeStamp;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

import static com.alibaba.fastjson2.schema.JSONSchema.Type.Const;

@Service
@Slf4j
public class CustomerServiceImpl implements CustomerService {

    @Resource
    private CustomerDao customerDao;

    @Resource
    private IdService idService;

//    @Resource
//    private RedisTemplate redisTemplate;

    @Override
    public String login(CustomerInsertVO cusVO, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
        cusVO.setSessionId(session.getId());
        this.insertCustomer(cusVO);
        return this.doLogin(cusVO.getName().trim(), cusVO.getPassword().trim(), session, request, response).toJSONString();
    }

    public CustomerDO getCustomerById(String id) {
//        if(redisTemplate.hasKey(id)) {
//            return (CustomerDO)redisTemplate.opsForValue().get(id);
//        }
        CustomerDO customer = customerDao.selectById(id);
        Optional.ofNullable(customer)
                .orElseThrow(() -> new SpookifyBusinessException("No such customer!"));
        return customer;
    }

    @Override
    public CustomerDO getCustomerByName(String name) {
        CustomerDO customer = customerDao.selectOne(new QueryWrapper<CustomerDO>().eq("name", name));
        Optional.ofNullable(customer)
                .orElseThrow(() -> new SpookifyBusinessException("No such customer!"));
        return customer;
    }

    public List<CustomerDO> getAllCustomers(){
        List<CustomerDO> customers = customerDao.selectList(null);
        Optional.ofNullable(customers)
                .orElseThrow(() -> new SpookifyBusinessException("No customer!"));
//        customers.stream().forEach(customer -> {
//            redisTemplate.opsForValue().set(customer.getCId(), customer);
//        });
        return customers;
    }

    public CustomerDO getCustomerWithMaxId() {
        CustomerDO[] arr = (CustomerDO[])customerDao.selectList(new QueryWrapper<CustomerDO>().orderByDesc("c_id"))
                .stream().
                limit(1)
                .toArray(CustomerDO[]::new);
        if(!ObjectUtil.isEmpty(arr)) return arr[0];
        else {
            CustomerDO cusDO = new CustomerDO();
            cusDO.setCId("SPCS000000");
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
             if(!customerDao.selectList(null).isEmpty()) this.getCustomerName(cusVO.getName());
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

    private JSONObject doLogin(String username, String password, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
        JSONObject res = new JSONObject();
        res.put("code", 0);
        if (StringUtils.isEmpty(username) || StringUtils.isEmpty(password)) {
            res.put("msg", "-1");
            return res;
        }
        List<String> passwordList = this.getAllCustomers().stream().map(CustomerDO::getPassword).collect(Collectors.toList());
        if (!passwordList.contains(password)) {
            res.put("msg", "-2");
            return res;
        }
        session.setAttribute("spookify-b2b-customer", this.getCustomerByName(username));
        Cookie cookie_username = new Cookie("cookie_username", username);
        cookie_username.setMaxAge(30 * 24 * 60 * 60);
        cookie_username.setPath(request.getContextPath());
        response.addCookie(cookie_username);
        res.put("msg", "0");
        return res;
    }
}
