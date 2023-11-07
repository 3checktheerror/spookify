package com.xmum.swe.controller;

import cn.hutool.core.date.DateUtil;
import cn.hutool.core.date.LocalDateTimeUtil;
import com.alibaba.fastjson2.JSON;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.xmum.swe.annotation.SpookifyInfo;
import com.xmum.swe.dao.ItemDao;
import com.xmum.swe.entities.BO.ItemNoMapBO;
import com.xmum.swe.entities.CommonResult;
import com.xmum.swe.entities.DO.ItemDO;
import com.xmum.swe.entities.VO.ItemInsertVO;
import com.xmum.swe.enums.IdPos;
import com.xmum.swe.exception.SpookifyBusinessException;
import com.xmum.swe.utils.SpookifyTimeStamp;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.sql.Timestamp;
import java.util.*;

@RestController
@RequestMapping("/item")
@Slf4j
public class ItemController {
    @Resource
    private ItemDao itemDao;


    @SpookifyInfo
    @GetMapping("/getAllItems")
    public CommonResult getAllItems(){
        List<ItemDO> items = itemDao.selectList(null);
        Optional.ofNullable(items)
                .orElseThrow(() -> new SpookifyBusinessException("items list is empty!"));
        return CommonResult.ok(items);
    }

    @SpookifyInfo
    @GetMapping("/containsItemName")
    public boolean containsItemWithName(@RequestParam("ItemName") String name){
        QueryWrapper<ItemDO> wrapper = new QueryWrapper<>();
        ItemDO[] items = itemDao
                .selectList(wrapper.select("name")
                                    .and(i -> i.eq("name", name)))
                .toArray(new ItemDO[0]);
        return items.length > 0;
    }


    @SpookifyInfo
    @GetMapping("/insertItem")
    public CommonResult insertItem(@RequestBody ItemInsertVO itemVO){
        //get new id
        ItemDO maxIdItem = (ItemDO)itemDao.selectList(new QueryWrapper<ItemDO>().orderByDesc("i_id"))
                                            .stream().
                                            limit(1)
                                            .toArray()[0];
        String itemId = maxIdItem.getIId();
        String oldSubString = itemId.substring(IdPos.ID_ENTITY_NUM.getPos(), IdPos.ID_END.getPos());
        String newSubString = String.valueOf(String.format("%06d", Integer.parseInt(oldSubString) + 1));
        String newItemId = StringUtils.replace(itemId, oldSubString, newSubString);
        log.info("----------ItemId:old-new: " + itemId + "-" + newItemId + "------------------");
        //Eliminate and store map
        Map<String, Object> map = itemVO.getMap();
        ItemNoMapBO itemNoMapBO = new ItemNoMapBO();
        BeanUtils.copyProperties(itemVO, itemNoMapBO);
        //Insert data other than map
        ItemDO itemDO = new ItemDO();
        BeanUtils.copyProperties(itemNoMapBO, itemDO);
        itemDO.setIId(newItemId);
        itemDO.setItCreate(SpookifyTimeStamp.getInstance().getTimeStamp());
        itemDO.setItModified(SpookifyTimeStamp.getInstance().getTimeStamp());
        itemDO.setStatus("Submit");
        itemDO.setOpType("Insert");
        //get attributes other than data (before setData)
        Map<String, Object> mapAll = JSON.parseObject(JSON.toJSONString(itemDO), Map.class);
        mapAll.putAll(map);
        itemDO.setData(JSON.toJSONString(mapAll));
        int num = itemDao.insert(itemDO);
        return num == 0 ? CommonResult.fail("insert failed") : CommonResult.ok(num);
    }

    @SpookifyInfo
    @GetMapping("/modifyItem")
    public CommonResult modifyItem(@RequestBody ItemInsertVO itemVO){
        return null;
    }
}
