package com.fh.shop.admin;

import com.aliyun.oss.OSSClient;
import com.aliyun.oss.model.GetObjectRequest;
import com.aliyun.oss.model.ObjectMetadata;
import org.junit.Test;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;

public class OssTest {
    @Test
    public void testOss(){
        //创建ossclient实例  第一个参数 是你的域名  第二个参数 是产品app  第三个是 对应的密匙
        String accessKeyId = "LTAI4Fqfr2nPmAPaUhYYDAo9";//accessKeyId访问的权限
        String secretAccessKey = "juHlVWDY6veltvpt9es84PTmTO5MN4";//对应的秘钥
        OSSClient ossClient = new OSSClient("https://oss-cn-beijing.aliyuncs.com", accessKeyId, secretAccessKey);
        // 上传文件流。
        File file = new File("D:\\images\\1.jpg");
        InputStream is = null;
        try {
            is = new FileInputStream(file);
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
        //文件名
        String testFileName = file.getName();
        ObjectMetadata objectMetadata = new ObjectMetadata();
        objectMetadata.setContentType("http");
        objectMetadata.setContentDisposition("inline; filename=noavatar_middle.gif");
        //第一个参数 是 存储空间的名称  第二个是  文件夹+文件名称  fileName 是 文件名称  is  是文件流
        String bucketName = "lsm-test-image";//创建的oss存储空间
        ossClient.putObject(bucketName, "image/" + testFileName, is,objectMetadata);
        // 关闭OSSClient。
        ossClient.shutdown();
    }
    @Test
    public void test1(){
        //创建ossclient实例  第一个参数 是你的域名  第二个参数 是产品app  第三个是 对应的密匙
        String endpoint = "https://oss-cn-beijing.aliyuncs.com";//域名
        String accessKeyId = "LTAI4Fqfr2nPmAPaUhYYDAo9";//accessKeyId访问的权限
        String secretAccessKey = "juHlVWDY6veltvpt9es84PTmTO5MN4";//对应的秘钥
        String bucketName = "lsm-test-image";//创建的oss存储空间
        OSSClient ossClient = new OSSClient(endpoint, accessKeyId,secretAccessKey);
        String objectName = "image/"+"1.jpg";
        // 删除文件。
        ossClient.deleteObject(bucketName, objectName);

        // 关闭OSSClient。
        ossClient.shutdown();
    }
    @Test
    public void test2(){
        //创建ossclient实例  第一个参数 是你的域名  第二个参数 是产品app  第三个是 对应的密匙
        String endpoint = "https://oss-cn-beijing.aliyuncs.com";//域名
        String accessKeyId = "LTAI4Fqfr2nPmAPaUhYYDAo9";//accessKeyId访问的权限
        String secretAccessKey = "juHlVWDY6veltvpt9es84PTmTO5MN4";//对应的秘钥
        String bucketName = "lsm-test-image";//创建的oss存储空间
        OSSClient ossClient = new OSSClient(endpoint, accessKeyId,secretAccessKey);
        // 下载OSS文件到本地文件。如果指定的本地文件存在会覆盖，不存在则新建。
        String objectName = "image/"+"0e423115-fc45-4a99-a84b-82575c5994c0.jpg";
        ossClient.getObject(new GetObjectRequest(bucketName, objectName), new File("F://tengxun"));
    }
}
