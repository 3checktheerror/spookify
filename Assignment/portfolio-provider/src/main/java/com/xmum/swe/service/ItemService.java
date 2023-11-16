package com.xmum.swe.service;


import com.xmum.swe.entities.CommonResult;
import com.xmum.swe.entities.DO.ItemDO;
import com.xmum.swe.entities.VO.ItemInsertVO;
import com.xmum.swe.entities.VO.ItemModifyVO;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.Valid;
import java.io.IOException;
import java.util.List;
import java.util.Map;



public interface ItemService {

    ItemDO getItemById(String id);

    List<ItemDO> getAllItems();

    boolean containsItemName(String name);

    Map<String, Object> insertItem(ItemDO itemDO);

    ItemDO getItemWithMaxId();

    Map<String, Object> updateItemById(ItemDO itemDO);

    int deleteItemWithId(String id);

    Map<String, Object> insertItem(ItemInsertVO itemVO, MultipartFile multipartFile);

    Map<String, Object> modifyItem(ItemModifyVO itemVO, MultipartFile multipartFile) throws IOException;
}
