package com.xmum.swe.service;


import com.xmum.swe.entities.DO.ItemDO;
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
}
