package com.xmum.swe.entities.DO;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.sql.Blob;
import java.sql.Timestamp;

@Data
@AllArgsConstructor
@NoArgsConstructor
@TableName(value = "B2B_product_1")
public class ProductDO {

    @TableId("p_id")
    private String pId;

    @TableField("pgroup_id")
    private String pgroupId;

    private String pName;

    private float price;

    @TableField("quantity_in_stock")
    private String quantityInStock;

    private String category;

    private String manufacturer;

    private String description;

    private String md5;

    private String status;

    private Timestamp pdCreate;

    private Timestamp pdModified;

    private String opType;

    private String data;

    private String token;

    private String sessionId;
}
