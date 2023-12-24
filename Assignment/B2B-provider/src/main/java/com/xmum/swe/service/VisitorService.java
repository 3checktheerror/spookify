package com.xmum.swe.service;

import com.xmum.swe.entities.DO.DetailDO;
import com.xmum.swe.entities.DO.OrderDO;
import com.xmum.swe.entities.VO.VisitorInsertVO;
import com.xmum.swe.entities.VO.VisitorModifyVO;

import java.util.List;
import java.util.Map;


public interface VisitorService {

    OrderDO getVisitorById(String id);

    List<OrderDO> getAllVisitors();

    List<DetailDO> getItemsWithVid(String vid);

    List<String> getIidWithVid(String vid);

    OrderDO getVisitorWithMaxId();

    Map<String, Object> insertVisitor(OrderDO orderDO);

    boolean checkVisitorName(String name);

    Map<String, Object> updateVisitorById(OrderDO orderDO);

    Map<String, Object> deleteVisitorWithItems(String id);

    Map<String, Object> insertVisitor(VisitorInsertVO visitorVO);

    Map<String, Object> modifyVisitor(VisitorModifyVO visitorVO);

}
