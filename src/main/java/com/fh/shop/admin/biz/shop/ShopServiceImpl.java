package com.fh.shop.admin.biz.shop;

import com.fh.shop.admin.mapper.shop.IShopMapper;
import com.fh.shop.admin.param.shop.ParamSearchShop;
import com.fh.shop.admin.po.shop.Shop;
import com.fh.shop.admin.util.DateUtil;
import com.fh.shop.admin.vo.shop.ShopVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service("shopService")
public class ShopServiceImpl implements IShopService {

    @Autowired
    private IShopMapper shopMapper;

    @Override
    public Long findShopCount(ParamSearchShop paramSearchShop) {
        Long shopCount = shopMapper.findShopCount(paramSearchShop);

        return shopCount;
    }

    @Override
    public List<ShopVo> findPageShopList(ParamSearchShop paramSearchShop) {
        List<Shop> pageShopList = shopMapper.findPageShopList(paramSearchShop);
        List<ShopVo> shopVoList = new ArrayList<>();
        for (Shop shopList : pageShopList) {
            ShopVo shopVo = getShopVo(shopList);
            shopVoList.add(shopVo);
        }
        return shopVoList;
    }

    @Override
    public void addShop(Shop shop) {
        shopMapper.addShop(shop);
    }

    @Override
    public void deleteShop(int id) {
        shopMapper.deleteShop(id);
    }

    @Override
    public ShopVo findUpdateShop(int id) {
        Shop updateShop = shopMapper.findUpdateShop(id);
        ShopVo shopVo = getShopVo(updateShop);
        return shopVo;
    }

    @Override
    public void updateShop(Shop shop) {
        shopMapper.updateShop(shop);

    }

    @Override
    public void updateIsUp(Long id) {
        int shopIsUp=shopMapper.findIsUp(id);
        int isUp = 0;
        if (shopIsUp==0){
            isUp=1;
        }else{
            isUp=0;
        }
        shopMapper.updateIsUp(isUp,id);
    }

    @Override
    public List<Shop> findexportShop(ParamSearchShop paramSearchShop) {
        List<Shop> findexportShop = shopMapper.findexportShop(paramSearchShop);
        return findexportShop;
    }


    private ShopVo getShopVo(Shop shopList) {
        ShopVo shopVo =new ShopVo();
        shopVo.setId(shopList.getId());
        shopVo.setShopName(shopList.getShopName());
        shopVo.setPrice(shopList.getPrice().toString());
        shopVo.setShopImg(shopList.getShopImg());
        shopVo.setShopTime(DateUtil.date2str(shopList.getShopTime(),DateUtil.FOR_YEAR));
        shopVo.setStock(shopList.getStock());
        shopVo.setIsHotCakes(shopList.getIsHotCakes());
        shopVo.setIsUp(shopList.getIsUp());
        return shopVo;
    }

}
