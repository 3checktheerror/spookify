package com.xmum.swe.entities.VO;

import com.fasterxml.jackson.annotation.JsonProperty;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.Map;

@Data
@ApiModel("Params for visitor modification")
public class VisitorModifyVO {

    @JsonProperty("vId")
    private String vId;

    @ApiModelProperty("visitor group")
    @JsonProperty("vgroupId")
    private String vgroupId;

    @JsonProperty("name")
    private String name;

    @JsonProperty("username")
    private String username;

    @JsonProperty("password")
    private String password;

    @JsonProperty("age")
    private int age;

    @JsonProperty("gender")
    private String gender;

    @JsonProperty("md5")
    private String md5;

    @ApiModelProperty("additional params")
    @JsonProperty("map")
    private Map<String, Object> map;

    @JsonProperty("token")
    private String token;

    @JsonProperty("sessionId")
    private String sessionId;
}
