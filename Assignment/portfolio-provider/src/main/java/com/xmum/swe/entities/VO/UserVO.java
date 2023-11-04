package com.xmum.swe.entities.VO;

import lombok.AllArgsConstructor;
import lombok.Data;
import java.io.Serializable;

@Data
@AllArgsConstructor
public class UserVO implements Serializable {
    private String name;
    private int age;
}
