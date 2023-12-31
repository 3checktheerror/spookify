package com.xmum.swe.entities.VO;

import com.fasterxml.jackson.annotation.JsonProperty;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.sql.Blob;
import java.util.Map;

@Data
@ApiModel("Params for customer modification")
public class CustomerModifyVO {
    @JsonProperty("cId")
    private String cId;

    @ApiModelProperty("customer group")
    @JsonProperty("cgroupId")
    private String cgroupId;

    @JsonProperty("name")
    private String name;

    @JsonProperty("age")
    private int age;

    @JsonProperty("gender")
    private String gender;

    @JsonProperty("file")
    private Blob file;

    @JsonProperty("md5")
    private String md5;

    @ApiModelProperty("customer identity")
    @JsonProperty("csType")
    private String csType;

    @ApiModelProperty("additional params")
    @JsonProperty("map")
    private Map<String, Object> map;

    @JsonProperty("token")
    private String token;

    @JsonProperty("sessionId")
    private String sessionId;
}
