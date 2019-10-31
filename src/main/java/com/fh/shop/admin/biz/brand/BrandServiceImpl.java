package com.fh.shop.admin.biz.brand;

import com.alibaba.fastjson.JSONObject;
import com.fh.shop.admin.commons.ServerRespones;
import com.fh.shop.admin.mapper.brand.IBrandMapper;
import com.fh.shop.admin.po.brand.Brand;
import com.fh.shop.admin.util.OssUtil;
import com.fh.shop.admin.util.RedisUtil;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("brandService")
public class BrandServiceImpl implements IBrandService {
    @Autowired
    private IBrandMapper brandMapper;

    @Override
    public Long findBrandCount() {
        Long count = brandMapper.findBrandCount();
        return count;
    }

    @Override
    public List<Brand> findPageBrandList(Brand brand) {
        List<Brand> pageBrandList = brandMapper.findPageBrandList(brand);

        return pageBrandList;
    }

    @Override
    public void addBrand(Brand brand) {
        RedisUtil.del("brandList");
        RedisUtil.del("hotBrandList");
        brandMapper.addBrand(brand);
    }

    @Override
    public void deleteBrand(int id,String ossBrandImg) {
        String fileName = ossBrandImg.substring(ossBrandImg.lastIndexOf("/"));
        OssUtil.deleteOss(fileName);
        RedisUtil.del("brandList");
        RedisUtil.del("hotBrandList");
        brandMapper.deleteBrand(id);
    }

    @Override
    public Brand findUpdateBrand(int id) {
        Brand updateBrand = brandMapper.findUpdateBrand(id);
        return updateBrand;
    }

    @Override
    public void updateBrand(Brand brand) {
     /* if (StringUtils.isNotEmpty(brand.getBrandImg())){
          OssUtil.deleteOss(brand.getBrandImg());
      }*/
        RedisUtil.del("brandList");
        RedisUtil.del("hotBrandList");
        brandMapper.updateBrand(brand);
    }

    @Override
    public ServerRespones findAllBrand() {
        //通过工具类根据key取出值
        String bandListJson = RedisUtil.get("brandList");
        //判断这个值是否存在，如果不存在就证明redis是空的
        if (StringUtils.isEmpty(bandListJson)){
            //redis是空的就去数据库中查询
            List<Brand> brandListDB = brandMapper.selectList(null);
            //因为我们查询出来的是list集合，但是给缓存服务器存的是String 所以需要转换为json格式的数组
            bandListJson = JSONObject.toJSONString(brandListDB);
            //存入redis缓存服务器
            RedisUtil.set("brandList",bandListJson);
            //响应给客户端
            return ServerRespones.success(brandListDB);
        }else {
            //redis缓存服务器中有数据，但是是String类型的，所以需要转换为list
            List<Brand> brandList = JSONObject.parseArray(bandListJson, Brand.class);
            //响应给客户端
            return ServerRespones.success(brandList);
        }
    }

    @Override
    public ServerRespones updateIsHot(Long id, Integer isHot) {
        Brand brand = new Brand();
        brand.setId(id);
        brand.setIsHot(isHot);
        RedisUtil.del("brandList");
        RedisUtil.del("hotBrandList");
        brandMapper.updateById(brand);
        return ServerRespones.success();
    }

    @Override
    public ServerRespones updateIsSort(Long id, Integer isSort) {
        Brand brand = new Brand();
        brand.setId(id);
        brand.setIsSort(isSort);
        brandMapper.updateById(brand);
        RedisUtil.del("brandList");
        RedisUtil.del("hotBrandList");
        return ServerRespones.success();
    }
}
