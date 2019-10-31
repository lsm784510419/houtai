package com.fh.shop.admin.vo.shop;


import java.io.Serializable;
import java.math.BigDecimal;

public class ShopVo implements Serializable {
    private Long id;
    private String shopName;
    private String price;
    private String shopImg;
    private String shopTime;
    private Long stock;

    private Integer isHotCakes;

    private Integer isUp;


    public Long getStock() {
        return stock;
    }

    public void setStock(Long stock) {
        this.stock = stock;
    }

    public Integer getIsHotCakes() {
        return isHotCakes;
    }

    public void setIsHotCakes(Integer isHotCakes) {
        this.isHotCakes = isHotCakes;
    }

    public Integer getIsUp() {
        return isUp;
    }

    public void setIsUp(Integer isUp) {
        this.isUp = isUp;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getShopName() {
        return shopName;
    }

    public void setShopName(String shopName) {
        this.shopName = shopName;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }

    public String getShopImg() {
        return shopImg;
    }

    public void setShopImg(String shopImg) {
        this.shopImg = shopImg;
    }

    public String getShopTime() {
        return shopTime;
    }

    public void setShopTime(String shopTime) {
        this.shopTime = shopTime;
    }
}
