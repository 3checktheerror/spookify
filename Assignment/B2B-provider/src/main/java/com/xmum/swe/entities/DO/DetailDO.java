package com.xmum.swe.entities.DO;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.apache.ibatis.type.BlobTypeHandler;

import java.sql.Timestamp;

@Data
@AllArgsConstructor
@NoArgsConstructor
@TableName(value = "B2B_detail_1")
public class DetailDO {

    @TableId("d_id")
    private String dId;

    private String dgroupId;

    private String name;

    private float unitPrice;

    private int quantity;

    private float subtotal;

    private String md5;

    private Timestamp dtCreate;

    private Timestamp dtModified;

    private String opType;

    private String data;

    private String token;

    private String sessionId;

    @TableField("o_id_fk")
    private String oIdFk;
}
