package com.xmum.swe.entities.DO;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Blob;
import java.sql.Timestamp;

@Data
@AllArgsConstructor
@NoArgsConstructor
@TableName(value = "B2B_order_1")
public class OrderDO {

    @TableId("o_id")
    private String oId;

    private String ogroupId;

    private String customerId;

    private float balance;

    private String payName;

    private String cardNumber;

    private String address;

    private String shippingMethod;

    private float productPrice;

    private float tax;

    private float shippingFee;

    private float totalAmount;

    private float discountAmount;

    private float actualAmount;

    private String paymentStatus;

    private String md5;

    private Timestamp odCreate;

    private Timestamp odModified;

    private String opType;

    private String data;

    private String token;

    private String sessionId;
}
