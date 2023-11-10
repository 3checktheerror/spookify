package com.xmum.swe.controller;

import com.xmum.swe.entities.DO.Save;
import com.xmum.swe.service.SaveService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.validation.Valid;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;


@Controller
@RequestMapping("getPage")
public class DirectPageController {

    @Resource
    SaveService service;

    @GetMapping("cm")
    public ModelAndView accessContactMe() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/contactMe");
        return mv;
    }

    @GetMapping
    public String index(){

        return "index";
    }

    @PostMapping("/upload")
    @ResponseBody
    public Map<String, Object> upload(@RequestPart MultipartFile file) throws IOException {
        Map<String, Object> map = new HashMap<>();
        if(file.isEmpty()){
            map.put("result", "empty file");
            return map;
        }else {
            InputStream is = file.getInputStream();
            ByteArrayOutputStream out = new ByteArrayOutputStream();
            int len;
            byte[] buff = new byte[1024 * 10];
            while((len = is.read(buff)) != -1){
                out.write(buff, 0, len);
            }
            byte[] imgByte = out.toByteArray();
            Save save = new Save();
            save.setId(2);
            save.setImg(imgByte);
            boolean b = service.save(save);
            map.put("result", b);
            return map;
        }
    }
}