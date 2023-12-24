package com.xmum.swe.entities.BO;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;
import java.sql.Blob;
import java.sql.Timestamp;

@Data
public class ProductBO {

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

    @JsonProperty("data")
    private String data;

    @JsonProperty("token")
    private String token;

    @JsonProperty("sessionId")
    private String sessionId;
}
