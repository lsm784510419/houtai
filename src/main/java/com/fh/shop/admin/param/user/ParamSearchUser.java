package com.fh.shop.admin.param.user;

import com.fh.shop.admin.commons.Page;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

public class ParamSearchUser extends Page implements Serializable {
    private String userName;

    private String realName;

    private Integer minAge;

    private Integer maxAge;

    private Double minPrice;

    private Double maxPrice;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date minEntryDate;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date maxEntryDate;

    private String roleIds;

    private List<Integer> roleList;

    private int roleListSize;

    private Long area1;

    private Long area2;

    private Long area3;

    public Long getArea1() {
        return area1;
    }

    public void setArea1(Long area1) {
        this.area1 = area1;
    }

    public Long getArea2() {
        return area2;
    }

    public void setArea2(Long area2) {
        this.area2 = area2;
    }

    public Long getArea3() {
        return area3;
    }

    public void setArea3(Long area3) {
        this.area3 = area3;
    }

    public String getRoleIds() {
        return roleIds;
    }

    public void setRoleIds(String roleIds) {
        this.roleIds = roleIds;
    }

    public List<Integer> getRoleList() {
        return roleList;
    }

    public void setRoleList(List<Integer> roleList) {
        this.roleList = roleList;
    }

    public int getRoleListSize() {
        return roleListSize;
    }

    public void setRoleListSize(int roleListSize) {
        this.roleListSize = roleListSize;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getRealName() {
        return realName;
    }

    public void setRealName(String realName) {
        this.realName = realName;
    }

    public Integer getMinAge() {
        return minAge;
    }

    public void setMinAge(Integer minAge) {
        this.minAge = minAge;
    }

    public Integer getMaxAge() {
        return maxAge;
    }

    public void setMaxAge(Integer maxAge) {
        this.maxAge = maxAge;
    }

    public Double getMinPrice() {
        return minPrice;
    }

    public void setMinPrice(Double minPrice) {
        this.minPrice = minPrice;
    }

    public Double getMaxPrice() {
        return maxPrice;
    }

    public void setMaxPrice(Double maxPrice) {
        this.maxPrice = maxPrice;
    }

    public Date getMinEntryDate() {
        return minEntryDate;
    }

    public void setMinEntryDate(Date minEntryDate) {
        this.minEntryDate = minEntryDate;
    }

    public Date getMaxEntryDate() {
        return maxEntryDate;
    }

    public void setMaxEntryDate(Date maxEntryDate) {
        this.maxEntryDate = maxEntryDate;
    }
}
