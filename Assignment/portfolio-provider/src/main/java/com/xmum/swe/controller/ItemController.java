package com.xmum.swe.controller;

import cn.hutool.core.collection.CollectionUtil;
import cn.hutool.core.util.ObjectUtil;
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.alibaba.fastjson2.JSON;
import com.alibaba.fastjson2.JSONReader;
import com.alibaba.fastjson2.JSONWriter;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.xmum.swe.annotation.SpookifyInfo;
import com.xmum.swe.dao.ItemDao;
import com.xmum.swe.entities.BO.ItemNoMapBO;
import com.xmum.swe.entities.CommonResult;
import com.xmum.swe.entities.DO.ItemDO;
import com.xmum.swe.entities.VO.ItemInsertVO;
import com.xmum.swe.entities.VO.ItemModifyVO;
import com.xmum.swe.enums.IdPos;
import com.xmum.swe.exception.SpookifyBusinessException;
import com.xmum.swe.utils.MapUtil;
import com.xmum.swe.utils.SpookifyTimeStamp;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.util.Assert;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.lang.reflect.Type;
import java.util.*;

@RestController
@RequestMapping("/item")
@Slf4j
public class ItemController {
    @Resource
    private ItemDao itemDao;


    @SpookifyInfo
    @GetMapping("/getItemById/{id}")
    public CommonResult getItem(@PathVariable("id") String id){
        ItemDO item = itemDao.selectById(id);
        Optional.ofNullable(item)
                .orElseThrow(() -> new SpookifyBusinessException("No such item!"));
        return CommonResult.ok(item);
    }

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

    //注意，插入时map中有关键字段会覆盖，里面覆盖外面
    //null值的字段被自动忽略(比如file)
    //map中存了除了空值(比如file)外的所有数据
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
        int num = itemDao.insert(itemDO);
        return num == 0 ? CommonResult.fail("insert failed") : CommonResult.ok(num);
    }

    @SpookifyInfo
    @GetMapping("/modifyItem")
    public CommonResult modifyItem(@RequestBody ItemModifyVO itemVO){
        String id = itemVO.getIId();
        ItemDO preDO = itemDao.selectById(id);
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
        int num = itemDao.updateById(itemDO);
        return num == 0 ? CommonResult.fail("update failed") : CommonResult.ok(num);
    }

    @SpookifyInfo
    @GetMapping("/deleteItem/{id}")
    public CommonResult deleteItem(@PathVariable("id") String id){
        ItemDO preDO = itemDao.selectById(id);
        if(ObjectUtil.isNull(preDO)) return CommonResult.fail("no such id");
        int num = itemDao.deleteById(id);
        return num == 0 ? CommonResult.fail("delete failed") : CommonResult.ok(num);
    }

}
