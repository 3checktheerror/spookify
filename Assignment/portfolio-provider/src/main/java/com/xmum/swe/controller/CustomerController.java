package com.xmum.swe.controller;

import com.alibaba.fastjson2.JSON;
import com.xmum.swe.annotation.SpookifyInfo;
import com.xmum.swe.entities.BO.CustomerBO;
import com.xmum.swe.entities.BO.CustomerNoMapBO;
import com.xmum.swe.entities.CommonResult;
import com.xmum.swe.entities.DO.CustomerDO;
import com.xmum.swe.entities.VO.CustomerInsertVO;
import com.xmum.swe.entities.VO.CustomerModifyVO;
import com.xmum.swe.enums.IdPos;
import com.xmum.swe.service.CustomerService;
import com.xmum.swe.utils.MapUtil;
import com.xmum.swe.utils.SpookifyTimeStamp;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/customer")
@Slf4j
@Api(value = "Customer Query Interface", tags = {"Customer Query Interface"})
public class CustomerController {

    @Resource
    private CustomerService customerService;

    @SpookifyInfo
    @GetMapping("/getCustomerById/{id}")
    public CommonResult getCustomerById(@PathVariable("id") String id){
        CustomerDO customer = customerService.getCustomerById(id);
        return CommonResult.ok(customer);
    }

    @SpookifyInfo
    @GetMapping("/getAllCustomers")
    public CommonResult getAllCustomers(){
        List<CustomerDO> customers = customerService.getAllCustomers();
        return CommonResult.ok(customers);
    }

    @SpookifyInfo
    @PostMapping("/insertCustomer")
    public CommonResult insertItem(@RequestBody CustomerInsertVO cusVO){
        //check if customer name already exists
        customerService.getCustomerName(cusVO.getName());
        //get new id
        CustomerDO maxIdCus = customerService.getCustomerWithMaxId();
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
        Map curMap = MapUtil.merge(JSON.parseObject(JSON.toJSONString(cusBO), Map.class), preMap);
        cusBO.setData(JSON.toJSONString(curMap));
        CustomerDO cusDO = new CustomerDO();
        BeanUtils.copyProperties(cusBO, cusDO);
        Map<String, Object> map = customerService.insertICustomer(cusDO);
        return (int)map.get("num") == 0 ? CommonResult.fail("insert failed") : CommonResult.ok(map);
    }

    @SpookifyInfo
    @GetMapping("/modifyCustomer")
    public CommonResult modifyItem(@RequestBody CustomerModifyVO cusVO){
        String id = cusVO.getCId();
        CustomerDO preDO = customerService.getCustomerById(id);
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
        Map<String, Object> res = customerService.updateCustomerById(cusDO);
        return (int)res.get("num") == 0 ? CommonResult.fail("update failed") : CommonResult.ok(res);
    }

    @SpookifyInfo
    @GetMapping("/deleteCustomer/{id}")
    public CommonResult deleteItem(@PathVariable("id") String id){
        //Just check whether id exists
        customerService.getCustomerById(id);
        int num = customerService.deleteCustomerWithId(id);
        return num == 0 ? CommonResult.ok("nothing to be deleted") : CommonResult.ok(num);
    }

}
