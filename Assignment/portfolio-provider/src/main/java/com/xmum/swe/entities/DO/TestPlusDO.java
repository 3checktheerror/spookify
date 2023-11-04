package com.xmum.swe.entities.DO;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@TableName(value = "t_testPlus")
public class TestPlusDO{
    @TableId(value = "number")
    private int number;
    private String user_name;
}
