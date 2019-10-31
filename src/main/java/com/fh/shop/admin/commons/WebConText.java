package com.fh.shop.admin.commons;

import javax.servlet.http.HttpServletRequest;

public class WebConText {

    private static ThreadLocal<HttpServletRequest> requestThreadLocal = new ThreadLocal<>();

    public static void setRequest(HttpServletRequest request){

        requestThreadLocal.set(request);
    }
    public static HttpServletRequest getRequest(){

        return requestThreadLocal.get();
    }
    public static void remove(){
        requestThreadLocal.remove();
    }
}
