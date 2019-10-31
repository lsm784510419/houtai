package com.fh.shop.admin;

import com.fh.shop.admin.po.brand.Brand;
import com.fh.shop.admin.po.product.Product;
import org.junit.Test;

import java.lang.reflect.Field;
import java.lang.reflect.Method;

public class ReflectTest {
    @Test
    public void test1(){
        show(Brand.class);

        show1(Product.class);
    }
    private void show(Class clazz){
        Field[] declaredFields = clazz.getDeclaredFields();
        for (Field declaredField : declaredFields) {
            System.out.println(declaredField.getName()+":"+declaredField.getType());
        }
    }
    private void show1(Class clazz){
        Method[] declaredMethods = clazz.getDeclaredMethods();
        for (Method declaredMethod : declaredMethods) {
            System.out.println(declaredMethod.getName());
        }
    }

}
