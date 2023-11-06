package com.xmum.swe.listener;

import lombok.extern.slf4j.Slf4j;
import org.springframework.context.ApplicationEvent;
import org.springframework.context.ApplicationListener;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;

@Component
@Slf4j
public class SpookifyListener implements ApplicationListener<ApplicationEvent> {
    @Async
    @Override
    public void onApplicationEvent(ApplicationEvent event) {

        log.info("---SpookifyListener starts working---");
        if(event instanceof SpooifyEvent){  //to ensure other events are not captured
            SpookifyEventData eventData = ((SpooifyEvent) event).getEventData();
            eventData.run();
        }
    }
}
