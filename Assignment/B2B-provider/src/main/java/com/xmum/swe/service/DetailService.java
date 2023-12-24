package com.xmum.swe.service;


import com.xmum.swe.entities.DO.DetailDO;
import com.xmum.swe.entities.DTO.OrderPriceInfoDTO;
import com.xmum.swe.entities.VO.DetailInsertVO;
import com.xmum.swe.entities.VO.DetailModifyVO;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;
import java.util.Map;



public interface DetailService {

    DetailDO getDetailById(String id);

    List<DetailDO> getAllDetails();

    Map<String, Object> insertDetail(DetailDO detailDO);

    DetailDO getDetailWithMaxId();

    Map<String, Object> updateDetailById(DetailDO detailDO);

    int deleteDetailWithId(String id);

    Map<String, Object> insertDetail(DetailInsertVO itemVO);

    Map<String, Object> modifyMultiQuantities(Map<String, Object> map) throws IOException, IllegalAccessException;

    float getProductPriceWithOid(String oid);

    void deleteDetailWithOid(String oid);
}
