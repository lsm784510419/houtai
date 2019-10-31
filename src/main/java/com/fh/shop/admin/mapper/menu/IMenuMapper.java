package com.fh.shop.admin.mapper.menu;

import com.fh.shop.admin.po.menu.Menu;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface IMenuMapper {
    List<Menu> findMenuList();

    void addMenu(Menu menu);

    void updateMenu(Menu menu);

    void deleteMenu(List<Long> list);

    List<Menu> findUrl(Long id);

    void deleteRoleMenu(List<Long> list);

    List<Menu> findMenuTypeOr2(Long id);
}

