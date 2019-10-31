package com.fh.shop.admin.controller.area;

import com.fh.shop.admin.biz.area.IAreaService;
import com.fh.shop.admin.commons.Log;
import com.fh.shop.admin.commons.ServerRespones;
import com.fh.shop.admin.po.area.Area;
import com.fh.shop.admin.vo.area.AreaVo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;

@Controller
@RequestMapping("/area")
public class AreaController {

    @Resource(name = "areaService")
    private IAreaService areaService;

    @RequestMapping("/toList")
    public String toList(){

        return "area/list";
    }
    @RequestMapping("/findAreaList")
    @ResponseBody
    public ServerRespones findAreaList(){
            List<AreaVo> list= areaService.findAreaList();
            return ServerRespones.success(list);
    }
    @RequestMapping("/addArea")
    @ResponseBody
    @Log("新增地区信息")
    public ServerRespones addArea(Area area){
            areaService.addArea(area);
            return ServerRespones.success(area.getId());
    }
    @RequestMapping("/updateArea")
    @ResponseBody
    @Log("修改地区信息")
    public ServerRespones updateArea(Area area){
            areaService.updateArea(area);
            return ServerRespones.success();
    }
    @RequestMapping("/deleteArea")
    @ResponseBody
    @Log("删除地区信息")
    public ServerRespones deleteArea(@RequestParam("ids[]") List<Long> list){
            areaService.deleteArea(list);
            return ServerRespones.success();
    }
    //三级联动所需要查询
    @RequestMapping("/findAreaSelect")
    @ResponseBody
    public ServerRespones findAreaSelect(Long id){

        return areaService.findAreaSelect(id);
    }
}
