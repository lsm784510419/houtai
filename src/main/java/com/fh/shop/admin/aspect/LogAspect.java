package com.fh.shop.admin.aspect;

import com.alibaba.fastjson.JSONObject;
import com.fh.shop.admin.biz.log.ILogService;
import com.fh.shop.admin.commons.Log;
import com.fh.shop.admin.commons.SyetemConst;
import com.fh.shop.admin.commons.WebConText;
import com.fh.shop.admin.po.log.LogInfo;
import com.fh.shop.admin.po.user.User;
import com.fh.shop.admin.util.DistributeSession;
import com.fh.shop.admin.util.KeyUtil;
import com.fh.shop.admin.util.RedisUtil;
import org.apache.commons.lang3.StringUtils;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.reflect.MethodSignature;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.lang.reflect.Method;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

public class LogAspect {

    private static final Logger LOGGER = LoggerFactory.getLogger(LogAspect.class);

    @Resource(name = "logService")
    private ILogService logService;
    @Autowired
    private HttpServletResponse response;
    public Object doLog(ProceedingJoinPoint pjp){
        Object proceed = null;
        //获取类名
        String className = pjp.getTarget().getClass().getName();
        //获取方法名
        String methodName = pjp.getSignature().getName();
        //获取当前用户信息
        HttpServletRequest request = WebConText.getRequest();
       // User userInfo = (User) request.getSession().getAttribute(SyetemConst.CURRENT_USER);
        String sessionId = DistributeSession.getSessionId(request, response);
        String userInfoJson = RedisUtil.get(KeyUtil.buildUserDBKey(sessionId));
        User userInfo = JSONObject.parseObject(userInfoJson,User.class);
        //当前登陆用户的用户名
        String userName = userInfo.getUserName();
        //获取当前登陆用户的真实姓名
        String realName = userInfo.getRealName();
        //获取相关的参数信息
        Map<String, String[]> parameterMap = request.getParameterMap();
        //迭代器
        Iterator<Map.Entry<String, String[]>> iterator = parameterMap.entrySet().iterator();
        //循环迭代器
        StringBuffer detail = new StringBuffer();
        String substring = null;
        //获取参数信息
        substring = getParameter(iterator, detail, substring);
        //获取自定义注解
        //获取方法签名
        MethodSignature  methodSignature = (MethodSignature) pjp.getSignature();
        //获取方法
        Method method = methodSignature.getMethod();
        //判断方法上面是否有自定义注解
        String value = "";
        if (method.isAnnotationPresent(Log.class)){
            Log annotation = method.getAnnotation(Log.class);
            value = annotation.value();
        }
        try {
          proceed = pjp.proceed();
            LOGGER.info(userName+"执行了"+className+"的"+methodName+"方法成功");
            LogInfo log = new LogInfo();
            log.setUserName(userName);
            log.setRealName(realName);
            log.setCurrDate(new Date());
            log.setInfo("执行了"+className+"的"+methodName+"方法成功");
            log.setStatus(SyetemConst.LOG_STATUS_SUCCESS);
            log.setErrorMsg("");
            log.setDetail(substring);
            log.setContent(value);
            logService.addLog(log);
        } catch (Throwable throwable) {
            throwable.printStackTrace();
            String message = throwable.getMessage();
            LOGGER.error("执行了"+className+"的"+methodName+"方法失败"+message);
            LogInfo log = new LogInfo();
            log.setUserName(userName);
            log.setRealName(realName);
            log.setCurrDate(new Date());
            log.setInfo("执行了"+className+"的"+methodName+"方法失败");
            log.setStatus(SyetemConst.LOG_STATUS_ERROR);
            log.setErrorMsg(message);
            log.setDetail(substring);
            log.setContent(value);
            logService.addLog(log);
            throw new  RuntimeException(throwable);

        }
        return proceed;
    }
    //获取参数信息
    private String getParameter(Iterator<Map.Entry<String, String[]>> iterator, StringBuffer detail, String substring) {
        while (iterator.hasNext()){
            Map.Entry<String, String[]> entry = iterator.next();
            String key = entry.getKey();
            String[] value = entry.getValue();
            substring = detail.append("&").append(key).append("=").append(StringUtils.join(value, ",")).substring(1);
        }
        return substring;
    }

}
