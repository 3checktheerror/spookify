package com.xmum.swe.controller;


import com.xmum.swe.annotation.SpookifyInfo;
import com.xmum.swe.entities.CommonResult;
import com.xmum.swe.entities.DO.ItemDO;
import com.xmum.swe.entities.VO.ItemInsertVO;
import com.xmum.swe.entities.VO.ItemModifyVO;
import com.xmum.swe.service.ItemService;
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
    private ItemService itemService;

    @SpookifyInfo
    @GetMapping("/getItemById/{id}")
    public CommonResult getItem(@PathVariable("id") String id) {
        ItemDO item = itemService.getItemById(id);
        return CommonResult.ok(item);
    }

    @SpookifyInfo
    @GetMapping("/download/{id}")
    public void downLoadItem(@PathVariable("id") String id, HttpServletResponse response) throws IOException {
        ItemDO item = itemService.getItemById(id);
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
        List<ItemDO> items = itemService.getAllItems();
        return CommonResult.ok(items);
    }

    @ApiOperation("deprecated")
    @SpookifyInfo
    @GetMapping("/containsItemName")
    public boolean containsItemWithName(@RequestParam("ItemName") String name){
        boolean hasItem = itemService.containsItemName(name);
        return hasItem;
    }

    //注意，插入时map中有关键字段会覆盖，里面覆盖外面
    //null值的字段被自动忽略(比如file)
    //map中存了除了空值(比如file)外的所有数据
    @SpookifyInfo
    @PostMapping("/insertItem")
    public CommonResult insertItem(@Valid ItemInsertVO itemVO, @RequestParam(value = "file", required = false) MultipartFile multipartFile){
        Map<String, Object> map = itemService.insertItem(itemVO, multipartFile);
        return (int)map.get("num") == 0 ? CommonResult.fail("insert failed") : CommonResult.ok(map);
    }

    @SpookifyInfo
    @PostMapping("/modifyItem")
    public CommonResult modifyItem(@Valid ItemModifyVO itemVO, @RequestParam("file") MultipartFile multipartFile) throws IOException {

        Map<String, Object> map = itemService.modifyItem(itemVO, multipartFile);
        return (int)map.get("num") == 0 ? CommonResult.fail("update failed") : CommonResult.ok(map);
    }

    @SpookifyInfo
    @GetMapping("/deleteItem/{id}")
    public CommonResult deleteItem(@PathVariable("id") String id){
        //Just check whether id exists
        itemService.getItemById(id);
        int num = itemService.deleteItemWithId(id);
        return num == 0 ? CommonResult.ok("nothing to be deleted") : CommonResult.ok(num);
    }

}
