package com.xmum.swe.entities.VO;

import lombok.Data;
import java.sql.Blob;
import java.util.Map;

@Data
public class ItemInsertVO {
    private String igroupId;
    private String name;
    private String gender;
    private String email;
    private Blob file;
    private String md5;
    //private Timestamp itCreate;
   // private Timestamp itModified;
//    private String opType;
    private Map<String, Object> map;
    private String token;
    private String sessionId;
    //private String status;
}
