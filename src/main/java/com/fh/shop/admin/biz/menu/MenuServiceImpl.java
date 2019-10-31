package com.fh.shop.admin.biz.menu;

import com.fh.shop.admin.mapper.menu.IMenuMapper;
import com.fh.shop.admin.po.menu.Menu;
import com.fh.shop.admin.vo.menu.MenuVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service("menuService")
public class MenuServiceImpl implements IMenuService {
    @Autowired
    private IMenuMapper menuMapper;

    @Override
    public List<MenuVo> findMenuList() {
        List<Menu> menuList = menuMapper.findMenuList();
        List<MenuVo> menuVoList = getMenuVos(menuList);
        return menuVoList;
    }

    private List<MenuVo> getMenuVos(List<Menu> menuList) {
        List<MenuVo> menuVoList = new ArrayList<>();
        for (Menu menuPo : menuList) {
            MenuVo menuVo = new MenuVo();
            menuVo.setId(menuPo.getId());
            menuVo.setName(menuPo.getMenuName());
            menuVo.setpId(menuPo.getFatherId());
            menuVo.setMenuType(menuPo.getMenuType());
            menuVo.setMenuUrl(menuPo.getMenuUrl());
            menuVoList.add(menuVo);
        }
        return menuVoList;
    }

    @Override
    public void addMenu(Menu menu) {
        menuMapper.addMenu(menu);
    }

    @Override
    public void updateMenu(Menu menu) {
        menuMapper.updateMenu(menu);
    }

    @Override
    public void deleteMenu(List<Long> list) {
        //删除菜单表
        menuMapper.deleteMenu(list);
        //删除中间表 role_menu
        menuMapper.deleteRoleMenu(list);
    }

    @Override
    public List<Menu> findUrl(Long id) {
        List<Menu> listUrl = menuMapper.findUrl(id);
        return listUrl;
    }

    @Override
    public List<Menu> findAllMenu() {
        List<Menu> allMenu = menuMapper.findMenuList();
        return allMenu;

    }

    @Override
    public List<Menu> findMenuTypeOr2(Long id) {

        List<Menu> menuTypeOr2 = menuMapper.findMenuTypeOr2(id);

        return menuTypeOr2;
    }

}
