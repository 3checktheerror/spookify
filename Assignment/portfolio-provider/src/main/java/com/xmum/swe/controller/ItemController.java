package com.xmum.swe.controller;

import cn.hutool.core.util.ObjectUtil;
import com.alibaba.fastjson2.JSON;
import com.xmum.swe.annotation.SpookifyInfo;
import com.xmum.swe.entities.BO.ItemNoMapBO;
import com.xmum.swe.entities.CommonResult;
import com.xmum.swe.entities.DO.ItemDO;
import com.xmum.swe.entities.VO.ItemInsertVO;
import com.xmum.swe.entities.VO.ItemModifyVO;
import com.xmum.swe.enums.IdPos;
import com.xmum.swe.service.ItemService;
import com.xmum.swe.utils.MapUtil;
import com.xmum.swe.utils.SpookifyTimeStamp;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import javax.annotation.Resource;
import java.util.*;

@RestController
@RequestMapping("/item")
@Slf4j
public class ItemController {
    @Resource
    private ItemService itemService;

    @SpookifyInfo
    @GetMapping("/getItemById/{id}")
    public CommonResult getItem(@PathVariable("id") String id){
        ItemDO item = itemService.getItemWithId(id);
        return CommonResult.ok(item);
    }

    @SpookifyInfo
    @GetMapping("/getAllItems")
    public CommonResult getAllItems(){
        List<ItemDO> items = itemService.getAllItems();
        return CommonResult.ok(items);
    }


    @SpookifyInfo
    @GetMapping("/containsItemName")
    public boolean containsItemWithName(@RequestParam("ItemName") String name){
        boolean hasItem = itemService.containsItemName(name);
        return hasItem;
    }

    //注意，插入时map中有关键字段会覆盖，里面覆盖外面
    //null值的字段被自动忽略(比如file)
    //map中存了除了空值(比如file)外的所有数据
    @SpookifyInfo
    @GetMapping("/insertItem")
    public CommonResult insertItem(@RequestBody ItemInsertVO itemVO){

        //get new id
        ItemDO maxIdItem = itemService.getItemWithMaxId();
        String itemId = maxIdItem.getIId();
        String oldSubString = itemId.substring(IdPos.ID_ENTITY_NUM.getPos(), IdPos.ID_END.getPos());
        String newSubString = String.valueOf(String.format("%06d", Integer.parseInt(oldSubString) + 1));
        String newItemId = StringUtils.replace(itemId, oldSubString, newSubString);
        log.info("----------ItemId:old-new: " + itemId + "-" + newItemId + "------------------");
        //Eliminate and store map
        Map<String, Object> preMap = itemVO.getMap();
        ItemNoMapBO itemNoMapBO = new ItemNoMapBO();
        BeanUtils.copyProperties(itemVO, itemNoMapBO);  //filter
        //Insert user input fields (exclude data)
        ItemDO itemDO = new ItemDO();
        BeanUtils.copyProperties(itemNoMapBO, itemDO);
        itemDO.setIId(newItemId);
        itemDO.setItCreate(SpookifyTimeStamp.getInstance().getTimeStamp());
        itemDO.setItModified(SpookifyTimeStamp.getInstance().getTimeStamp());
        itemDO.setStatus("Submit");
        itemDO.setOpType("Insert");
        //Insert data (updated fields + user input)
        Map curMap = MapUtil.merge(JSON.parseObject(JSON.toJSONString(itemDO), Map.class), preMap);
        itemDO.setData(JSON.toJSONString(curMap));
        int num = itemService.insertItem(itemDO);
        return num == 0 ? CommonResult.fail("insert failed") : CommonResult.ok(num);
    }

    @SpookifyInfo
    @GetMapping("/modifyItem")
    public CommonResult modifyItem(@RequestBody ItemModifyVO itemVO){
        String id = itemVO.getIId();
        ItemDO preDO = itemService.getItemWithId(id);
        if(ObjectUtil.isNull(preDO)) return CommonResult.fail("no such id");
        Map preMap = JSON.parseObject(preDO.getData(), Map.class);

        ItemNoMapBO itemNoMapBO = new ItemNoMapBO();
        BeanUtils.copyProperties(itemVO, itemNoMapBO);
        Map map1 = JSON.parseObject(JSON.toJSONString(itemNoMapBO), Map.class);
        Map map2 = MapUtil.merge(map1, itemVO.getMap());
        Map map = MapUtil.merge(preMap, map2);
        map.put("itModified", SpookifyTimeStamp.getInstance().getTimeStamp());
        map.put("status", "modified");
        map.put("opType", "modify");
        ItemDO itemDO = JSON.parseObject(JSON.toJSONString(map), ItemDO.class);
        itemDO.setData(JSON.toJSONString(map));
        int num = itemService.updateItemById(itemDO);
        return num == 0 ? CommonResult.fail("update failed") : CommonResult.ok(num);
    }

    @SpookifyInfo
    @GetMapping("/deleteItem/{id}")
    public CommonResult deleteItem(@PathVariable("id") String id){
        ItemDO preDO = itemService.getItemWithId(id);
        if(ObjectUtil.isNull(preDO)) return CommonResult.fail("no such id");
        int num = itemService.deleteItemWithId(id);
        return num == 0 ? CommonResult.fail("delete failed") : CommonResult.ok(num);
    }

}
