package com.fh.shop.admin.param.log;

import com.fh.shop.admin.commons.Page;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.util.Date;

public class ParamSearchLog extends Page implements Serializable {

    private String userName;

    private String realName;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    private Date minCurrDate;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    private Date maxCurrDate;

    private Integer status;

    private String info;

    private String content;

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
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

    public Date getMinCurrDate() {
        return minCurrDate;
    }

    public void setMinCurrDate(Date minCurrDate) {
        this.minCurrDate = minCurrDate;
    }

    public Date getMaxCurrDate() {
        return maxCurrDate;
    }

    public void setMaxCurrDate(Date maxCurrDate) {
        this.maxCurrDate = maxCurrDate;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getInfo() {
        return info;
    }

    public void setInfo(String info) {
        this.info = info;
    }
}
