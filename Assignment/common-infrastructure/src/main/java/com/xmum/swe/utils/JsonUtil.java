package com.xmum.swe.utils;

import com.alibaba.fastjson2.JSONObject;

public class JsonUtil{

    public static void merge(JSONObject target, JSONObject source) {
        for (String key : source.keySet()) {
            Object sourceValue = source.get(key);

            if (sourceValue != null && !sourceValue.toString().isEmpty()) {
                target.put(key, sourceValue);
            }
        }
    }
}