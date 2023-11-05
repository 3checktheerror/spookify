package com.xmum.swe.entities.VO;

import com.alibaba.fastjson2.annotation.JSONField;
import lombok.AllArgsConstructor;
import lombok.Data;
import java.io.Serializable;

@Data
@AllArgsConstructor
public class UserVO implements Serializable {
   // @JSONField("")
    private String name;
    private int number;
}
