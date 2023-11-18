package com.xmum.swe.entities.BO;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;
import java.sql.Blob;
import java.sql.Timestamp;

@Data
public class ItemBO {

    @JsonProperty("iId")
    private String iId;

    @JsonProperty("igroupId")
    private String igroupId;

    @JsonProperty("name")
    private String name;

    @JsonProperty("gender")
    private String gender;

    @JsonProperty("email")
    private String email;

    @JsonProperty("file")
    private byte[] file;

    @JsonProperty("md5")
    private String md5;

    @JsonProperty("itCreate")
    private Timestamp itCreate;

    @JsonProperty("itModified")
    private Timestamp itModified;

    @JsonProperty("opType")
    private String opType;

    @JsonProperty("data")
    private String data;

    @JsonProperty("token")
    private String token;

    @JsonProperty("sessionId")
    private String sessionId;

    @JsonProperty("status")
    private String status;

    @JsonProperty("vIdFk")
    private String vIdFk;

    @JsonProperty("fileName")
    private String fileName;
}
