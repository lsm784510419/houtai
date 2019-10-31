package com.fh.shop.admin.mapper.product;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.fh.shop.admin.param.product.ProductParam;
import com.fh.shop.admin.po.product.Product;
import com.fh.shop.admin.po.shop.Shop;

import java.util.List;

public interface IProductMapper extends BaseMapper<Product> {
    long findCount(ProductParam productParam);

    List<Product> findPageProductList(ProductParam productParam);

    List<Product> findexportProduct(ProductParam productParam);

    //String findCateName(Long id);

}
