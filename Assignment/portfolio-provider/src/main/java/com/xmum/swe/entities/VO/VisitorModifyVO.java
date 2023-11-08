package com.xmum.swe.entities.VO;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

import java.util.Map;

@Data
public class VisitorModifyVO {
    @JsonProperty("vId")
    private String vId;
    @JsonProperty("vgroupId")
    private String vgroupId;
    private String name;
    private String username;
    private String password;
    private int age;
    private String gender;
    private String md5;
    private Map<String, Object> map;
    private String token;
    private String sessionId;
}
