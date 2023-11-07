package com.xmum.swe.entities.VO;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;
import java.sql.Blob;
import java.util.Map;

@Data
public class ItemModifyVO {
    @JsonProperty("iId")
    private String iId;
    private String igroupId;
    private String name;
    private String gender;
    private String email;
    private Blob file;
    private Map<String, Object> map;
}
