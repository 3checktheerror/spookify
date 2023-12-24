package com.xmum.swe.controller;

import com.xmum.swe.annotation.SpookifyInfo;
import com.xmum.swe.entities.CommonResult;
import com.xmum.swe.entities.DO.DetailDO;
import com.xmum.swe.entities.DO.OrderDO;
import com.xmum.swe.entities.VO.VisitorInsertVO;
import com.xmum.swe.entities.VO.VisitorModifyVO;
import com.xmum.swe.service.VisitorService;
import io.swagger.annotations.Api;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;
import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/visitor")
@Slf4j
@Api(value = "Visitor Query Interface", tags = {"Visitor Query Interface"})
public class VisitorController {

    @Resource
    private VisitorService visitorService;

    @SpookifyInfo
    @GetMapping("/getVisitorById/{id}")
    public CommonResult getVisitor(@PathVariable("id") String id){
        OrderDO visitor = visitorService.getVisitorById(id);
        return CommonResult.ok(visitor);
    }

    @SpookifyInfo
    @GetMapping("/getAllVisitors")
    public CommonResult getAllVisitors(){
        List<OrderDO> visitors = visitorService.getAllVisitors();
        return CommonResult.ok(visitors);
    }

    @SpookifyInfo
    @GetMapping("/getitems/{vid}")
    public CommonResult getItems(@PathVariable("vid") String vid){
        List<DetailDO> items = visitorService.getItemsWithVid(vid);
        return CommonResult.ok(items);
    }

    @SpookifyInfo
    @GetMapping("/getIids/{vid}")
    public CommonResult getIids(@PathVariable("vid") String vid){
        List<String> ids = visitorService.getIidWithVid(vid);
        return CommonResult.ok(ids);
    }

    @SpookifyInfo
    @PostMapping("/insertVisitor")
    public CommonResult insertVisitor(@RequestBody VisitorInsertVO visitorVO){
        Map<String, Object> map = visitorService.insertVisitor(visitorVO);
        return map.get("Error") == "visitor name exists!" ? CommonResult.fail("visitor name exists!") : CommonResult.ok(map);
    }

    @SpookifyInfo
    @PostMapping("/modifyVisitor")
    public CommonResult modifyVisitor(@RequestBody VisitorModifyVO visitorVO){
        Map<String, Object> res = visitorService.modifyVisitor(visitorVO);
        return (int)res.get("num") == 0 ? CommonResult.fail("update failed") : CommonResult.ok(res);
    }

    @SpookifyInfo
    @GetMapping("/deleteVisitor/{id}")
    public CommonResult deleteVisitor(@PathVariable("id") String id){
        //Just check whether id exists
        visitorService.getVisitorById(id);
        Map<String, Object> map = visitorService.deleteVisitorWithItems(id);
        return (int)map.get("itemNum") == 0 ? CommonResult.ok("nothing to be deleted") : CommonResult.ok(map);
    }
}
