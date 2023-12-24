package com.xmum.swe.service;

import com.xmum.swe.entities.DO.ProductDO;
import com.xmum.swe.entities.VO.OrderInsertVO;
import com.xmum.swe.entities.VO.OrderModifyVO;

import java.util.List;
import java.util.Map;



public interface OrderService {

    ProductDO getCustomerById(String id);

    List<ProductDO> getAllCustomers();

    ProductDO getCustomerWithMaxId();

    Map<String, Object> insertICustomer(ProductDO cusDO);

    Map<String, Object> updateCustomerById(ProductDO cusDO);

    int deleteCustomerWithId(String id);

    void getCustomerName(String name);

    Map<String, Object> insertCustomer(OrderInsertVO cusVO);

    Map<String, Object> modifyCustomer(OrderModifyVO cusVO);
}
