package com.fh.shop.admin.controller.Type;

import com.fh.shop.admin.biz.type.ITypeService;
import com.fh.shop.admin.commons.Log;
import com.fh.shop.admin.commons.ServerRespones;
import com.fh.shop.admin.po.type.Type;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;

@Controller
@RequestMapping("/type")
public class TypeController {
    @Resource(name="typeService")
    private ITypeService typeService;
    @RequestMapping("/toList")
    public String toList(){

        return "type/list";
    }
    @RequestMapping("/findTypeList")
    @ResponseBody
    public ServerRespones findTypeList(){
        return typeService.findTypeList();
    }

    @RequestMapping("/addType")
    @ResponseBody
    @Log("新增商品类型")
    public ServerRespones addType(Type type){
        return typeService.addType(type);
    }

    @RequestMapping("/deleteType")
    @ResponseBody
    @Log("删除商品类型")
    public ServerRespones deleteType(@RequestParam("ids[]") List<Long> ids){
        return typeService.deleteType(ids);
    }

    @RequestMapping("/updateType")
    @ResponseBody
    @Log("修改商品类型")
    public ServerRespones updateType(Type type){
        return typeService.updateType(type);
    }

    @RequestMapping("/findTypeAll")
    @ResponseBody
    public ServerRespones findPidByName(Long id){
        return typeService.findPidByName(id);
    }
}
