package com.xmum.swe.utils;

import java.util.HashMap;
import java.util.Map;

public class MapUtil {
    public static Map<String, Object> merge(Map<String, Object> m1, Map<String, Object> m2){
        Map<String, Object> mergeResult = new HashMap<>(m1);
        m2.forEach((key, value) -> mergeResult.merge(key, value, (v1, v2) -> v2));//lambda：相同就用m2的值
        return mergeResult;
    }
}
