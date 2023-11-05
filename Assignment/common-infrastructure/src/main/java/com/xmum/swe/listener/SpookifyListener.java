package com.xmum.swe.listener;

import lombok.extern.slf4j.Slf4j;
import org.springframework.context.ApplicationListener;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;

@Component
@Slf4j
public class SpookifyListener implements ApplicationListener<SpooifyEvent> {
    @Async
    @Override
    public void onApplicationEvent(SpooifyEvent event) {
        log.info("---SpookifyListener starts working---");
        SpookifyEventData eventData = event.getEventData();
        eventData.run();
    }
}
