package com.fh.shop.admin.util;

import com.fh.shop.admin.commons.SyetemConst;
import org.apache.commons.lang3.StringUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.UUID;

public class DistributeSession {
    public static String getSessionId(HttpServletRequest request, HttpServletResponse response){
        String sessionId = CookieUtil.readCookie(SyetemConst.COOKIE_KEY, request);
        //        //如果为空则生成sessionId
        if (StringUtils.isEmpty(sessionId)){
            //生成sessionId
            sessionId= UUID.randomUUID().toString();
            //写入cookie
            CookieUtil.writeCookie(SyetemConst.COOKIE_KEY,sessionId,SyetemConst.DOMAIN,response);
        }
        return sessionId;
    }
}
