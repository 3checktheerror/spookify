package com.xmum.swe.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;


@Controller
@RequestMapping("a")
public class TestController {

    @GetMapping("b")
    public ModelAndView helloWorld() {
        ModelAndView mv = new ModelAndView();

        mv.setViewName("/test");
        return mv;
    }


}