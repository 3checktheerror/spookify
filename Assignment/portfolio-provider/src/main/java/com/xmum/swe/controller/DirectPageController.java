package com.xmum.swe.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


@Controller
@RequestMapping("getPage")
public class DirectPageController {

    @GetMapping("cm")
    public ModelAndView accessContactMe() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/contactMe");
        return mv;
    }
}