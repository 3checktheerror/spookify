package com.xmum.swe.listener.impl;

import com.xmum.swe.listener.SpookifyEventData;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class SpookifyEventDataImpl implements SpookifyEventData {
    @Override
    public void run(){
        log.info("SpookifyEventDataImpl.run()");
    }
}
