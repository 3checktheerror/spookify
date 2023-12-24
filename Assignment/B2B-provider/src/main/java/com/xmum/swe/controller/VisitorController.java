package com.xmum.swe.controller;

import com.xmum.swe.annotation.SpookifyInfo;
import com.xmum.swe.entities.CommonResult;
import com.xmum.swe.entities.DO.DetailDO;
import com.xmum.swe.entities.DO.OrderDO;
import com.xmum.swe.entities.VO.ProductInsertVO;
import com.xmum.swe.entities.VO.ProductModifyVO;
import com.xmum.swe.service.ProductService;
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
    private ProductService productService;

    @SpookifyInfo
    @GetMapping("/getVisitorById/{id}")
    public CommonResult getVisitor(@PathVariable("id") String id){
        OrderDO visitor = productService.getVisitorById(id);
        return CommonResult.ok(visitor);
    }

    @SpookifyInfo
    @GetMapping("/getAllVisitors")
    public CommonResult getAllVisitors(){
        List<OrderDO> visitors = productService.getAllVisitors();
        return CommonResult.ok(visitors);
    }

    @SpookifyInfo
    @GetMapping("/getitems/{vid}")
    public CommonResult getItems(@PathVariable("vid") String vid){
        List<DetailDO> items = productService.getItemsWithVid(vid);
        return CommonResult.ok(items);
    }

    @SpookifyInfo
    @GetMapping("/getIids/{vid}")
    public CommonResult getIids(@PathVariable("vid") String vid){
        List<String> ids = productService.getIidWithVid(vid);
        return CommonResult.ok(ids);
    }

    @SpookifyInfo
    @PostMapping("/insertVisitor")
    public CommonResult insertVisitor(@RequestBody ProductInsertVO visitorVO){
        Map<String, Object> map = productService.insertVisitor(visitorVO);
        return map.get("Error") == "visitor name exists!" ? CommonResult.fail("visitor name exists!") : CommonResult.ok(map);
    }

    @SpookifyInfo
    @PostMapping("/modifyVisitor")
    public CommonResult modifyVisitor(@RequestBody ProductModifyVO visitorVO){
        Map<String, Object> res = productService.modifyVisitor(visitorVO);
        return (int)res.get("num") == 0 ? CommonResult.fail("update failed") : CommonResult.ok(res);
    }

    @SpookifyInfo
    @GetMapping("/deleteVisitor/{id}")
    public CommonResult deleteVisitor(@PathVariable("id") String id){
        //Just check whether id exists
        productService.getVisitorById(id);
        Map<String, Object> map = productService.deleteVisitorWithItems(id);
        return (int)map.get("itemNum") == 0 ? CommonResult.ok("nothing to be deleted") : CommonResult.ok(map);
    }
}
