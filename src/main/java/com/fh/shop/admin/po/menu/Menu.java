package com.fh.shop.admin.po.menu;

import java.io.Serializable;
import java.util.List;

public class Menu implements Serializable {

    private Long id;

    private String menuName;

    private Long fatherId;

    private Integer menuType;

    private String menuUrl;

    private List<Menu> buttons;

    public List<Menu> getButtons() {
        return buttons;
    }

    public void setButtons(List<Menu> buttons) {
        this.buttons = buttons;
    }

    public Integer getMenuType() {
        return menuType;
    }

    public void setMenuType(Integer menuType) {
        this.menuType = menuType;
    }

    public String getMenuUrl() {
        return menuUrl;
    }

    public void setMenuUrl(String menuUrl) {
        this.menuUrl = menuUrl;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getMenuName() {
        return menuName;
    }

    public void setMenuName(String menuName) {
        this.menuName = menuName;
    }

    public Long getFatherId() {
        return fatherId;
    }

    public void setFatherId(Long fatherId) {
        this.fatherId = fatherId;
    }

}
