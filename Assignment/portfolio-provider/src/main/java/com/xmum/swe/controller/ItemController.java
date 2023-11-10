package com.xmum.swe.controller;

import cn.hutool.core.util.ObjectUtil;
import com.alibaba.fastjson2.JSON;
import com.xmum.swe.annotation.SpookifyInfo;
import com.xmum.swe.entities.BO.ItemBO;
import com.xmum.swe.entities.BO.ItemNoMapBO;
import com.xmum.swe.entities.CommonResult;
import com.xmum.swe.entities.DO.ItemDO;
import com.xmum.swe.entities.VO.ItemInsertVO;
import com.xmum.swe.entities.VO.ItemModifyVO;
import com.xmum.swe.enums.IdPos;
import com.xmum.swe.exception.SpookifyBusinessException;
import com.xmum.swe.service.ItemService;
import com.xmum.swe.service.VisitorService;
import com.xmum.swe.utils.MapUtil;
import com.xmum.swe.utils.SpookifyTimeStamp;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.util.StringUtils;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import javax.annotation.Resource;
import javax.validation.Valid;

import java.io.IOException;
import java.util.*;

@RestController
@RequestMapping("/item")
@Validated
@Slf4j
@Api(value = "Item Query Interface", tags = {"Item Query Interface"})
public class ItemController {

    @Resource
    private ItemService itemService;

    @Resource
    private VisitorService visitorService;

    @SpookifyInfo
    @GetMapping("/getItemById/{id}")
    public CommonResult getItem(@PathVariable("id") String id){
        ItemDO item = itemService.getItemById(id);
        return CommonResult.ok(item);
    }

    @SpookifyInfo
    @GetMapping("/getAllItems")
    public CommonResult getAllItems(){
        List<ItemDO> items = itemService.getAllItems();
        return CommonResult.ok(items);
    }

    @ApiOperation("deprecated")
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
    @PostMapping("/insertItem")
    public CommonResult insertItem(@RequestBody @Valid ItemInsertVO itemVO){
        //check if the foreign key exists
        visitorService.getVisitorById(itemVO.getVIdFk());
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
        ItemBO itemBO = new ItemBO();
        BeanUtils.copyProperties(itemNoMapBO, itemBO);
        itemBO.setIId(newItemId);
        itemBO.setItCreate(SpookifyTimeStamp.getInstance().getTimeStamp());
        itemBO.setItModified(SpookifyTimeStamp.getInstance().getTimeStamp());
        itemBO.setStatus("Submit");
        itemBO.setOpType("Insert");
        //Insert data (updated fields + user input)
        Map curMap = MapUtil.merge(JSON.parseObject(JSON.toJSONString(itemBO), Map.class), preMap);
        itemBO.setData(JSON.toJSONString(curMap));
        //set file data
        if(ObjectUtil.isNotNull(itemVO.getFile())){
            try {
                itemBO.setFile(itemVO.getFile().getBytes());
            } catch (IOException e) {
                throw new SpookifyBusinessException("itemBo setfile error");
            }
        }
        ItemDO itemDO = new ItemDO();
        BeanUtils.copyProperties(itemBO, itemDO);
        Map<String, Object> map = itemService.insertItem(itemDO);
        return (int)map.get("num") == 0 ? CommonResult.fail("insert failed") : CommonResult.ok(map);
    }

    @SpookifyInfo
    @PostMapping("/modifyItem")
    public CommonResult modifyItem(@RequestBody ItemModifyVO itemVO){
        String id = itemVO.getIId();
        ItemDO preDO = itemService.getItemById(id);
        Map preMap = JSON.parseObject(preDO.getData(), Map.class);
        ItemNoMapBO itemNoMapBO = new ItemNoMapBO();
        BeanUtils.copyProperties(itemVO, itemNoMapBO);
        Map map1 = JSON.parseObject(JSON.toJSONString(itemNoMapBO), Map.class);
        Map map2 = MapUtil.merge(map1, itemVO.getMap());
        Map map = MapUtil.merge(preMap, map2);
        //map中并不需要放全部字段，只要放状态相关状态即可，也即状态还是需要手动更新
        map.put("itModified", SpookifyTimeStamp.getInstance().getTimeStamp());
        map.put("status", "modified");
        map.put("opType", "modify");
        ItemBO itemBO = JSON.parseObject(JSON.toJSONString(map), ItemBO.class);
        itemBO.setData(JSON.toJSONString(map));
        ItemDO itemDO = new ItemDO();
        BeanUtils.copyProperties(itemBO, itemDO);
        Map<String, Object> res = itemService.updateItemById(itemDO);
        return (int)res.get("num") == 0 ? CommonResult.fail("update failed") : CommonResult.ok(res);
    }

    @SpookifyInfo
    @GetMapping("/deleteItem/{id}")
    public CommonResult deleteItem(@PathVariable("id") String id){
        //Just check whether id exists
        itemService.getItemById(id);
        int num = itemService.deleteItemWithId(id);
        return num == 0 ? CommonResult.ok("nothing to be deleted") : CommonResult.ok(num);
    }

}
