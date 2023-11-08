package com.xmum.swe.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.xmum.swe.annotation.SpookifyInfo;
import com.xmum.swe.dao.VisitorDao;
import com.xmum.swe.entities.CommonResult;
import com.xmum.swe.entities.DO.ItemDO;
import com.xmum.swe.entities.DO.VisitorDO;
import com.xmum.swe.exception.SpookifyBusinessException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/visitor")
@Slf4j
public class VisitorController {
    @Resource
    private VisitorDao visitorDao;

    @SpookifyInfo
    @GetMapping("/getItemById/{id}")
    public CommonResult getVisitor(@PathVariable("id") String id){
        VisitorDO visitor = visitorDao.selectById(id);
        Optional.ofNullable(visitor)
                .orElseThrow(() -> new SpookifyBusinessException("No such visitor!"));
        return CommonResult.ok(visitor);
    }

    @SpookifyInfo
    @GetMapping("/getAllVisitors")
    public CommonResult getAllVisitors(){
        List<VisitorDO> visitors = visitorDao.selectList(null);
        Optional.ofNullable(visitors)
                .orElseThrow(() -> new SpookifyBusinessException("items list is empty!"));
        return CommonResult.ok(visitors);
    }

    @SpookifyInfo
    @GetMapping("/getItem/{id}")
    public List<ItemDO> getItemsByVisitorId(@PathVariable("id") String vid){
        VisitorDO visitor = visitorDao.selectById(vid);
        Optional.ofNullable(visitor)
                .orElseThrow(() -> new SpookifyBusinessException("No such visitor!"));
        return null;
    }



}
