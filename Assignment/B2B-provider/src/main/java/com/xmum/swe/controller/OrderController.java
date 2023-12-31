package com.xmum.swe.controller;


import com.xmum.swe.annotation.SpookifyInfo;
import com.xmum.swe.entities.CommonResult;
import com.xmum.swe.entities.DO.OrderDO;
import com.xmum.swe.entities.DO.ProductDO;
import com.xmum.swe.entities.VO.OrderInsertVO;
import com.xmum.swe.entities.VO.OrderModifyVO;
import com.xmum.swe.service.OrderService;
import io.swagger.annotations.Api;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;
import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

//@RefreshScope
@RestController
@RequestMapping("/order")
@Slf4j
@Api(value = "Order Query Interface", tags = {"Order Query Interface"})
public class OrderController {

    @Resource
    private OrderService orderService;

    @SpookifyInfo
    @GetMapping("/getOrderById/{id}")
    public CommonResult getOrderById(@PathVariable("id") String id){
        OrderDO order = orderService.getOrderById(id);
        return CommonResult.ok(order);
    }

    @SpookifyInfo
    @GetMapping("/getAllOrders")
    public CommonResult getAllOrders(){
        List<OrderDO> orders = orderService.getAllOrders();
        return CommonResult.ok(orders);
    }

    @SpookifyInfo
    @PostMapping("/insertOrder")
    public CommonResult insertOrder(@RequestBody OrderInsertVO orderVO){
        Map<String, Object> map = orderService.insertOrder(orderVO);
        return (int)map.get("num") == 0 ? CommonResult.fail("insert failed") : CommonResult.ok(map);
    }

    @SpookifyInfo
    @PostMapping("/modifyOrder")
    public CommonResult modifyItem(@RequestBody OrderModifyVO orderVO){
        Map<String, Object> map = orderService.modifyOrder(orderVO);
        return (int)map.get("num") == 0 ? CommonResult.fail("update failed") : CommonResult.ok(map);
    }

    @SpookifyInfo
    @GetMapping("/deleteOrder/{id}")
    public CommonResult deleteItem(@PathVariable("id") String id){
        orderService.getOrderById(id);
        int num = orderService.deleteOrderWithId(id);
        return num == 0 ? CommonResult.ok("nothing to be deleted") : CommonResult.ok(num);
    }
}
