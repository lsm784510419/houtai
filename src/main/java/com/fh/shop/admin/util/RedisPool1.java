package com.fh.shop.admin.util;

import redis.clients.jedis.*;

import java.util.LinkedHashSet;
import java.util.Set;

public class RedisPool1 {

    private RedisPool1(){

    }
    private static JedisPool jedisPool;

    public static JedisCluster initPool() {
        JedisPoolConfig jedisPoolConfig = new JedisPoolConfig();
        //最大连接数
        jedisPoolConfig.setMaxTotal(1000);
        //空闲时的最小连接
        jedisPoolConfig.setMaxIdle(100);
        jedisPoolConfig.setMinIdle(100);
        //允许测试连接
    /*jedisPoolConfig.setTestOnReturn(true);
    jedisPoolConfig.setTestOnBorrow(true);*/

        Set<HostAndPort> node = new LinkedHashSet<>();
        node.add(new HostAndPort("192.168.239.131", 30001));
        node.add(new HostAndPort("192.168.239.131", 30002));

        JedisCluster jedisCluster = new JedisCluster(node, jedisPoolConfig);
        //jedisPool= new JedisPool(jedisPoolConfig,"192.168.118.137",7020);
        return jedisCluster;
    }
    }
