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
@TableName(value = "B2B_customer_1")
public class CustomerDO {

    @TableId("c_id")
    private String cId;

    private String cgroupId;

    private String name;

    private String password;

    private int age;

    private String gender;

    private String md5;

    private Timestamp csCreate;

    private Timestamp csModified;

//    private String csType;

    private String data;

    private String token;

    private String sessionId;
}
