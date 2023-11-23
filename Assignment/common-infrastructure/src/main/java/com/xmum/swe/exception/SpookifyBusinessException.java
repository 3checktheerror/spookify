package com.xmum.swe.exception;

import lombok.Setter;

@Setter
public class SpookifyBusinessException extends RuntimeException{
    private String msg;
    public SpookifyBusinessException(String msg){
        super(msg);
        this.msg = msg;
    }
}
