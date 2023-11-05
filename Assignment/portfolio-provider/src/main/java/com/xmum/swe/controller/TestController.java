package com.xmum.swe.controller;

import com.xmum.swe.annotation.SpookifyInfo;
import com.xmum.swe.dao.TestDao;
import com.xmum.swe.entities.CommonResult;
import com.xmum.swe.entities.DO.TestPlusDO;
import com.xmum.swe.entities.VO.UserVO;
import com.xmum.swe.listener.SpooifyEvent;
import com.xmum.swe.listener.impl.SpookifyEventDataImpl;
import com.xmum.swe.dao.TestPlusMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.ApplicationContext;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.websocket.server.PathParam;
import java.util.List;


@RestController
@Slf4j
@RequestMapping("/test")
public class TestController {

    @Resource
    ApplicationContext context;

    @Resource
    private TestDao testDao;

    @Resource
    private TestPlusMapper testPlusDAO;

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

    @SpookifyInfo
    @GetMapping ("f")
    public void testParseObject2(){
        testDao.updateInfo("Ellie", 1);
        List<TestPlusDO> testPlus = testPlusDAO.selectList(null);
        System.out.println(testPlus);
    }

    @SpookifyInfo
    @PostMapping("e")
    public void testParseObject(@RequestBody UserVO userVO){
        testDao.updateInfo(userVO.getName(), userVO.getAge());
        //List<TestPlusDo> testPlusDos = testPlusDao.selectList(null);
    }

    @SpookifyInfo
    @GetMapping ("g")
    public void testParseObject3(@PathParam("name") String name, @PathParam("number") int number){
        testDao.updateInfo(name, number);
        //List<TestPlusDo> testPlusDos = testPlusDao.selectList(null);
    }
}
