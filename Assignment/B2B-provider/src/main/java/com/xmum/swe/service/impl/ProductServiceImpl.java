package com.xmum.swe.service.impl;

import cn.hutool.core.text.replacer.StrReplacer;
import cn.hutool.core.util.ObjectUtil;
import com.alibaba.fastjson2.JSON;
import com.alibaba.fastjson2.JSONObject;
import com.alibaba.fastjson2.filter.SimplePropertyPreFilter;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.xmum.swe.dao.DetailDao;
import com.xmum.swe.dao.ProductDao;
import com.xmum.swe.entities.BO.ProductBO;
import com.xmum.swe.entities.DO.ProductDO;
import com.xmum.swe.entities.VO.ProductInsertVO;
import com.xmum.swe.entities.VO.ProductModifyVO;
import com.xmum.swe.exception.SpookifyBusinessException;
import com.xmum.swe.service.IdService;
import com.xmum.swe.service.ProductService;
import com.xmum.swe.utils.JsonUtil;
import com.xmum.swe.utils.SpookifyTimeStamp;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Service
@Slf4j
public class ProductServiceImpl implements ProductService {
    @Resource
    private ProductDao productDao;

    @Resource
    private IdService idService;


    public ProductDO getProductById(String id) {
        ProductDO product = productDao.selectById(id);
        Optional.ofNullable(product)
                .orElseThrow(() -> new SpookifyBusinessException("No such product!"));
        return product;
    }

    public List<ProductDO> getAllProducts() {
        List<ProductDO> products = productDao.selectList(null);
        Optional.ofNullable(products)
                .orElseThrow(() -> new SpookifyBusinessException("products list is empty!"));
        return products;
    }

    public ProductDO getProductWithMaxId() {
        ProductDO[] arr = (ProductDO[])productDao.selectList(new QueryWrapper<ProductDO>().orderByDesc("p_id"))
                .stream().
                limit(1)
                .toArray(ProductDO[]::new);
        if(ObjectUtil.isNotEmpty(arr)) return arr[0];
        else {
            ProductDO productDO = new ProductDO();
            productDO.setPId("SPPD000001");
            return productDO;
        }
    }

    public Map<String, Object> insertProduct(ProductDO productDO) {
        int num = productDao.insert(productDO);
        Map<String, Object> map = new HashMap<>();
        map.put("num", num);
        map.put("id", productDO.getPId());
        return map;
    }

    public boolean checkProductName(String name) {
        ProductDO product = productDao.selectOne(new QueryWrapper<ProductDO>().eq("p_name", name));
        return !ObjectUtil.isNull(product);
    }


    public Map<String, Object> updateProductById(ProductDO productDO) {
        int num = productDao.updateById(productDO);
        Map<String, Object> map = new HashMap<>();
        map.put("num", num);
        map.put("id", productDO.getPId());
        return map;
    }

    @Override
    public Map<String, Object> insertProduct(ProductInsertVO productVO) {
        //Layer 1
        if(this.checkProductName(productVO.getPName())) {
            Map<String, Object> map = new HashMap<>();
            map.put("Error", "product name exists!");
            return map;
        }
        String nextId = idService.getNextId(this.getProductWithMaxId().getPId());
        //Layer 2
        ProductBO productBO = new ProductBO();
        BeanUtils.copyProperties(productVO, productBO, "map");
        Timestamp curTime = SpookifyTimeStamp.getInstance().getTimeStamp();
        productBO.setPId(nextId);
        productBO.setPdCreate(curTime);
        productBO.setPdModified(curTime);
        productBO.setOpType("Insert");
        Map<String, Object> map = productVO.getMap();
        SimplePropertyPreFilter filter = new SimplePropertyPreFilter();
        filter.getExcludes().add("data");
        filter.getExcludes().add("file");
        JSONObject obj = JSON.parseObject(JSON.toJSONString(productBO, filter));
        if(ObjectUtil.isNotNull(map)) obj.putAll(map);
        productBO.setData(obj.toJSONString());
        //Layer 3
        ProductDO productDO = new ProductDO();
        BeanUtils.copyProperties(productBO, productDO);
        return this.insertProduct(productDO);
    }

    @Override
    public Map<String, Object> modifyProduct(ProductModifyVO productVO) {
        //Layer 1
        ProductDO preDO = this.getProductById(productVO.getPId());
        JSONObject preData = JSON.parseObject(preDO.getData());
        SimplePropertyPreFilter filter = new SimplePropertyPreFilter();
        filter.getExcludes().add("map");
        JSONObject VO_data = JSON.parseObject(JSON.toJSONString(productVO, filter));
        if(ObjectUtil.isNotNull(productVO.getMap())) VO_data.putAll(productVO.getMap());     //get whole VO data
        //Layer 2
        JsonUtil.merge(preData, VO_data);
        preData.put("status", "modified");
        preData.put("opType", "modify");
        preData.put("pdModified", SpookifyTimeStamp.getInstance().getTimeStamp());
        ProductBO productBO = JSON.parseObject(preData.toJSONString(), ProductBO.class);
        productBO.setData(preData.toJSONString());
        //Layer 3
        ProductDO productDO = new ProductDO();
        BeanUtils.copyProperties(productBO, productDO);
        return this.updateProductById(productDO);
    }

    @Override
    public Map<String, Object> deleteProduct(String id) {
        int num = productDao.deleteById(id);
        Map<String, Object> res = new HashMap();
        res.put("id", id);
        res.put("num", num);
        return res;
    }
}
