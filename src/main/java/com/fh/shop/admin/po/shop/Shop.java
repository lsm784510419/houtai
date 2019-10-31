package com.fh.shop.admin.po.shop;

import com.fh.shop.admin.commons.Page;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

public class Shop implements Serializable {
    private Long id;
    private String shopName;
    private BigDecimal price;
    private String shopImg;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date shopTime;

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

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public String getShopImg() {
        return shopImg;
    }

    public void setShopImg(String shopImg) {
        this.shopImg = shopImg;
    }

    public Date getShopTime() {
        return shopTime;
    }

    public void setShopTime(Date shopTime) {
        this.shopTime = shopTime;
    }
}
