package com.xmum.swe.entities.BO;

import lombok.Data;

import java.sql.Blob;
import java.sql.Timestamp;
import java.util.Map;

@Data
public class ItemNoMapBO {
    private String iId;
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
}