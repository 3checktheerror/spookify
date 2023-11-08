package com.xmum.swe.controller;

import cn.hutool.core.util.ObjectUtil;
import com.alibaba.fastjson2.JSON;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.xmum.swe.annotation.SpookifyInfo;
import com.xmum.swe.dao.VisitorDao;
import com.xmum.swe.entities.BO.ItemBO;
import com.xmum.swe.entities.BO.ItemNoMapBO;
import com.xmum.swe.entities.BO.VisitorBO;
import com.xmum.swe.entities.BO.VisitorNoMapBO;
import com.xmum.swe.entities.CommonResult;
import com.xmum.swe.entities.DO.ItemDO;
import com.xmum.swe.entities.DO.VisitorDO;
import com.xmum.swe.entities.VO.ItemModifyVO;
import com.xmum.swe.entities.VO.VisitorInsertVO;
import com.xmum.swe.entities.VO.VisitorModifyVO;
import com.xmum.swe.enums.IdPos;
import com.xmum.swe.exception.SpookifyBusinessException;
import com.xmum.swe.service.ItemService;
import com.xmum.swe.service.VisitorService;
import com.xmum.swe.utils.MapUtil;
import com.xmum.swe.utils.SpookifyTimeStamp;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.time.temporal.ValueRange;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/visitor")
@Slf4j
public class VisitorController {

    @Resource
    private ItemService itemService;

    @Resource
    private VisitorService visitorService;

    @SpookifyInfo
    @GetMapping("/getVisitorById/{id}")
    public CommonResult getVisitor(@PathVariable("id") String id){
        VisitorDO visitor = visitorService.getVisitorById(id);
        return CommonResult.ok(visitor);
    }

    @SpookifyInfo
    @GetMapping("/getAllVisitors")
    public CommonResult getAllVisitors(){
        List<VisitorDO> visitors = visitorService.getAllVisitors();
        return CommonResult.ok(visitors);
    }

    @SpookifyInfo
    @GetMapping("/getitems/{vid}")
    public CommonResult getItems(@PathVariable("vid") String vid){
        List<ItemDO> items = visitorService.getItemsWithVid(vid);
        return CommonResult.ok(items);
    }

    @SpookifyInfo
    @GetMapping("/getIids/{vid}")
    public CommonResult getIids(@PathVariable("vid") String vid){
        List<String> ids = visitorService.getIidWithVid(vid);
        return CommonResult.ok(ids);
    }

    @SpookifyInfo
    @GetMapping("/insertVisitor")
    public CommonResult insertVisitor(@RequestBody VisitorInsertVO visitorVO){
        //first check if vistor's name exists
        if(visitorService.checkVisitorName(visitorVO.getName())) return CommonResult.fail("visitor name exists!");
        //get new id
        VisitorDO maxIdVt = visitorService.getVisitorWithMaxId();
        String visitorId = maxIdVt.getVId();
        String oldSubString = visitorId.substring(IdPos.ID_ENTITY_NUM.getPos(), IdPos.ID_END.getPos());
        String newSubString = String.valueOf(String.format("%06d", Integer.parseInt(oldSubString) + 1));
        String newVisitorId = StringUtils.replace(visitorId, oldSubString, newSubString);
        log.info("----------VisitorId:old-new: " + visitorId + "-" + newVisitorId + "------------------");
        //Eliminate and store map
        Map<String, Object> preMap = visitorVO.getMap();
        VisitorNoMapBO visitorNoMapBO = new VisitorNoMapBO();
        BeanUtils.copyProperties(visitorVO, visitorNoMapBO);  //filter
        //Insert user input fields (exclude data)
        VisitorBO visitorBO = new VisitorBO();
        BeanUtils.copyProperties(visitorNoMapBO, visitorBO);
        visitorBO.setVId(newVisitorId);
        visitorBO.setVtCreate(SpookifyTimeStamp.getInstance().getTimeStamp());
        visitorBO.setVtModified(SpookifyTimeStamp.getInstance().getTimeStamp());
        visitorBO.setOpType("Insert");
        //Insert data (updated fields + user input)
        Map curMap = MapUtil.merge(JSON.parseObject(JSON.toJSONString(visitorBO), Map.class), preMap);
        visitorBO.setData(JSON.toJSONString(curMap));
        VisitorDO visitorDO = new VisitorDO();
        BeanUtils.copyProperties(visitorBO, visitorDO);
        int num = visitorService.insertVisitor(visitorDO);
        return num == 0 ? CommonResult.fail("insert failed") : CommonResult.ok(num);
    }

    @SpookifyInfo
    @GetMapping("/modifyVisitor")
    public CommonResult modifyItem(@RequestBody VisitorModifyVO visitorVO){
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
        ItemBO itemBO = JSON.parseObject(JSON.toJSONString(map), ItemBO.class);
        itemBO.setData(JSON.toJSONString(map));
        ItemDO itemDO = new ItemDO();
        BeanUtils.copyProperties(itemBO, itemDO);
        int num = itemService.updateItemById(itemDO);
        return num == 0 ? CommonResult.fail("update failed") : CommonResult.ok(num);
    }



}
