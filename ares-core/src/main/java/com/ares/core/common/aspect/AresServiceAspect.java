package com.ares.core.common.aspect;

import lombok.extern.slf4j.Slf4j;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.*;
import org.springframework.stereotype.Component;

/**
 * @description:
 * @author: Young
 * @date: 2023/2/24
 * @see: com.ares.core.common.aspect.AresServiceAspect.java
 **/
@Slf4j
@Aspect
@Component
public class AresServiceAspect {

    @Pointcut("execution(* com.ares.*.*.service.*.*(..))")
    public void servicePointcut(){}

    @Before(value = "servicePointcut()")
    public void before(JoinPoint joinPoint){
        String name = joinPoint.getSignature().getName();
        log.debug(name+"方法开始执行...");
    }

    @After(value = "servicePointcut()")
    public void after(JoinPoint joinPoint){
        String name = joinPoint.getSignature().getName();
        log.debug(name+"方法开始执行结束...");
    }

    @AfterReturning(value = "servicePointcut()",returning = "result")
    public void before(JoinPoint joinPoint,Object result){
        String name = joinPoint.getSignature().getName();
        log.debug(name+"方法返回值为:"+result);
    }

    @AfterThrowing(value = "servicePointcut()",throwing = "e")
    public void before(JoinPoint joinPoint,Exception e){
        String name = joinPoint.getSignature().getName();
        log.debug(name+"方法出错，异常是:"+e.getMessage());
    }

    @Around(value = "servicePointcut()")
    public Object around(ProceedingJoinPoint pjp) throws Throwable {
        String name = pjp.getSignature().getName();
        long start = System.currentTimeMillis();
        Object proceed = pjp.proceed();
        long end = System.currentTimeMillis();
        log.debug(name+"方法执行时间为:"+(end-start)+"ms");
        return proceed;
    }

}
