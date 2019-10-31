package com.fh.shop.admin.biz.shop;

import com.fh.shop.admin.param.shop.ParamSearchShop;
import com.fh.shop.admin.po.shop.Shop;
import com.fh.shop.admin.vo.shop.ShopVo;

import java.util.List;

public interface IShopService {
    Long findShopCount(ParamSearchShop paramSearchShop);


    List<ShopVo> findPageShopList(ParamSearchShop paramSearchShop);

    void addShop(Shop shop);

    void deleteShop(int id);

    ShopVo findUpdateShop(int id);

    void updateShop(Shop shop);

    void updateIsUp(Long id);

    List<Shop> findexportShop(ParamSearchShop paramSearchShop);
}
