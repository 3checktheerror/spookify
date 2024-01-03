package com.xmum.swe.entities.VO;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

import java.util.Map;

@Data
public class DetailGroupUpdateVO {
    @JsonProperty("map")
    private Map<String, Object> map;

}
