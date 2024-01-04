package com.xmum.swe.service;

import com.xmum.swe.entities.DO.CustomerDO;
import com.xmum.swe.entities.VO.CustomerInsertVO;
import com.xmum.swe.entities.VO.CustomerModifyVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;


public interface CustomerService {

    String login(CustomerInsertVO cusVO, HttpSession session, HttpServletRequest request, HttpServletResponse response);

    CustomerDO getCustomerById(String id);

    CustomerDO getCustomerByName(String name);

    List<CustomerDO> getAllCustomers();

    CustomerDO getCustomerWithMaxId();

    Map<String, Object> insertICustomer(CustomerDO cusDO);

    Map<String, Object> updateCustomerById(CustomerDO cusDO);

    int deleteCustomerWithId(String id);

    void getCustomerName(String name);

    Map<String, Object> insertCustomer(CustomerInsertVO cusVO);

    Map<String, Object> modifyCustomer(CustomerModifyVO cusVO);
}
