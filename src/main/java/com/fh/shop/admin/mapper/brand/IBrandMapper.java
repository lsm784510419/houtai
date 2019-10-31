package com.fh.shop.admin.mapper.brand;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.fh.shop.admin.po.brand.Brand;

import java.util.List;

public interface IBrandMapper extends BaseMapper<Brand> {
    Long findBrandCount();

    List<Brand> findPageBrandList(Brand brand);

    void addBrand(Brand brand);

    void deleteBrand(int id);

    Brand findUpdateBrand(int id);

    void updateBrand(Brand brand);

}
