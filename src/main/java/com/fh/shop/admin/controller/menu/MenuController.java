package com.fh.shop.admin.controller.menu;

import com.alibaba.fastjson.JSONObject;
import com.fh.shop.admin.biz.menu.IMenuService;
import com.fh.shop.admin.commons.Log;
import com.fh.shop.admin.commons.ServerRespones;
import com.fh.shop.admin.commons.SyetemConst;
import com.fh.shop.admin.po.menu.Menu;
import com.fh.shop.admin.util.DistributeSession;
import com.fh.shop.admin.util.KeyUtil;
import com.fh.shop.admin.util.RedisUtil;
import com.fh.shop.admin.vo.menu.MenuVo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/menu")
public class MenuController {
    @Resource(name = "menuService")
    private IMenuService menuService;
    @Autowired
    private HttpServletRequest request;
    @Autowired
    private HttpServletResponse response;

    @RequestMapping("/toList")
    public String toMenu(){

        return "menu/list";
    }

    @RequestMapping("/findMenuList")
    @ResponseBody
    public ServerRespones findMenuList(){
            List<MenuVo> list= menuService.findMenuList();
           return ServerRespones.success(list);
    }
    @RequestMapping("/addMenu")
    @ResponseBody
    @Log("新增菜单信息")
    public ServerRespones addMenu(Menu menu){
            menuService.addMenu(menu);
            return ServerRespones.success(menu.getId());
    }
    @RequestMapping("/updateMenu")
    @ResponseBody
    @Log("修改菜单信息")
    public ServerRespones updateMenu(Menu menu){
            menuService.updateMenu(menu);
         return ServerRespones.success();
    }
    @RequestMapping("/deleteMenu")
    @ResponseBody
    @Log("删除菜单信息")
    public ServerRespones deleteMenu(@RequestParam("id[]") List<Long> list){
            menuService.deleteMenu(list);
         return ServerRespones.success();

    }
    //根据用户id获取到menu菜单的信息   从session中取值  因为在user  Cortroller放入session中了
    @RequestMapping("/findUrl")
    @ResponseBody
    public ServerRespones findUrl(){
     // List<Menu> menuList= (List<Menu>) request.getSession().getAttribute(SyetemConst.LOGIN_MENU);
        String sessionId = DistributeSession.getSessionId(request, response);
        String userAllMenu = RedisUtil.get(KeyUtil.buildUserMenuUrlKey(sessionId));
        List<Menu> menuList = JSONObject.parseArray(userAllMenu, Menu.class);
        return ServerRespones.success(menuList);
    }
}
