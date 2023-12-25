package com.xmum.swe.service;

import com.xmum.swe.entities.DO.DetailDO;
import com.xmum.swe.entities.DO.OrderDO;
import com.xmum.swe.entities.DO.ProductDO;
import com.xmum.swe.entities.VO.ProductInsertVO;
import com.xmum.swe.entities.VO.ProductModifyVO;

import java.util.List;
import java.util.Map;


public interface ProductService {

    ProductDO getProductById(String id);

    List<ProductDO> getAllProducts();

    ProductDO getProductWithMaxId();

    Map<String, Object> insertProduct(ProductDO productDO);

    boolean checkProductName(String name);

    Map<String, Object> updateProductById(ProductDO productDO);

    Map<String, Object> insertProduct(ProductInsertVO productVO);

    Map<String, Object> modifyProduct(ProductModifyVO productVO);

    Map<String, Object> deleteProduct(String id);

}
