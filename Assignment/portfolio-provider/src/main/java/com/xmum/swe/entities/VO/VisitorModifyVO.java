package com.xmum.swe.entities.VO;

import com.fasterxml.jackson.annotation.JsonProperty;

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
    private String data;
    private String token;
    private String sessionId;
}
