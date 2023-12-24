package com.xmum.swe.controller;


import com.xmum.swe.annotation.SpookifyInfo;
import com.xmum.swe.entities.CommonResult;
import com.xmum.swe.entities.DO.ProductDO;
import com.xmum.swe.entities.VO.CustomerInsertVO;
import com.xmum.swe.entities.VO.CustomerModifyVO;
import com.xmum.swe.service.CustomerService;
import io.swagger.annotations.Api;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;
import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/customer")
@Slf4j
@Api(value = "Customer Query Interface", tags = {"Customer Query Interface"})
public class CustomerController {

    @Resource
    private CustomerService customerService;

    @SpookifyInfo
    @GetMapping("/getCustomerById/{id}")
    public CommonResult getCustomerById(@PathVariable("id") String id){
        ProductDO customer = customerService.getCustomerById(id);
        return CommonResult.ok(customer);
    }

    @SpookifyInfo
    @GetMapping("/getAllCustomers")
    public CommonResult getAllCustomers(){
        List<ProductDO> customers = customerService.getAllCustomers();
        return CommonResult.ok(customers);
    }

    @SpookifyInfo
    @PostMapping("/insertCustomer")
    public CommonResult insertItem(@RequestBody CustomerInsertVO cusVO){
        Map<String, Object> map = customerService.insertCustomer(cusVO);
        return (int)map.get("num") == 0 ? CommonResult.fail("insert failed") : CommonResult.ok(map);
    }

    @SpookifyInfo
    @PostMapping("/modifyCustomer")
    public CommonResult modifyItem(@RequestBody CustomerModifyVO cusVO){
        Map<String, Object> map = customerService.modifyCustomer(cusVO);
        return (int)map.get("num") == 0 ? CommonResult.fail("update failed") : CommonResult.ok(map);
    }

    @SpookifyInfo
    @GetMapping("/deleteCustomer/{id}")
    public CommonResult deleteItem(@PathVariable("id") String id){
        customerService.getCustomerById(id);
        int num = customerService.deleteCustomerWithId(id);
        return num == 0 ? CommonResult.ok("nothing to be deleted") : CommonResult.ok(num);
    }
}
