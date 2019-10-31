package com.fh.shop.admin.util;

public class KeyUtil {
    public static String buildCodeKey(String sessionId){

        return "code:"+sessionId;
    }
    public static String buildUserDBKey(String sessionId){

        return "userDB:"+sessionId;
    }
    public static String buildUserAllMenuKey(String sessionId){

        return "userAllMenu:"+sessionId;
    }
    public static String buildUserMenuUrlKey(String sessionId){

        return "userMenuUrl:"+sessionId;
    }
    public static String buildAllMenuListKey(String sessionId){

        return "AllMenuList:"+sessionId;
    }
}