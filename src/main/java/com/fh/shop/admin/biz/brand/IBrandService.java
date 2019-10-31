package com.fh.shop.admin.biz.brand;

import com.fh.shop.admin.commons.ServerRespones;
import com.fh.shop.admin.po.brand.Brand;

import java.util.List;

public interface IBrandService {
    Long findBrandCount();

    List<Brand> findPageBrandList(Brand brand);

    void addBrand(Brand brand);

    void deleteBrand(int id,String ossBrandImg);

    Brand findUpdateBrand(int id);

    void updateBrand(Brand brand);

    ServerRespones findAllBrand();

    ServerRespones updateIsHot(Long id, Integer isHot);

    ServerRespones updateIsSort(Long id, Integer isSort);
}
