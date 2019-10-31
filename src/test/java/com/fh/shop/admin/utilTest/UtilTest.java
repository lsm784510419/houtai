package com.fh.shop.admin.utilTest;

import com.fh.shop.admin.util.RedisUtil;
import org.junit.Test;

public class UtilTest {
    @Test
    public void setTest(){
        RedisUtil.set("stuName","liMao");
    }
}
