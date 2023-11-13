package com.xmum.swe.service;

import com.xmum.swe.entities.DO.CustomerDO;
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
}
