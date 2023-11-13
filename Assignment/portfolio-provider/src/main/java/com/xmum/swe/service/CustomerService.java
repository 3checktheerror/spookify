package com.xmum.swe.service;

import com.xmum.swe.entities.CommonResult;
import com.xmum.swe.entities.DO.CustomerDO;
import com.xmum.swe.entities.VO.CustomerInsertVO;
import com.xmum.swe.entities.VO.CustomerModifyVO;
import org.springframework.web.bind.annotation.RequestBody;

import java.util.List;
import java.util.Map;



public interface CustomerService {

    CustomerDO getCustomerById(String id);

    List<CustomerDO> getAllCustomers();

    CustomerDO getCustomerWithMaxId();

    Map<String, Object> insertICustomer(CustomerDO cusDO);

    Map<String, Object> updateCustomerById(CustomerDO cusDO);

    int deleteCustomerWithId(String id);

    void getCustomerName(String name);

    Map<String, Object> insertItem(CustomerInsertVO cusVO);

    Map<String, Object> modifyItem(CustomerModifyVO cusVO);
}
