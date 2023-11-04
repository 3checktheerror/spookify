package com.xmum.swe.controller;

import com.xmum.swe.entities.VO.TestVO;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;


@Controller
@RequestMapping("/a")
public class SpringBootJSPController {

    @GetMapping("/b")
    public ModelAndView helloWorld() {
        ModelAndView mv = new ModelAndView();
        Map<String, Object> map = new HashMap<>();
        map.put("TestVO", new TestVO(100, "Qiu"));
        mv.addAllObjects(map);
        mv.setViewName("/test");
        return mv;
    }

    @GetMapping("/c")
    public void testGetObject(HttpServletRequest rq){
       rq.getSession().getAttribute("code");
    }
}
