package com.fh.shop.admin.commons;

import java.io.Serializable;

public class ServerRespones implements Serializable {

    private int code;

    private String msg;

    private Object data;


    public ServerRespones(){

    }

    public ServerRespones(int code, String msg, Object data) {
        this.code = code;
        this.msg = msg;
        this.data = data;
    }

    public static ServerRespones success(){

       return new ServerRespones(200,"Ok",null);
    }
    public static ServerRespones success(Object data){

        return new ServerRespones(200,"Ok",data);
    }
    public static ServerRespones error(){
        return new ServerRespones(-1,"操作失败",null);
    }
    public static ServerRespones loginStarts(int code,String msg){
        return new ServerRespones(code,"msg",null);
    }
    public static ServerRespones error(ResponseEnum responseEnum){
        return new ServerRespones(responseEnum.getCode(),responseEnum.getMsg(),null);
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }
}
