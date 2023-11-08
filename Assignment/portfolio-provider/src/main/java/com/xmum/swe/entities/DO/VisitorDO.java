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
@TableName(value = "contact_visitor_1")
public class VisitorDO {
    @TableId("v_id")
    private String vId;
    private String vgroupId;
    private String name;
    private String username;
    private String password;
    private int age;
    private String gender;
    private Blob file;
    private String md5;
    private Timestamp vtCreate;
    private Timestamp vtModified;
    private String opType;
    private String data;
    private String token;
    private String sessionId;
}
