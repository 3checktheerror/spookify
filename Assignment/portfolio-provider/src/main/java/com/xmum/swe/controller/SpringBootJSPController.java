package com.xmum.swe.controller;

import com.xmum.swe.entities.VO.TestVO;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.Map;


@Controller
@RequestMapping("/a")
public class SpringBootJSPController {

    @RequestMapping("/b")
    public ModelAndView helloWorld() {
        ModelAndView mv = new ModelAndView();
        Map<String, Object> map = new HashMap<>();
        map.put("TestVO", new TestVO(100, "Qiu"));
        mv.addAllObjects(map);
        mv.setViewName("/test2");
        return mv;
    }
}
