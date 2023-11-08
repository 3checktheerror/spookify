package com.xmum.swe.entities.VO;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

import java.sql.Blob;
import java.util.Map;

@Data
public class CustomerModifyVO {
    @JsonProperty("cId")
    private String cId;
    @JsonProperty("cgroupId")
    private String cgroupId;
    private String name;
    private int age;
    private String gender;
    private Blob file;
    private String md5;
    private String csType;
    private Map<String, Object> map;
    private String token;
    private String sessionId;
}
