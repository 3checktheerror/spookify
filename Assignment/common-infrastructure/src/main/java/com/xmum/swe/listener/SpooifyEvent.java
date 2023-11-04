package com.xmum.swe.listener;


import lombok.*;
import org.springframework.context.ApplicationEvent;


@Getter
public class SpooifyEvent extends ApplicationEvent {
    private final SpookifyEventData eventData;
    public SpooifyEvent(Object source, SpookifyEventData eventData) {
        super(source);
        this.eventData = eventData;
    }
}
