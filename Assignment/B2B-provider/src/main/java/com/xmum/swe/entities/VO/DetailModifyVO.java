package com.xmum.swe.entities.VO;

import com.fasterxml.jackson.annotation.JsonProperty;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.sql.Timestamp;
import java.util.Map;

@Data
@ApiModel("Params for item modification")
public class DetailModifyVO {

    @JsonProperty("dId")
    private String dId;

    @JsonProperty("dgroupId")
    private String dgroupId;

    @JsonProperty("quantity")
    private int quantity;

    @JsonProperty("name")
    private String name;

    @JsonProperty("md5")
    private String md5;

    @JsonProperty("dtCreate")
    private Timestamp dtCreate;

    @JsonProperty("dtModified")
    private Timestamp dtModified;

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
