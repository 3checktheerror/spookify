package com.xmum.swe.controller;


import com.xmum.swe.annotation.SpookifyInfo;
import com.xmum.swe.entities.CommonResult;
import com.xmum.swe.entities.DO.DetailDO;
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

@RestController
@RequestMapping("/item")
@Validated
@Slf4j
@Api(value = "Item Query Interface", tags = {"Item Query Interface"})
public class ItemController {

    @Resource
    private DetailService detailService;

    @SpookifyInfo
    @GetMapping("/getItemById/{id}")
    public CommonResult getItem(@PathVariable("id") String id) {
        DetailDO item = detailService.getItemById(id);
        return CommonResult.ok(item);
    }

    @SpookifyInfo
    @GetMapping("/download/{id}")
    public void downLoadItem(@PathVariable("id") String id, HttpServletResponse response) throws IOException {
        DetailDO item = detailService.getItemById(id);
        String fileName = item.getFileName();
        response.addHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode(fileName, "UTF-8"));
        response.setContentType("application/octet-stream");
        ServletOutputStream os = response.getOutputStream();
        byte[] file = item.getFile();
        os.write(file);
        os.flush();
        os.close();
    }

    @SpookifyInfo
    @GetMapping("/getAllItems")
    public CommonResult getAllItems(){
        List<DetailDO> items = detailService.getAllItems();
        return CommonResult.ok(items);
    }

    @ApiOperation("deprecated")
    @SpookifyInfo
    @GetMapping("/containsItemName")
    public boolean containsItemWithName(@RequestParam("ItemName") String name){
        boolean hasItem = detailService.containsItemName(name);
        return hasItem;
    }

    //注意，插入时map中有关键字段会覆盖，里面覆盖外面
    //null值的字段被自动忽略(比如file)
    //map中存了除了空值(比如file)外的所有数据
    @SpookifyInfo
    @PostMapping("/insertItem")
    public CommonResult insertItem(@Valid DetailInsertVO itemVO, @RequestParam(value = "file", required = false) MultipartFile multipartFile){
        Map<String, Object> map = detailService.insertItem(itemVO, multipartFile);
        return (int)map.get("num") == 0 ? CommonResult.fail("insert failed") : CommonResult.ok(map);
    }

    @SpookifyInfo
    @PostMapping("/modifyItem")
    public CommonResult modifyItem(@Valid DetailModifyVO itemVO, @RequestParam(value ="file", required = false) MultipartFile multipartFile) throws IOException, IllegalAccessException {

        Map<String, Object> map = detailService.modifyItem(itemVO, multipartFile);
        return (int)map.get("num") == 0 ? CommonResult.fail("update failed") : CommonResult.ok(map);
    }

    @SpookifyInfo
    @GetMapping("/deleteItem/{id}")
    public CommonResult deleteItem(@PathVariable("id") String id){
        //Just check whether id exists
        detailService.getItemById(id);
        int num = detailService.deleteItemWithId(id);
        return num == 0 ? CommonResult.ok("nothing to be deleted") : CommonResult.ok(num);
    }

}
