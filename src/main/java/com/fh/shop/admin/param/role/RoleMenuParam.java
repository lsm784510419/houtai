package com.fh.shop.admin.param.role;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class RoleMenuParam implements Serializable {

    private Long id;

    private String roleName;

    private List<Long> list = new ArrayList<>();

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }

    public List<Long> getList() {
        return list;
    }

    public void setList(List<Long> list) {
        this.list = list;
    }
}
