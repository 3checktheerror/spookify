package com.xmum.swe.entities.BO;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;
import java.sql.Blob;
import java.sql.Timestamp;

@Data
public class VisitorBO {
    @JsonProperty("vId")
    private String vId;
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
    @JsonProperty("file")
    private Blob file;
    @JsonProperty("md5")
    private String md5;
    @JsonProperty("vtCreate")
    private Timestamp vtCreate;
    @JsonProperty("vtModified")
    private Timestamp vtModified;
    @JsonProperty("opType")
    private String opType;
    @JsonProperty("data")
    private String data;
    @JsonProperty("token")
    private String token;
    @JsonProperty("sessionId")
    private String sessionId;
}
