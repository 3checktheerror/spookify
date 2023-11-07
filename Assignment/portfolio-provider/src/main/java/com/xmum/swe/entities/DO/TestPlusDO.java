package com.xmum.swe.entities.DO;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.apache.ibatis.type.JdbcType;

@Data
@AllArgsConstructor
@NoArgsConstructor
@TableName(value = "t_testPlus")
public class TestPlusDO{
    @TableId(value = "number")
    private Integer number;
    @TableField(value = "user_name", jdbcType = JdbcType.VARCHAR)
    private String userName;
}
