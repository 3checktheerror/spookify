package com.xmum.swe.service.impl;

import cn.hutool.core.util.ObjectUtil;
import com.alibaba.fastjson2.JSON;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.xmum.swe.dao.ItemDao;
import com.xmum.swe.dao.VisitorDao;
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
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Service
@Slf4j
public class ItemServiceImpl implements ItemService {
    @Resource
    private ItemDao itemDao;

    @Resource
    private VisitorService visitorService;



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
        ItemDO[] arr = (ItemDO[])itemDao.selectList(new QueryWrapper<ItemDO>().orderByDesc("i_id"))
                .stream().
                limit(1)
                .toArray(ItemDO[]::new);
        if(ObjectUtil.isNotEmpty(arr)) return arr[0];
        else {
            ItemDO itemDO = new ItemDO();
            itemDO.setIId("SPIT000001");
            return itemDO;
        }

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

    @Override
    public Map<String, Object> insertItem(ItemInsertVO itemVO, MultipartFile multipartFile) {
        if(ObjectUtil.isNotNull(multipartFile)){
            //first assign fileName because front-end won't pass this
            itemVO.setFileName(multipartFile.getOriginalFilename());
        }
        //check if the foreign key exists
        visitorService.getVisitorById(itemVO.getVIdFk());
        //get new id
        ItemDO maxIdItem = this.getItemWithMaxId();
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
        } else {
            itemBO.setData(JSON.toJSONString(itemBO));
        }
        ItemDO itemDO = new ItemDO();
        BeanUtils.copyProperties(itemBO, itemDO);
        //file insert at last
        if(ObjectUtil.isNotNull(multipartFile)){
            try {
                itemDO.setFile(multipartFile.getBytes());
                itemDO.setFileName(multipartFile.getOriginalFilename());
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        }
        Map<String, Object> map = this.insertItem(itemDO);
        return map;
    }

    @Override
    public Map<String, Object> modifyItem(ItemModifyVO itemVO, MultipartFile multipartFile) throws IOException {
        String id = itemVO.getIId();
        ItemDO preDO = this.getItemById(id);
        Map preMap = JSON.parseObject(preDO.getData(), Map.class);
        ItemNoMapBO itemNoMapBO = new ItemNoMapBO();
        BeanUtils.copyProperties(itemVO, itemNoMapBO);
        Map map1 = JSON.parseObject(JSON.toJSONString(itemNoMapBO), Map.class);
        Map map2 = null;
        if(ObjectUtil.isNotNull(itemVO.getMap())){
            map2 = MapUtil.merge(map1, itemVO.getMap());
        } else {
            map2 = map1;
        }
        Map map = MapUtil.merge(preMap, map2);
        //map中并不需要放全部字段，只要放状态相关状态即可，也即状态还是需要手动更新
        map.put("itModified", SpookifyTimeStamp.getInstance().getTimeStamp());
        map.put("status", "modified");
        map.put("opType", "modify");
        if(ObjectUtil.isNotNull(map.get("fileName"))){
            map.put("fileName", multipartFile.getOriginalFilename());
        }
        ItemBO itemBO = JSON.parseObject(JSON.toJSONString(map), ItemBO.class);
        //set file
        if(ObjectUtil.isNotNull(multipartFile)){
            itemBO.setFileName(multipartFile.getOriginalFilename());
            itemBO.setFile(multipartFile.getBytes());
        }
        itemBO.setData(JSON.toJSONString(map));
        ItemDO itemDO = new ItemDO();
        BeanUtils.copyProperties(itemBO, itemDO);
        Map<String, Object> res = this.updateItemById(itemDO);
        return res;
    }
}
