package com.xmum.swe.exception;

public class SpookifyBusinessException extends RuntimeException{
    private String msg;
    public SpookifyBusinessException(String msg){
        super(msg);
        this.msg = msg;
    }
}
