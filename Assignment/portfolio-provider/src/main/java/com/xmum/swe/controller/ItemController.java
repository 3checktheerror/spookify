package com.xmum.swe.controller;

import cn.hutool.core.img.Img;
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
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
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
    public CommonResult getItem(@PathVariable("id") String id) throws UnsupportedEncodingException {
        ItemDO item = itemService.getItemById(id);
        return CommonResult.ok(item);
    }

    @SpookifyInfo
    @GetMapping("/download/{id}")
    public void downLoadItem(@PathVariable("id") String id, HttpServletResponse response) throws IOException {
        ItemDO item = itemService.getItemById(id);
        String fileName = item.getFileName();
        response.addHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode(fileName, "UTF-8"));
        response.setContentType("application/octet-stream");
        ServletOutputStream os = response.getOutputStream();

        byte[] file = item.getFile();
        os.write(file);
        os.flush();
        os.close();
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
    public CommonResult insertItem(@Valid ItemInsertVO itemVO, @RequestParam("file") MultipartFile multipartFile){
        //first assign fileName because front-end won't pass this
        itemVO.setFileName(multipartFile.getOriginalFilename());
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
        if(ObjectUtil.isNotNull(preMap)){
            Map curMap = MapUtil.merge(JSON.parseObject(JSON.toJSONString(itemBO), Map.class), preMap);
            itemBO.setData(JSON.toJSONString(curMap));
        }
        ItemDO itemDO = new ItemDO();
        BeanUtils.copyProperties(itemBO, itemDO);
        //file insert at last
        try {
            itemDO.setFile(multipartFile.getBytes());
            itemDO.setFileName(multipartFile.getOriginalFilename());
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        Map<String, Object> map = itemService.insertItem(itemDO);
        return (int)map.get("num") == 0 ? CommonResult.fail("insert failed") : CommonResult.ok(map);
    }

    @SpookifyInfo
    @PostMapping("/modifyItem")
    public CommonResult modifyItem(@RequestBody ItemModifyVO itemVO, @RequestParam("file") MultipartFile multipartFile) throws IOException {
        String id = itemVO.getIId();
        ItemDO preDO = itemService.getItemById(id);
        if(ObjectUtil.isNotNull(multipartFile)) {
            preDO.setFileName(multipartFile.getOriginalFilename());
            preDO.setFile(multipartFile.getBytes());
        }
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
