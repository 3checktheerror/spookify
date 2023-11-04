package com.xmum.swe.controller;


import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;


@RestController
@RequestMapping("/api")
public class test2 {

    @PostMapping("/submit")
    public ResponseEntity<String> receiveJsonDataFromFrontend(@RequestBody Map<String, Object> jsonData) {
        // 处理接收到的JSON数据
        String message = "Received JSON data from the frontend: " + jsonData.toString();
        return ResponseEntity.ok(message);
    }
}
