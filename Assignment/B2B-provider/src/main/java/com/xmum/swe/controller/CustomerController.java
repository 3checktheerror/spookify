package com.xmum.swe.controller;


import com.xmum.swe.annotation.SpookifyInfo;
import com.xmum.swe.entities.CommonResult;
import com.xmum.swe.entities.DO.CustomerDO;
import com.xmum.swe.entities.VO.CustomerInsertVO;
import com.xmum.swe.entities.VO.CustomerModifyVO;
import com.xmum.swe.service.CustomerService;
import io.swagger.annotations.Api;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

//@RefreshScope
@RestController
@RequestMapping("/customer")
@Slf4j
@Api(value = "Customer Query Interface", tags = {"Customer Query Interface"})
public class CustomerController {

    @Resource
    private CustomerService customerService;

    @SpookifyInfo
    @PostMapping("/login")
    public CommonResult login(@RequestBody CustomerInsertVO cusVO, HttpSession session, HttpServletRequest request, HttpServletResponse response){
        String res = customerService.login(cusVO, session, request, response);
        return CommonResult.ok(res);
    }

    @SpookifyInfo
    @GetMapping("/getCustomerById/{id}")
    public CommonResult getCustomerById(@PathVariable("id") String id){
        CustomerDO customer = customerService.getCustomerById(id);
        return CommonResult.ok(customer);
    }

    @SpookifyInfo
    @GetMapping("/getAllCustomers")
    public CommonResult getAllCustomers(){
        List<CustomerDO> customers = customerService.getAllCustomers();
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


    @SpookifyInfo
    @GetMapping("/logout")
    public CommonResult logout(HttpSession session, HttpServletRequest request, HttpServletResponse response) {
        session.removeAttribute("spookify-b2b-customer");
        Cookie cookie_username = new Cookie("cookie_username", "");
        cookie_username.setMaxAge(0);
        cookie_username.setPath(request.getContextPath());
        response.addCookie(cookie_username);
        return CommonResult.ok("logout successfully");
    }
}
