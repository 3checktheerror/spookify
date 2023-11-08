package com.xmum.swe.entities.BO;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

import java.sql.Blob;
import java.sql.Timestamp;

@Data
public class VisitorNoMapBO {
    @JsonProperty("vId")
    private String vId;
    @JsonProperty("vgroupId")
    private String vgroupId;
    private String name;
    private String username;
    private String password;
    private int age;
    private String gender;
    private Blob file;
    private String md5;
    private Timestamp vtCreate;
    private Timestamp vtModified;
    private String opType;
    private String token;
    private String sessionId;
}
