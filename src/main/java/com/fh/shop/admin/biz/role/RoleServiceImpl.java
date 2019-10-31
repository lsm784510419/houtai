package com.fh.shop.admin.biz.role;

import com.fh.shop.admin.mapper.role.IRoleMapper;
import com.fh.shop.admin.param.role.RoleMenuParam;
import com.fh.shop.admin.po.RoleMenu;
import com.fh.shop.admin.po.role.Role;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service("roleService")
public class RoleServiceImpl implements IRoleService {
    @Autowired
    private IRoleMapper roleMapper;

    @Override
    public Long findRoleCount() {
        Long roleCount = roleMapper.findRoleCount();
        return roleCount;
    }

    @Override
    public List<Role> findRoleList(Role role) {
        List<Role> roleList = roleMapper.findRoleList(role);
        return roleList;
    }

    @Override
    public List<Role> findRole() {
        List<Role> role = roleMapper.findRole();

        return role;
    }

    @Override
    public void addRole(Role role, List<Long> list) {
        //新增角色表
        roleMapper.addRole(role);
        //新增中间表
        addRoleMenu(role, list);

    }

    private void addRoleMenu(Role role, List<Long> list) {
        List<RoleMenu> roleMenuList = new ArrayList<>();
        for (Long menuIds : list) {
            RoleMenu roleMenu = new RoleMenu();
            roleMenu.setRoleId(role.getId());
            roleMenu.setMenuId(menuIds);
            roleMenuList.add(roleMenu);
        }
        roleMapper.addRoleMenu(roleMenuList);
    }

    @Override
    public void deleteRole(Long id) {
        //删除角色
        roleMapper.deleteRole(id);
        //删除角色菜单中间表
        roleMapper.deleteRoleMenu(id);
        //删除用户角色中间表
        roleMapper.deleteUserRole(id);
    }

    @Override
    public RoleMenuParam findUpdateRole(Long id) {
        //查询角色的信息
        Role role = roleMapper.findUpdateRole(id);
        //查询中间表的信息
        List<Long> menuIds = roleMapper.findUpdateRoleMenu(id);
        RoleMenuParam roleMenuParam = new RoleMenuParam();
        roleMenuParam.setId(role.getId());
        roleMenuParam.setRoleName(role.getRoleName());
        roleMenuParam.setList(menuIds);

        return roleMenuParam;

    }

    @Override
    public void updateRole(Role role, List<Long> list) {
        //修改角色名
        roleMapper.updateRole(role);
        //修改角色菜单中间表   先删除后修改
        //删除中间表的数据
        Long id = role.getId();
        roleMapper.deleteRoleMenu(id);
        //增加
        System.out.println(list.get(0));
        if (list.get(0) != -1) {
            addRoleMenu(role, list);
        }
    }
}
