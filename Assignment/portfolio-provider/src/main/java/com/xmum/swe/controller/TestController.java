package com.xmum.swe.controller;

import com.xmum.swe.annotation.SpookifyInfo;
import com.xmum.swe.entities.CommonResult;
import com.xmum.swe.listener.SpooifyEvent;
import com.xmum.swe.listener.impl.SpookifyEventDataImpl;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.ApplicationContext;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;


@RestController
@Slf4j
@RequestMapping("test")
public class TestController {
    @Resource
    ApplicationContext context;

    @SpookifyInfo(desc = "method")
    @GetMapping("testOk")
    public CommonResult getSuccessRes(){
        String rt = "ok";
        return CommonResult.ok(rt);
    }
    @SpookifyInfo(desc = "class")
    @GetMapping("testfail")
    public CommonResult getFailRes(){
        String rt = "fail";
        int a = 1/0;
        return CommonResult.fail(rt);
    }
    @SpookifyInfo(desc = "class")
    @GetMapping("listener")
    public CommonResult testListener(){
        SpookifyEventDataImpl eventData = new SpookifyEventDataImpl();
        SpooifyEvent event = new SpooifyEvent(this, eventData);
        context.publishEvent(event);
        return CommonResult.ok("end");
    }
}
