package com.xmum.swe.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.xmum.swe.dao.ItemDao;
import com.xmum.swe.entities.BO.ItemBO;
import com.xmum.swe.entities.DO.ItemDO;
import com.xmum.swe.exception.SpookifyBusinessException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import javax.sql.rowset.serial.SerialException;
import java.sql.Blob;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Service
@Slf4j
public class ItemService {
    @Resource
    private ItemDao itemDao;

    public ItemDO getItemById(String id) {
        ItemDO item = itemDao.selectById(id);
        Optional.ofNullable(item)
                .orElseThrow(() -> new SpookifyBusinessException("No such item!"));
        return item;
    }

    public List<ItemDO> getAllItems() {
        List<ItemDO> items = itemDao.selectList(null);
        Optional.ofNullable(items)
                .orElseThrow(() -> new SpookifyBusinessException("items list is empty!"));
        return items;
    }

    public boolean containsItemName(String name) {
        QueryWrapper<ItemDO> wrapper = new QueryWrapper<>();
        ItemDO[] items = itemDao
                .selectList(wrapper.select("name")
                        .and(i -> i.eq("name", name)))
                .toArray(new ItemDO[0]);
        return items.length > 0;
    }

    public Map<String, Object> insertItem(ItemDO itemDO) {
        int num = itemDao.insert(itemDO);
        Map<String, Object> map = new HashMap<>();
        map.put("num", num);
        map.put("id", itemDO.getIId());
        return map;
    }

    public ItemDO getItemWithMaxId(){
        return (ItemDO)itemDao.selectList(new QueryWrapper<ItemDO>().orderByDesc("i_id"))
                .stream().
                limit(1)
                .toArray()[0];
    }

    public Map<String, Object> updateItemById(ItemDO itemDO) {
        int num = itemDao.updateById(itemDO);
        Map<String, Object> map = new HashMap<>();
        map.put("num", num);
        map.put("id", itemDO.getIId());
        return map;
    }

    public int deleteItemWithId(String id) {
        int num = itemDao.deleteById(id);
        return num;
    }
}
