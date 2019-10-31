package com.fh.shop.admin.biz.role;

import com.fh.shop.admin.param.role.RoleMenuParam;
import com.fh.shop.admin.po.role.Role;

import java.util.List;

public interface IRoleService {
    Long findRoleCount();

    List<Role> findRoleList(Role role);

    List<Role> findRole();

    void addRole(Role role, List<Long> list);

    void deleteRole(Long id);

    RoleMenuParam findUpdateRole(Long id);

    void updateRole(Role role,List<Long> list);

}
