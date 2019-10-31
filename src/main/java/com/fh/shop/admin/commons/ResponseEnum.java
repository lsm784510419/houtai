package com.fh.shop.admin.commons;

public enum ResponseEnum {

    USERNAME_PASSWORD_IS_NULL(1000,"用户号或密码或验证码为空"),
    USERNAME_IS_ERROR(1001,"用户名不存在"),
    USER_LOCKED(1003,"账号已锁定，请联系管理员"),
    PASSWORD_IS_NULL(1004,"您输入的信息为空"),
    PASSWORD_IS_DIFFERENT(1005,"您输入的两次密码不一致"),
    OLD_PASSWORD_IS_ERROR(1006,"您输入的原密码不正确"),
    USER_IS_NULL(1007,"用户不存在"),
    RESET_PASSWORD_SUCCESS(1008,"重置密码成功"),
    EMAIL_IS_NULL(1009,"您输入的邮箱不存在"),
    CODE_IS_ERROR(1010,"验证码错误"),
    PASSWORD_IS_ERROR(1002,"密码错误");

    private int code;

    private String msg;


   private ResponseEnum(int code, String msg) {
        this.code = code;
        this.msg = msg;
    }

    public int getCode() {
        return code;
    }

    public String getMsg() {
        return msg;
    }
}
