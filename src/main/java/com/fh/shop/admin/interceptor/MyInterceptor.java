package com.fh.shop.admin.interceptor;

import com.alibaba.fastjson.JSONObject;
import com.fh.shop.admin.commons.SyetemConst;
import com.fh.shop.admin.po.user.User;
import com.fh.shop.admin.util.DistributeSession;
import com.fh.shop.admin.util.KeyUtil;
import com.fh.shop.admin.util.RedisUtil;
import org.springframework.web.servlet.DispatcherServlet;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;

public class MyInterceptor extends HandlerInterceptorAdapter {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object o) throws Exception {

        System.out.println("账号密码有才能登陆");
        //HttpSession session = request.getSession();
        //User user = (User) session.getAttribute(SyetemConst.CURRENT_USER);
        String sessionId = DistributeSession.getSessionId(request, response);
        String user = RedisUtil.get(KeyUtil.buildUserDBKey(sessionId));
        if (user != null){
            RedisUtil.expire(KeyUtil.buildUserDBKey(sessionId),SyetemConst.USER_EXPIRE);
            RedisUtil.expire(KeyUtil.buildUserMenuUrlKey(sessionId),SyetemConst.USER_EXPIRE);
            RedisUtil.expire(KeyUtil.buildUserAllMenuKey(sessionId),SyetemConst.USER_EXPIRE);
            RedisUtil.expire(KeyUtil.buildAllMenuListKey(sessionId),SyetemConst.USER_EXPIRE);
            return true;
        }else{
         /*   request.getRequestDispatcher(SyetemConst.LOGIN_URL).forward(request,response);*/
            response.sendRedirect(SyetemConst.LOGIN_URL);
            return  false;
        }

    }

}
