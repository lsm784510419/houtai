package com.fh.shop.admin.interceptor;

import com.alibaba.fastjson.JSONObject;
import com.fh.shop.admin.commons.SyetemConst;
import com.fh.shop.admin.po.menu.Menu;
import com.fh.shop.admin.util.DistributeSession;
import com.fh.shop.admin.util.KeyUtil;
import com.fh.shop.admin.util.RedisUtil;
import org.apache.commons.lang3.StringUtils;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class MenuInterceptor extends HandlerInterceptorAdapter {


    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        //获取当前请求的相对路径
        String requestURI = request.getRequestURI();
        //对于公共的资源【菜单表里没有的URL都是属于公共资源】，直接放行即可
        //List<Menu> allMenuList = (List<Menu>) request.getSession().getAttribute(SyetemConst.ALL_LOGIN_MENU);
        String sessionId = DistributeSession.getSessionId(request, response);
        String allMenuListJson = RedisUtil.get(KeyUtil.buildAllMenuListKey(sessionId));
        List<Menu> allMenuList = JSONObject.parseArray(allMenuListJson, Menu.class);
        boolean hasAllMenu = false;//设置一个返回状态
        for (Menu allMenu : allMenuList) {
            //非空判断和当前请求路径是否包含查询出来的路径
            if (StringUtils.isNotEmpty(allMenu.getMenuUrl()) && allMenu.getMenuUrl().contains(requestURI)){
                //没有的话直接放行
                hasAllMenu=true;
                break;
            }
        }
        if (!hasAllMenu){
            return true;
        }

        boolean hasMenuPermission = false;
        //查询出用户所有的权限
        //List<Menu> menuTypeList = (List<Menu>) request.getSession().getAttribute(SyetemConst.LOGIN_MENU_TYPE_OR_TWO);
        String menuTypeListJson = RedisUtil.get(KeyUtil.buildUserAllMenuKey(sessionId));
        List<Menu> menuTypeList = JSONObject.parseArray(menuTypeListJson, Menu.class);
        for (Menu userMenu : menuTypeList) {
                if (StringUtils.isNotEmpty(userMenu.getMenuUrl()) && userMenu.getMenuUrl().contains(requestURI)){
                    hasMenuPermission = true;
                    break;
                }
        }
        //到这里就是类型为菜单的  并且没有权限 ，就跳到没有权限页面 如果不等于菜单 就是按钮 并且也是没有权限的
        if (!hasMenuPermission){
            String header = request.getHeader("X-Requested-With");
            if(StringUtils.isNotEmpty(header) && header.equals("XMLHttpRequest")){
                Map result = new HashMap();
                result.put("code",-10000);
                result.put("msg","您没有权限");
                String jsonStr = JSONObject.toJSONString(result);
                outJson(jsonStr,response);
            }else{
                response.sendRedirect(SyetemConst.ERROR_JSP);
            }
        }
        return hasMenuPermission;











              /*//查询出用户拥有的权限
        List<Menu> menuList = (List<Menu>) request.getSession().getAttribute(SyetemConst.LOGIN_MENU);
        //自定义返回状态

        for (Menu menu : menuList) {
            //判断当前请求路径是否包含在菜单中
            if (StringUtils.isNotEmpty(menu.getMenuUrl()) && menu.getMenuUrl().contains(requestURI)){
                hasMenuPermission=true;
                break;
            }
        }
        if (!hasMenuPermission){

            response.sendRedirect(SyetemConst.ERROR_JSP);
        }*/
    }


    private void outJson(String jon,HttpServletResponse response){
        PrintWriter writer = null;
        try {
            response.setContentType("application/json;charset=utf-8");
            writer = response.getWriter();
            writer.write(jon);
            writer.flush();
        } catch (IOException e) {
            e.printStackTrace();
        }finally {
            if (writer != null){
                writer.close();
            }
        }

    }



}
