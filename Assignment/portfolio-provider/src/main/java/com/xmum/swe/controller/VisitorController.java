package com.xmum.swe.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.xmum.swe.annotation.SpookifyInfo;
import com.xmum.swe.dao.VisitorDao;
import com.xmum.swe.entities.CommonResult;
import com.xmum.swe.entities.DO.ItemDO;
import com.xmum.swe.entities.DO.VisitorDO;
import com.xmum.swe.exception.SpookifyBusinessException;
import com.xmum.swe.service.ItemService;
import com.xmum.swe.service.VisitorService;
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

}
