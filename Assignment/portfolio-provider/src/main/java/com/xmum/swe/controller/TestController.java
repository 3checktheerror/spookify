package com.xmum.swe.controller;

import com.xmum.swe.entities.CommonResult;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;


@RestController
@Slf4j
@RequestMapping("test")
public class TestController {
    @GetMapping("testOk")
    public CommonResult getSuccessRes(){
        String rt = "ok";
        return CommonResult.ok(rt);
    }
    @GetMapping("testfail")
    public CommonResult getFailRes(){
        String rt = "fail";
        int a = 1/0;
        return CommonResult.fail(rt);
    }
}
