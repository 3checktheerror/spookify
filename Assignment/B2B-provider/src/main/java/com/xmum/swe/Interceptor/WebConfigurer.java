package com.xmum.swe.Interceptor;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

/**
 * 注册拦截器
 */
@Configuration
public class WebConfigurer implements WebMvcConfigurer {

    @Resource
    private LoginInterceptor loginHandlerInterceptor;

//    @Override
//    public void addInterceptors(InterceptorRegistry registry) {
//        InterceptorRegistration ir = registry.addInterceptor(loginHandlerInterceptor);
//        // 拦截路径
////        ir.addPathPatterns("/*");
//        // 不拦截路径
//        List<String> irs = new ArrayList<String>();
////        irs.add("/api/*");
////        irs.add("/wechat/*");
////        irs.add("/oauth");
//        ir.excludePathPatterns(irs);
//    }
}
