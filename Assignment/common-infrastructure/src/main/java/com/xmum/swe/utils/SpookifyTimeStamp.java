package com.xmum.swe.utils;

import java.sql.Timestamp;
import java.time.ZoneId;
import java.time.ZonedDateTime;

public class SpookifyTimeStamp {
    private static volatile SpookifyTimeStamp instance;

    private SpookifyTimeStamp(){}

    public static SpookifyTimeStamp getInstance() { // Double check lock(DCL)
        if (instance == null) {
            synchronized (SpookifyTimeStamp.class) {
                if (instance == null) {
                    instance = new SpookifyTimeStamp();
                }
            }
        }
        return instance;
    }

    public Timestamp getTimeStamp() {
        ZonedDateTime zonedDateTime = ZonedDateTime.now(ZoneId.systemDefault());
        return Timestamp.from(zonedDateTime.toInstant());
    }
}
