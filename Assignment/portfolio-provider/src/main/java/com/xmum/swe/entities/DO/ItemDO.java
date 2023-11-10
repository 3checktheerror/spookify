package com.xmum.swe.entities.DO;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.apache.ibatis.type.BlobTypeHandler;

import java.sql.Blob;
import java.sql.Timestamp;

@Data
@AllArgsConstructor
@NoArgsConstructor
@TableName(value = "contact_item_1")
public class ItemDO {

    @TableId("i_id")
    private String iId;

    private String igroupId;

    private String name;

    private String gender;

    private String email;

    @TableField(typeHandler = BlobTypeHandler.class)
    private byte[] file;

    private String md5;

    private Timestamp itCreate;

    private Timestamp itModified;

    private String opType;

    private String data;

    private String token;

    private String sessionId;

    private String status;

    private String vIdFk;
}
