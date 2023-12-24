package com.xmum.swe.service;

import com.xmum.swe.entities.DO.DetailDO;
import com.xmum.swe.entities.DO.OrderDO;
import com.xmum.swe.entities.VO.ProductInsertVO;
import com.xmum.swe.entities.VO.ProductModifyVO;

import java.util.List;
import java.util.Map;


public interface ProductService {

    OrderDO getVisitorById(String id);

    List<OrderDO> getAllVisitors();

    List<DetailDO> getItemsWithVid(String vid);

    List<String> getIidWithVid(String vid);

    OrderDO getVisitorWithMaxId();

    Map<String, Object> insertVisitor(OrderDO orderDO);

    boolean checkVisitorName(String name);

    Map<String, Object> updateVisitorById(OrderDO orderDO);

    Map<String, Object> deleteVisitorWithItems(String id);

    Map<String, Object> insertVisitor(ProductInsertVO visitorVO);

    Map<String, Object> modifyVisitor(ProductModifyVO visitorVO);

}
