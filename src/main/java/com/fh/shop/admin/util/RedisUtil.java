package com.fh.shop.admin.util;

import redis.clients.jedis.Jedis;

public class RedisUtil {

    public static void set (String key, String value){
        Jedis resource = null;
        try {
            resource = RedisPool.getResource();
            resource.set(key,value);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e.getMessage());
        } finally {
            if (resource != null){
                resource.close();
            }
        }
    }
    public static void del(String key){
        Jedis resource = null;
        try {
            resource = RedisPool.getResource();
            resource.del(key);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e.getMessage());
        } finally {
            if (resource != null){
                resource.close();
            }
        }
    }
    public static void delBatch(String... keys){
        Jedis resource = null;
        try {
            resource = RedisPool.getResource();
            resource.del(keys);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e.getMessage());
        } finally {
            if (resource != null){
                resource.close();
            }
        }
    }
    public static void expire(String key,int seconds){
        Jedis resource = null;
        try {
            resource = RedisPool.getResource();
            resource.expire(key,seconds);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (resource != null){
                resource.close();
            }
        }
    }
    public static String get(String key){
        Jedis resource = null;
        String redisValue = null;
        try {
            resource = RedisPool.getResource();
            redisValue = resource.get(key);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e.getMessage());
        } finally {
            if (resource != null){
                resource.close();
            }
        }
        return redisValue;
    }
    public static void setEx(String key,int seconds,String value){
        Jedis resource = null;
        try {
            resource = RedisPool.getResource();
            resource.setex(key,seconds,value);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e.getMessage());
        } finally {
            if (resource != null){
                resource.close();
            }
        }
    }
}
