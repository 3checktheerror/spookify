package com.xmum.swe;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication(scanBasePackages = "com.xmum.swe")
public class PortforlioServer {
    public static void main(String[] args) {
        SpringApplication.run(PortforlioServer.class, args);
        System.out.println("--------starting success---------");
    }
}
