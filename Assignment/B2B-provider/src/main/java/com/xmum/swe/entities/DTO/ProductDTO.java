package com.xmum.swe.entities.DTO;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

import java.sql.Timestamp;

@Data
public class ProductDTO {

    @JsonProperty("pId")
    private String pId;

    @JsonProperty("pgroupId")
    private String pgroupId;

    @JsonProperty("pName")
    private String pName;

    @JsonProperty("price")
    private float price;

    @JsonProperty("quantityInStock")
    private String quantityInStock;

    @JsonProperty("manufacturer")
    private String manufacturer;

    @JsonProperty("description")
    private String description;

    @JsonProperty("md5")
    private String md5;

    @JsonProperty("status")
    private String status;

    @JsonProperty("pdCreate")
    private Timestamp pdCreate;

    @JsonProperty("pdModified")
    private Timestamp pdModified;

    @JsonProperty("opType")
    private String opType;

    @JsonProperty("token")
    private String token;

    @JsonProperty("sessionId")
    private String sessionId;
}
