package com.fh.shop.admin.controller.brand;

import com.fh.shop.admin.biz.brand.IBrandService;
import com.fh.shop.admin.commons.Datetables;
import com.fh.shop.admin.commons.Log;
import com.fh.shop.admin.commons.ServerRespones;
import com.fh.shop.admin.po.brand.Brand;
import com.fh.shop.admin.util.FileInputUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("brand")
public class BrandController {
    @Resource(name = "brandService")
    private IBrandService brandService;

    @RequestMapping("/toList")
    public String toList(){

        return "brand/list";
    }
    @RequestMapping("/findPageBrandList")
    @ResponseBody
    public Datetables findPageBrandList(Brand brand){
       Long count= brandService.findBrandCount();
       List<Brand> brandList= brandService.findPageBrandList(brand);
       Datetables datetables = new Datetables(brand.getDraw(),count,count,brandList);
        return datetables;
    }

    /*新增方法*/
    @RequestMapping("/addBrand")
    @ResponseBody
    @Log("新增品牌信息")
    public ServerRespones addBrand(Brand brand){
            brandService.addBrand(brand);
           return ServerRespones.success();
    }
  /*  @RequestMapping("/addFileInput")
    @ResponseBody
    @Log("新增品牌图片信息")
    public Map addFileInput(@RequestParam("files") CommonsMultipartFile file){
        Map map = FileInputUtil.fileInput(file);
        return map;
    }*/
    @RequestMapping("/deleteBrand")
    @ResponseBody
    @Log("删除品牌信息")
    public ServerRespones deleteBrand(int id,String ossBrandImg){

            brandService.deleteBrand(id,ossBrandImg);
           return ServerRespones.success();
    }
    @RequestMapping("/findUpdateBrand")
    @ResponseBody
    public ServerRespones findUpdateBrand(int id){
            Brand brand= brandService.findUpdateBrand(id);
            return ServerRespones.success(brand);
    }
    @RequestMapping("updateBrand")
    @ResponseBody
    @Log("修改品牌信息")
    public ServerRespones updateBrand(Brand brand){
            brandService.updateBrand(brand);
            return ServerRespones.success();
    }

    @RequestMapping("/findAllBrand")
    @ResponseBody
    public ServerRespones findAllBrand(){
       return brandService.findAllBrand();
    }

    @RequestMapping("/updateIsHot")
    @ResponseBody
    public ServerRespones updateIsHot(Long id,Integer isHot){
        return brandService.updateIsHot(id,isHot);
    }

    @RequestMapping("/updateIsSort")
    @ResponseBody
    public ServerRespones updateIsSort(Long id,Integer isSort){
        return brandService.updateIsSort(id,isSort);
    }
}
