package com.xmum.swe.entities.VO;

import com.fasterxml.jackson.annotation.JsonProperty;
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
    private Map<String, Object> map;
    private String token;
    private String sessionId;
    @JsonProperty("vIdFk")
    private String vIdFk;
}
