package com.xmum.swe.aop;

import com.xmum.swe.annotation.SpookifyInfo;
import lombok.extern.slf4j.Slf4j;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.*;
import org.aspectj.lang.reflect.MethodSignature;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;


@Order(0)
@Aspect
@Component
@Slf4j
public class ControllerLogWrapper {

    @Pointcut("@annotation(com.xmum.swe.annotation.SpookifyInfo)")
    public void pointCut(){}

    @Before("pointCut()")
    public void before(JoinPoint joinPoint){
        String className = joinPoint.getTarget().getClass().getSimpleName();
        String methodName = joinPoint.getSignature().getName();
        MethodSignature signature = (MethodSignature)joinPoint.getSignature();
        SpookifyInfo spookifyInfo = signature.getMethod().getAnnotation(SpookifyInfo.class);
        if(spookifyInfo.desc().equals("complete")){
            log.info("---Controller: " + className + "#" + methodName + " begin---");
        } else if(spookifyInfo.desc().equals("class")){
            log.info("---Controller: " + className + " begin---");
        } else if (spookifyInfo.desc().equals("method")){
            log.info("---Method: " + methodName + " begin---");
        }

    }

    @After("pointCut()")
    public void after(JoinPoint joinPoint){
        String className = joinPoint.getTarget().getClass().getSimpleName();
        String methodName = joinPoint.getSignature().getName();
        MethodSignature signature = (MethodSignature)joinPoint.getSignature();
        SpookifyInfo spookifyInfo = signature.getMethod().getAnnotation(SpookifyInfo.class);
        if(spookifyInfo.desc().equals("complete")){
            log.info("---Controller: " + className + "#" + methodName + " finish---");
        } else if(spookifyInfo.desc().equals("class")){
            log.info("---Controller: " + className + " finish---");
        } else if (spookifyInfo.desc().equals("method")){
            log.info("---Method: " + methodName + " finish---");
        }
    }

    @AfterThrowing(value = "pointCut()", throwing = "ex")
    public void afterThrow(JoinPoint joinPoint, Exception ex){
        String className = joinPoint.getTarget().getClass().getSimpleName();
        String methodName = joinPoint.getSignature().getName();
        MethodSignature signature = (MethodSignature)joinPoint.getSignature();
        SpookifyInfo spookifyInfo = signature.getMethod().getAnnotation(SpookifyInfo.class);
        if(spookifyInfo.desc().equals("complete")){
            log.info("---Controller: " + className + "#" + methodName + " throw exception: " + ex.getMessage());
        } else if(spookifyInfo.desc().equals("class")){
            log.info("---Controller: " + className + " throw exception: " + ex.getMessage());
        } else if (spookifyInfo.desc().equals("method")){
            log.error("---Method: " + methodName + " throw exception: " + ex.getMessage());
        }
    }
}
