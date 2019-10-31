package com.fh.shop.admin;

import com.fh.shop.admin.po.shop.Shop;
import org.junit.Test;

import java.lang.reflect.Constructor;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

public class FSTest {

    @Test
    public void test2() throws ClassNotFoundException, NoSuchMethodException, IllegalAccessException, InvocationTargetException, InstantiationException, NoSuchFieldException {
        Shop shop = new Shop();
        Class studentClass = shop.getClass();

        Class studentClass1 = Shop.class;

       Class studentClass2 = Class.forName("admin.Shop");

        //获取所有公有构造方法
        Constructor[] constructors = studentClass.getConstructors();

        //所有的构造方法(包括：私有、受保护、默认、公有)
        Constructor[] declaredConstructors = studentClass.getDeclaredConstructors();

        //获取公有、无参的构造方法
        Constructor constructor = studentClass.getConstructor(null);

        //调用构造方法
        Object o = constructor.newInstance();

        //获取私有构造方法，并调用
        Constructor declaredConstructor = studentClass.getDeclaredConstructor();

        //调用构造方法
        declaredConstructor.setAccessible(true);//暴力访问(忽略掉访问修饰符)
        declaredConstructor.newInstance();

        //公有字段
        Field[] fields = studentClass.getFields();

        //获取所有的字段(包括私有、受保护、默认的)
        Field[] declaredFields = studentClass.getDeclaredFields();

        Field field = studentClass.getDeclaredField("name");
        Object o1 = studentClass.getConstructor().newInstance();
        field.setAccessible(true);//暴力反射，解除私有私有的方法  属性
        field.set(o1,"张三");
        Object o3 = field.get(o1);
        System.out.println(o3+"**************");
        Shop shop1 = (Shop) o1;
        System.out.println(shop1.getShopName());

        //获取所有公有方法
        Method[] methods = studentClass.getMethods();
        for(Method method : methods){
            System.out.println(method.getName());
            System.out.println(method);
        }


        //获取所有的方法，包括私有的
        Method[] declaredMethods = studentClass.getDeclaredMethods();

        //
        Method setName = studentClass2.getMethod("setName", String.class);
        Object o2 = studentClass2.getConstructor().newInstance();
        setName.invoke(o2,"李四");
        Shop shop2 = (Shop) o2;
        System.out.println(shop2.getShopName());

        Method getName = studentClass2.getMethod("getName");
        Object invoke = getName.invoke(o2);
        System.out.println((String) invoke + "####");

    }

}
