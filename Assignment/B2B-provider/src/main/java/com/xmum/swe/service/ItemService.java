package com.xmum.swe.service;


import com.xmum.swe.entities.DO.DetailDO;
import com.xmum.swe.entities.VO.ItemInsertVO;
import com.xmum.swe.entities.VO.ItemModifyVO;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;
import java.util.Map;



public interface ItemService {

    DetailDO getItemById(String id);

    List<DetailDO> getAllItems();

    boolean containsItemName(String name);

    Map<String, Object> insertItem(DetailDO detailDO);

    DetailDO getItemWithMaxId();

    Map<String, Object> updateItemById(DetailDO detailDO);

    int deleteItemWithId(String id);

    Map<String, Object> insertItem(ItemInsertVO itemVO, MultipartFile multipartFile);

    Map<String, Object> modifyItem(ItemModifyVO itemVO, MultipartFile multipartFile) throws IOException, IllegalAccessException;
}
