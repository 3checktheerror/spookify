package com.xmum.swe.controller;

import com.xmum.swe.annotation.SpookifyInfo;
import com.xmum.swe.entities.CommonResult;
import com.xmum.swe.entities.DO.DetailDO;
import com.xmum.swe.entities.DO.OrderDO;
import com.xmum.swe.entities.DO.ProductDO;
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
@RequestMapping("/product")
@Slf4j
@Api(value = "Product Query Interface", tags = {"Product Query Interface"})
public class ProductController {

    @Resource
    private ProductService productService;

    @SpookifyInfo
    @GetMapping("/getProductById/{id}")
    public CommonResult getVisitor(@PathVariable("id") String id){
        ProductDO product = productService.getProductById(id);
        return CommonResult.ok(product);
    }

    @SpookifyInfo
    @GetMapping("/getAllProducts")
    public CommonResult getAllVisitors(){
        List<ProductDO> products = productService.getAllProducts();
        return CommonResult.ok(products);
    }


    @SpookifyInfo
    @PostMapping("/insertProduct")
    public CommonResult insertVisitor(@RequestBody ProductInsertVO visitorVO){
        Map<String, Object> map = productService.insertProduct(visitorVO);
        return map.get("Error") == "visitor name exists!" ? CommonResult.fail("visitor name exists!") : CommonResult.ok(map);
    }

    @SpookifyInfo
    @PostMapping("/modifyVisitor")
    public CommonResult modifyVisitor(@RequestBody ProductModifyVO productVO){
        Map<String, Object> res = productService.modifyProduct(productVO);
        return (int)res.get("num") == 0 ? CommonResult.fail("update failed") : CommonResult.ok(res);
    }

    @SpookifyInfo
    @GetMapping("/deleteProduct/{id}")
    public CommonResult deleteProduct(@PathVariable("id") String id){
        productService.getProductById(id);
        Map<String, Object> map = productService.deleteProduct(id);
        return (int)map.get("itemNum") == 0 ? CommonResult.ok("nothing to be deleted") : CommonResult.ok(map);
    }
}
