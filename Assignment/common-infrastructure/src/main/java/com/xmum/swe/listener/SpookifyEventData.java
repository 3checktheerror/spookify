package com.xmum.swe.listener;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.extern.slf4j.Slf4j;


public interface SpookifyEventData {
   default void run(){
      throw new RuntimeException("No implementation of SpookifyEventData found");
   }
}
