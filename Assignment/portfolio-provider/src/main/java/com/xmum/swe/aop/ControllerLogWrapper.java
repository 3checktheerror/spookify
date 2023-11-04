package com.xmum.swe.aop;

import lombok.extern.slf4j.Slf4j;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.*;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;


@Order(0)
@Aspect
@Component
@Slf4j
public class ControllerLogWrapper {
    @Pointcut("execution(public * com.xmum.swe.controller..*(..))")
    public void pointCut(){}

    @Before("pointCut()")
    public void before(JoinPoint joinPoint){
        String className = joinPoint.getTarget().getClass().getSimpleName();
        String methodName = joinPoint.getSignature().getName();
        log.info("---Controller: " + className + "#" + methodName + " begin---");
    }

    @After("pointCut()")
    public void after(JoinPoint joinPoint){
        String className = joinPoint.getTarget().getClass().getSimpleName();
        String methodName = joinPoint.getSignature().getName();
        log.info("---Controller: " + className + "#" + methodName + " finish---");
    }

    @AfterThrowing(value = "pointCut()", throwing = "ex")
    public void afterThrow(JoinPoint joinPoint, Exception ex){
        String className = joinPoint.getTarget().getClass().getSimpleName();
        String methodName = joinPoint.getSignature().getName();
        log.error("---Controller: " + className + "#" + methodName + " throw exception: " + ex.getMessage());
    }
}
