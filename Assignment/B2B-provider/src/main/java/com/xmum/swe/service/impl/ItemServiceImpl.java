package com.xmum.swe.service.impl;

import cn.hutool.core.util.ObjectUtil;
import com.alibaba.fastjson2.JSON;
import com.alibaba.fastjson2.JSONObject;
import com.alibaba.fastjson2.filter.SimplePropertyPreFilter;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.xmum.swe.dao.ItemDao;
import com.xmum.swe.entities.BO.ItemBO;
import com.xmum.swe.entities.DO.DetailDO;
import com.xmum.swe.entities.VO.ItemInsertVO;
import com.xmum.swe.entities.VO.ItemModifyVO;
import com.xmum.swe.exception.SpookifyBusinessException;
import com.xmum.swe.service.IdService;
import com.xmum.swe.service.ItemService;
import com.xmum.swe.service.VisitorService;
import com.xmum.swe.utils.JsonUtil;
import com.xmum.swe.utils.SpookifyTimeStamp;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import java.io.IOException;
import java.sql.Timestamp;
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

    @Resource
    private IdService idService;



    public DetailDO getItemById(String id) {
        DetailDO item = itemDao.selectById(id);
        Optional.ofNullable(item)
                .orElseThrow(() -> new SpookifyBusinessException("No such item!"));
        return item;
    }

    public List<DetailDO> getAllItems() {
        List<DetailDO> items = itemDao.selectList(null);
        Optional.ofNullable(items)
                .orElseThrow(() -> new SpookifyBusinessException("items list is empty!"));
        return items;
    }

    public boolean containsItemName(String name) {
        QueryWrapper<DetailDO> wrapper = new QueryWrapper<>();
        DetailDO[] items = itemDao
                .selectList(wrapper.select("name")
                        .and(i -> i.eq("name", name)))
                .toArray(new DetailDO[0]);
        return items.length > 0;
    }

    public Map<String, Object> insertItem(DetailDO detailDO) {
        int num = itemDao.insert(detailDO);
        Map<String, Object> map = new HashMap<>();
        map.put("num", num);
        map.put("id", detailDO.getIId());
        return map;
    }

    public DetailDO getItemWithMaxId(){
        DetailDO[] arr = (DetailDO[])itemDao.selectList(new QueryWrapper<DetailDO>().orderByDesc("i_id"))
                .stream().
                limit(1)
                .toArray(DetailDO[]::new);
        if(ObjectUtil.isNotEmpty(arr)) return arr[0];
        else {
            DetailDO detailDO = new DetailDO();
            detailDO.setIId("SPIT000001");
            return detailDO;
        }
    }

    public Map<String, Object> updateItemById(DetailDO detailDO) {
        int num = itemDao.updateById(detailDO);
        Map<String, Object> map = new HashMap<>();
        map.put("num", num);
        map.put("id", detailDO.getIId());
        return map;
    }

    public int deleteItemWithId(String id) {
        int num = itemDao.deleteById(id);
        return num;
    }

    @Override
    public Map<String, Object> insertItem(ItemInsertVO itemVO, MultipartFile multipartFile) {
        //Layer 1
        if(ObjectUtil.isNotNull(multipartFile)){
            itemVO.setFileName(multipartFile.getOriginalFilename());
        }
        try {
            visitorService.getVisitorById(itemVO.getVIdFk());    //check if the foreign key exists
        } catch (SpookifyBusinessException sp) {
            sp.setMsg("Foreign key: vIdFk doesn't exist");
        }
        String nextId = idService.getNextId(this.getItemWithMaxId().getIId());
        //Layer 2
        ItemBO itemBO = new ItemBO();
        BeanUtils.copyProperties(itemVO, itemBO, "map");
        Timestamp curTime = SpookifyTimeStamp.getInstance().getTimeStamp();
        itemBO.setIId(nextId);
        itemBO.setItCreate(curTime);
        itemBO.setItModified(curTime);
        itemBO.setStatus("Submit");
        itemBO.setOpType("Insert");
        if(ObjectUtil.isNotNull(multipartFile)){
            try {
                itemBO.setFile(multipartFile.getBytes());
                itemBO.setFileName(multipartFile.getOriginalFilename());
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        }
        Map<String, Object> map = itemVO.getMap();
        SimplePropertyPreFilter filter = new SimplePropertyPreFilter();
        filter.getExcludes().add("data");
        filter.getExcludes().add("file");
        JSONObject obj = JSON.parseObject(JSON.toJSONString(itemBO, filter));
        if(ObjectUtil.isNotNull(map)) obj.putAll(map);
        itemBO.setData(obj.toJSONString());
        //Layer 3
        DetailDO detailDO = new DetailDO();
        BeanUtils.copyProperties(itemBO, detailDO);
        return this.insertItem(detailDO);
    }

    @Override
    public Map<String, Object> modifyItem(ItemModifyVO itemVO, MultipartFile multipartFile) throws IOException {
        //Layer 1
        DetailDO preDO = this.getItemById(itemVO.getIId());
        JSONObject preData = JSON.parseObject(preDO.getData());
        String newFileName = null;
        byte[] newFileData = null;
        if(ObjectUtil.isNotNull(multipartFile)){
            newFileName = multipartFile.getOriginalFilename();
            newFileData = multipartFile.getBytes();
        }
        SimplePropertyPreFilter filter = new SimplePropertyPreFilter();
        filter.getExcludes().add("map");
        JSONObject VO_data = JSON.parseObject(JSON.toJSONString(itemVO, filter));
        if(ObjectUtil.isNotNull(itemVO.getMap())) VO_data.putAll(itemVO.getMap());     //get whole VO data
        //Layer 2
        JsonUtil.merge(preData, VO_data);
        preData.put("status", "modified");
        preData.put("opType", "modify");
        preData.put("itModified", SpookifyTimeStamp.getInstance().getTimeStamp());
        if(ObjectUtil.isNotNull(multipartFile)) preData.put("fileName", newFileName);
        else preData.put("fileName", preDO.getFileName());
        ItemBO itemBO = JSON.parseObject(preData.toJSONString(), ItemBO.class);
        itemBO.setData(preData.toJSONString());
        if(ObjectUtil.isNotNull(multipartFile)) itemBO.setFile(newFileData);
        else itemBO.setFile(preDO.getFile());
        //Layer 3
        DetailDO detailDO = new DetailDO();
        BeanUtils.copyProperties(itemBO, detailDO);
        return this.updateItemById(detailDO);
    }

}
