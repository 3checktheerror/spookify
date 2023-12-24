package com.xmum.swe.entities.VO;

import com.fasterxml.jackson.annotation.JsonProperty;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.sql.Blob;
import java.sql.Timestamp;
import java.util.Map;

@Data
@ApiModel("Params for order modification")
public class OrderModifyVO {
    @JsonProperty("oId")
    private String oId;

    @JsonProperty("ogroupId")
    private String ogroupId;

    @JsonProperty("customerId")
    private String customerId;

    @JsonProperty("balance")
    private float balance;

    @JsonProperty("payName")
    private String payName;

    @JsonProperty("cardNumber")
    private String cardNumber;

    @JsonProperty("address")
    private String address;

    @JsonProperty("shippingMethod")
    private String shippingMethod;

    @JsonProperty("productPrice")
    private float productPrice;

    @JsonProperty("tax")
    private float tax;

    @JsonProperty("shippingFee")
    private float shippingFee;

    @JsonProperty("totalAmount")
    private float totalAmount;

    @JsonProperty("discountAmount")
    private float discountAmount;

    @JsonProperty("actualAmount")
    private float actualAmount;

    @JsonProperty("paymentStatus")
    private String paymentStatus;

    @JsonProperty("md5")
    private String md5;

    @JsonProperty("odCreate")
    private Timestamp odCreate;

    @JsonProperty("odModified")
    private Timestamp odModified;

    @JsonProperty("opType")
    private String opType;

//  @JsonProperty("data")
//  private String data;
    @ApiModelProperty("additional params")
    @JsonProperty("map")
    private Map<String, Object> map;

    @JsonProperty("token")
    private String token;

    @JsonProperty("sessionId")
    private String sessionId;
}
