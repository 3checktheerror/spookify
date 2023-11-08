package com.xmum.swe.entities.BO;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

import java.sql.Blob;
import java.sql.Timestamp;
import java.util.Map;

@Data
public class ItemNoMapBO {
    @JsonProperty("iId")
    private String iId;
    @JsonProperty("igroupId")
    private String igroupId;
    private String name;
    private String gender;
    private String email;
    private Blob file;
    private String md5;
    private Timestamp itCreate;
    private Timestamp itModified;
    private String opType;
    //private Map<String, Object> map;
    private String token;
    private String sessionId;
    private String status;
    private String vIdFk;
}