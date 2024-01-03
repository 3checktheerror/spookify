package com.xmum.swe.entities.VO;

import com.fasterxml.jackson.annotation.JsonProperty;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.sql.Timestamp;
import java.util.Map;

@Data
@ApiModel("Params for product modification")
public class ProductModifyVO {

    @JsonProperty("pId")
    private String pId;

    @JsonProperty("pgroupId")
    private String pgroupId;

    @JsonProperty("pName")
    private String pName;

    @JsonProperty("price")
    private float price;

    @JsonProperty("quantityInStock")
    private String quantityInStock;

    @JsonProperty("category")
    private String category;

    @JsonProperty("manufacturer")
    private String manufacturer;

    @JsonProperty("description")
    private String description;

    @JsonProperty("md5")
    private String md5;

    @JsonProperty("status")
    private String status;

    @JsonProperty("pdCreate")
    private Timestamp pdCreate;

    @JsonProperty("pdModified")
    private Timestamp pdModified;

    @JsonProperty("opType")
    private String opType;

    //  @JsonProperty("data")
//  private String data;
    @ApiModelProperty("additional params")
    @JsonProperty("map")
    private Map<String, Object> map;

    @JsonProperty("token")
    private String token;

    @JsonProperty("sessionId")
    private String sessionId;
}
