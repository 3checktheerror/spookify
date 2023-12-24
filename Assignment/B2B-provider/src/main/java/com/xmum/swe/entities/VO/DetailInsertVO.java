package com.xmum.swe.entities.VO;

import com.fasterxml.jackson.annotation.JsonProperty;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.sql.Timestamp;
import java.util.Map;

@Data
@ApiModel("Params for detail insertion")
public class DetailInsertVO {
    @JsonProperty("dId")
    private String dId;

    @JsonProperty("dgroupId")
    private String dgroupId;

    @JsonProperty("name")
    private String name;

    @JsonProperty("unitPrice")
    private float unitPrice;

    @JsonProperty("quantity")
    private int quantity;

    @JsonProperty("subtotal")
    private float subtotal;

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

    @ApiModelProperty("order id(for this detail)")
    @JsonProperty("oIdFk")
    private String oIdFk;
}
