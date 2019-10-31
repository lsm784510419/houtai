package com.fh.shop.admin.aspect;

import org.aspectj.lang.ProceedingJoinPoint;

public class AopAspect {

    public Object doAop(ProceedingJoinPoint pjp){
        Object proceed=null;
        try {
            proceed = pjp.proceed();
            System.out.println("==================方法执行成功");
        } catch (Throwable throwable) {
            throwable.printStackTrace();

        }

        return proceed;
    }
}
