package com.xmum.swe.entities;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CommonResult<T> {

    private Integer code;
    private String message;
    private T data;

    public CommonResult(Integer code, String message) {
        this(code, message, null);
    }

    public static <T> CommonResult ok(T data){
        return new CommonResult(200, "http-ok", data);
    }

    public static <T> CommonResult fail(T data){
        return new CommonResult(500, "internal-error", data);
    }
}