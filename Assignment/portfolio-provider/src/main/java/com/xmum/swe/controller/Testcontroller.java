package com.xmum.swe.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("a")
public class Testcontroller {

    @GetMapping("b")
    public ModelAndView helloWorld() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/contactMe");
        return mv;
    }
}