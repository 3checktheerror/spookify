package com.xmum.swe.controller;


import com.xmum.swe.entities.VO.SwaggerReqVO;
import com.xmum.swe.entities.VO.SwaggerResVO;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.web.bind.annotation.*;

/**
 * @className: SwaggerController
 * @description: swagger 接口测试
 * @author: sh.Liu
 * @date: 2022-03-22 19:18
 */
@RestController
@RequestMapping("/swagger")
@Api(value = "用户接口", tags = {"用户接口"})
public class SwaggerController {

    @ApiOperation("新增用户")
    @PostMapping("save")
    public String save(@RequestBody SwaggerReqVO req) {
        return "success";
    }

    @GetMapping("getById")
    @ApiOperation("根据条件查询用户")
    public SwaggerResVO getById(@RequestBody SwaggerResVO req) {
        return new SwaggerResVO();
    }
}