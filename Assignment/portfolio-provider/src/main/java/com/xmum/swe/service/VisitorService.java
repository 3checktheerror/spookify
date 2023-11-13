package com.xmum.swe.service;

import com.xmum.swe.entities.CommonResult;
import com.xmum.swe.entities.DO.ItemDO;
import com.xmum.swe.entities.DO.VisitorDO;
import com.xmum.swe.entities.VO.VisitorInsertVO;
import com.xmum.swe.entities.VO.VisitorModifyVO;
import org.springframework.web.bind.annotation.RequestBody;

import java.util.List;
import java.util.Map;


public interface VisitorService {

    VisitorDO getVisitorById(String id);

    List<VisitorDO> getAllVisitors();

    List<ItemDO> getItemsWithVid(String vid);

    List<String> getIidWithVid(String vid);

    VisitorDO getVisitorWithMaxId();

    Map<String, Object> insertVisitor(VisitorDO visitorDO);

    boolean checkVisitorName(String name);

    Map<String, Object> updateVisitorById(VisitorDO visitorDO);

    Map<String, Object> deleteVisitorWithItems(String id);

    Map<String, Object> insertVisitor(VisitorInsertVO visitorVO);

    Map<String, Object> modifyVisitor(VisitorModifyVO visitorVO);

}
