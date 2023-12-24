package com.xmum.swe.entities.DTO;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

import java.sql.Timestamp;

@Data
public class DetailDTO {

    @JsonProperty("dId")
    private String dId;

    @JsonProperty("dgroupId")
    private String dgroupId;

    @JsonProperty("name")
    private String name;

    @JsonProperty("unitPrice")
    private float unitPrice;

    @JsonProperty("quantity")
    private int quantity;

    @JsonProperty("subtotal")
    private float subtotal;

    @JsonProperty("md5")
    private String md5;

    @JsonProperty("dtCreate")
    private Timestamp dtCreate;

    @JsonProperty("dtModified")
    private Timestamp dtModified;

    @JsonProperty("opType")
    private String opType;

    @JsonProperty("token")
    private String token;

    @JsonProperty("sessionId")
    private String sessionId;

    @JsonProperty("oIdFk")
    private String oIdFk;
}