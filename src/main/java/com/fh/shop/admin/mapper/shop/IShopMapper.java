package com.fh.shop.admin.mapper.shop;

import com.fh.shop.admin.param.shop.ParamSearchShop;
import com.fh.shop.admin.po.shop.Shop;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface IShopMapper {
    Long findShopCount(ParamSearchShop paramSearchShop);

    List<Shop> findPageShopList(ParamSearchShop paramSearchShop);

    void addShop(Shop shop);

    void deleteShop(int id);

    Shop findUpdateShop(int id);

    void updateShop(Shop shop);

    int findIsUp(Long id);

    void updateIsUp(@Param("isUp") int isUp, @Param("id") Long id);

    List<Shop> findexportShop(ParamSearchShop paramSearchShop);
}
