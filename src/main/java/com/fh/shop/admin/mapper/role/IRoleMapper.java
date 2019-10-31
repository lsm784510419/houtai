package com.fh.shop.admin.mapper.role;

import com.fh.shop.admin.param.role.RoleMenuParam;
import com.fh.shop.admin.po.RoleMenu;
import com.fh.shop.admin.po.role.Role;

import java.util.List;

public interface IRoleMapper {
    List<Role> findRoleList(Role role);

    Long findRoleCount();

    List<Role> findRole();

    void addRole(Role role);

    void deleteRole(Long id);

    Role findUpdateRole(Long id);

    void updateRole(Role role);

    void addRoleMenu(List<RoleMenu> roleMenuList);


    List<Long> findUpdateRoleMenu(Long id);


    void deleteRoleMenu(Long id);

    void deleteUserRole(Long id);
}
