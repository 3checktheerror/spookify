package com.xmum.swe.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


@Controller
@RequestMapping("/a")
public class SpringBootJSPController {

    @RequestMapping("/b")
    public ModelAndView helloWorld() {

        return new ModelAndView("/test");
    }
}
