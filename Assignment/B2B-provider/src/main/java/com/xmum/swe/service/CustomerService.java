package com.xmum.swe.service;

import com.xmum.swe.entities.DO.ProductDO;
import com.xmum.swe.entities.VO.CustomerInsertVO;
import com.xmum.swe.entities.VO.CustomerModifyVO;

import java.util.List;
import java.util.Map;



public interface CustomerService {

    ProductDO getCustomerById(String id);

    List<ProductDO> getAllCustomers();

    ProductDO getCustomerWithMaxId();

    Map<String, Object> insertICustomer(ProductDO cusDO);

    Map<String, Object> updateCustomerById(ProductDO cusDO);

    int deleteCustomerWithId(String id);

    void getCustomerName(String name);

    Map<String, Object> insertCustomer(CustomerInsertVO cusVO);

    Map<String, Object> modifyCustomer(CustomerModifyVO cusVO);
}
