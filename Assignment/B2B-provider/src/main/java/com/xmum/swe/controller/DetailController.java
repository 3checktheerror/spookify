package com.xmum.swe.controller;


import com.xmum.swe.annotation.SpookifyInfo;
import com.xmum.swe.entities.CommonResult;
import com.xmum.swe.entities.DO.DetailDO;
import com.xmum.swe.entities.VO.DetailGroupUpdateVO;
import com.xmum.swe.entities.VO.DetailInsertVO;
import com.xmum.swe.entities.VO.DetailModifyVO;
import com.xmum.swe.service.DetailService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.*;

//@RefreshScope
@RestController
@RequestMapping("/detail")
@Validated
@Slf4j
@Api(value = "Detail Query Interface", tags = {"Detail Query Interface"})
public class DetailController {

    @Resource
    private DetailService detailService;

    @SpookifyInfo
    @GetMapping("/getDetailById/{id}")
    public CommonResult getItem(@PathVariable("id") String id) {
        DetailDO item = detailService.getDetailById(id);
        return CommonResult.ok(item);
    }

    @SpookifyInfo
    @GetMapping("/getAllDetails")
    public CommonResult getAllDetails(){
        List<DetailDO> items = detailService.getAllDetails();
        return CommonResult.ok(items);
    }

    //注意，插入时map中有关键字段会覆盖，里面覆盖外面
    //null值的字段被自动忽略(比如file)
    //map中存了除了空值(比如file)外的所有数据
    @SpookifyInfo
    @PostMapping("/insertDetail")
    public CommonResult insertDetail(@Valid @RequestBody DetailInsertVO detailVO){
        Map<String, Object> map = detailService.insertDetail(detailVO);
        return (int)map.get("num") == 0 ? CommonResult.fail("insert failed") : CommonResult.ok(map);
    }

    @SpookifyInfo
    @PostMapping("/modifyDetail")
    public CommonResult modifyItem(@Valid @RequestBody DetailGroupUpdateVO updateVO) throws IOException, IllegalAccessException {

        Map<String, Object> res = detailService.modifyMultiQuantities(updateVO.getMap());
        return (int)res.get("num") == 0 ? CommonResult.fail("update failed") : CommonResult.ok(res);
    }

    @SpookifyInfo
    @GetMapping("/deleteDetail/{id}")
    public CommonResult deleteItem(@PathVariable("id") String id){
        //Just check whether id exists
        detailService.getDetailById(id);
        int num = detailService.deleteDetailWithId(id);
        return num == 0 ? CommonResult.ok("nothing to be deleted") : CommonResult.ok(num);
    }

}
