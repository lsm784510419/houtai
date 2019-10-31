package com.fh.shop.admin.utilTest;

import com.fh.shop.admin.util.RedisPool1;
import org.junit.Test;
import redis.clients.jedis.JedisCluster;

public class TestRedis {
    @Test
    public void test1(){
        JedisCluster jedisCluster = RedisPool1.initPool();
        jedisCluster.set("a","2");
    }
}
