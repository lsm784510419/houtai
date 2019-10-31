package com.fh.shop.admin.utilTest;

import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.util.EntityUtils;
import org.junit.Test;

import java.io.IOException;

public class TestHttpclient {

    @Test
     public void test(){
         CloseableHttpClient build = null;
         HttpGet httpGet = null;
         CloseableHttpResponse response = null;

         try {
             //创建浏览器
             build = HttpClientBuilder.create().build();
             //输入url网址
             httpGet = new HttpGet("https://www.2345.com/baidu/search.html");
             //敲下回车键，访问这个url  返回的内容
             response = build.execute(httpGet);
             //获取响应的内容
             HttpEntity entity = response.getEntity();
             //输出控制台   调用Httpclient为我们提供的EntityUtils的方法
             String re = EntityUtils.toString(entity);
             System.out.println(re);
         } catch (IOException e) {
             e.printStackTrace();
         } finally {
             if (null != httpGet){
                 try {
                     httpGet.clone();
                 } catch (CloneNotSupportedException e) {
                     e.printStackTrace();
                 }
             }
             if (null != response){
                 try {
                     response.close();
                 } catch (IOException e) {
                     e.printStackTrace();
                 }
             }
             if (null != build ){
                 try {
                     build.close();
                 } catch (IOException e) {
                     e.printStackTrace();
                 }
             }
         }


     }
}
