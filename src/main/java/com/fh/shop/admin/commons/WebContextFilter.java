package com.fh.shop.admin.commons;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

public class WebContextFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        //调用工具类的set方法放入当前线程的request
        WebConText.setRequest((HttpServletRequest) servletRequest);
        try {
            //方法继续执行
            filterChain.doFilter(servletRequest,servletResponse);
        }finally {
            //释放资源
            WebConText.remove();
        }
    }

    @Override
    public void destroy() {

    }
}
