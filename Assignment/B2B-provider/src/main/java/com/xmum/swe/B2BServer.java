package com.xmum.swe;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableAsync;

//@EnableDiscoveryClient
@SpringBootApplication(scanBasePackages = "com.xmum.swe")
@EnableAsync
public class B2BServer {
    public static void main(String[] args) {
        SpringApplication.run(B2BServer.class, args);
        System.out.println("--------starting success---------");
    }
}
