package com.xmum.swe.service;

import com.xmum.swe.entities.DO.OrderDO;
import com.xmum.swe.entities.DO.ProductDO;
import com.xmum.swe.entities.VO.OrderInsertVO;
import com.xmum.swe.entities.VO.OrderModifyVO;

import java.util.List;
import java.util.Map;



public interface OrderService {

    OrderDO getOrderById(String id);

    List<OrderDO> getAllOrders();

    OrderDO getOrderWithMaxId();

    Map<String, Object> insertIOrder(OrderDO orderDO);

    Map<String, Object> updateOrderById(OrderDO orderDO);

    int deleteOrderWithId(String id);

    void updateBalanceOfCustomer(String cusId, float deductNum);

    Map<String, Object> insertOrder(OrderInsertVO orderVO);

    Map<String, Object> modifyOrder(OrderModifyVO orderVO);

}
