package com.fh.shop.admin.controller.role;

import com.fh.shop.admin.biz.role.IRoleService;
import com.fh.shop.admin.commons.Datetables;
import com.fh.shop.admin.commons.Log;
import com.fh.shop.admin.commons.ServerRespones;
import com.fh.shop.admin.param.role.RoleMenuParam;
import com.fh.shop.admin.po.role.Role;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("role")
public class RoleController {

    @Resource(name = "roleService")
    private IRoleService roleService;

    @RequestMapping("/toList")
    public String toList(){

        return "role/list";
    }
    @RequestMapping("/findRoleList")
    @ResponseBody
    public Datetables findRoleList(Role role){
        Long count= roleService.findRoleCount();
        List<Role> roleList= roleService.findRoleList(role);
        Datetables datetables = new Datetables(role.getDraw(),count,count,roleList);

        return datetables;
    }
    @RequestMapping("/findRole")
    @ResponseBody
    public ServerRespones findRole(){
            List<Role> roleList= roleService.findRole();
            return ServerRespones.success(roleList);
    }

    @RequestMapping("addRole")
    @ResponseBody
    @Log("新增角色信息")
    public ServerRespones addRole(Role role, @RequestParam("menuIds[]") List<Long> list){
            roleService.addRole(role,list);
           return ServerRespones.success();
    }
    @RequestMapping("deleteRole")
    @ResponseBody
    @Log("删除角色信息")
    public ServerRespones deleteRole(Long id){
            roleService.deleteRole(id);
           return ServerRespones.success();
    }
    @RequestMapping("findUpdateRole")
    @ResponseBody
    public ServerRespones findUpdateRole(Long id){
            RoleMenuParam roleMenuParam =roleService.findUpdateRole(id);
            return ServerRespones.success(roleMenuParam);
    }
    @RequestMapping("updateRole")
    @ResponseBody
    @Log("修改角色信息")
    public ServerRespones updateRole(Role role,@RequestParam("menuIds[]") List<Long> list){
            roleService.updateRole(role,list);
            return ServerRespones.success();
    }

}
