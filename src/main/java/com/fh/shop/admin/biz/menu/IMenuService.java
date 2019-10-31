package com.fh.shop.admin.biz.menu;

import com.fh.shop.admin.po.menu.Menu;
import com.fh.shop.admin.vo.menu.MenuVo;

import java.util.List;

public interface IMenuService {


    List<MenuVo> findMenuList();

    void addMenu(Menu menu);

    void updateMenu(Menu menu);

    void deleteMenu(List<Long> list);

    List<Menu> findUrl(Long id);

    List<Menu> findAllMenu();

    List<Menu> findMenuTypeOr2(Long id);
}
