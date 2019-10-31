package com.fh.shop.admin.util;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CookieUtil {

    public static void writeCookie(String name, String value, String domain , HttpServletResponse response){
        //创建cookie对象
        Cookie cookie = new Cookie(name,value);
        //设置域名
        cookie.setDomain(domain);
        //设置路径  死的  都是/
        cookie.setPath("/");
        //写入到cookie中
        response.addCookie(cookie);

    }

    public static String readCookie(String name,HttpServletRequest request){
        //获取所有cookie
        Cookie[] cookies = request.getCookies();
        //如果为空，则证明cook是空的，直接返回空字符串
        if (null == cookies){
            return "";
        }
        for (Cookie cookie : cookies) {
            //如果不为空， 则获取到cookie的key与我们定义的key进行比较 相等就返回值
           if (cookie.getName().equals(name)){
                return cookie.getValue();
           }
        }
            return "";
    }
}
