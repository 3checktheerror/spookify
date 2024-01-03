package com.xmum.swe.entities.BO;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

import java.sql.Blob;
import java.sql.Timestamp;

@Data
public class CustomerBO {

    @JsonProperty("cId")
    private String cId;

    @JsonProperty("cgroupId")
    private String cgroupId;

    @JsonProperty("name")
    private String name;

    @JsonProperty("age")
    private int age;

    @JsonProperty("gender")
    private String gender;

    @JsonProperty("md5")
    private String md5;

    @JsonProperty("csCreate")
    private Timestamp csCreate;

    @JsonProperty("csModified")
    private Timestamp csModified;

    @JsonProperty("csType")
    private String csType;

    @JsonProperty("data")
    private String data;

    @JsonProperty("token")
    private String token;

    @JsonProperty("sessionId")
    private String sessionId;
}
