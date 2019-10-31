package com.fh.shop.admin.util;

import com.aliyun.oss.OSSClient;
import com.aliyun.oss.model.ObjectMetadata;
import org.springframework.web.multipart.MultipartFile;

import java.io.*;
import java.util.Date;

public class OssUtil {
    private static final String ENDPOINT = "https://oss-cn-beijing.aliyuncs.com";//域名
    private static final String ACCESSKEYID = "LTAI4Fqfr2nPmAPaUhYYDAo9";//accessKeyId访问的权限
    private static final String SECRETACCESSKEY = "juHlVWDY6veltvpt9es84PTmTO5MN4";//对应的秘钥
    private static final String BUCKETNAME = "lsm-test-image";//创建的oss存储空间
    private static final String URL = "oss-cn-beijing.aliyuncs.com";
    private static final String DOMAIN = "http://" + BUCKETNAME + "." + URL + "/";
    public static String ossFileInput(MultipartFile files, String fileName) throws IOException {
        //创建ossclient实例  第一个参数 是你的域名  第二个参数 是产品app  第三个是 对应的密匙

        OSSClient ossClient = new OSSClient(ENDPOINT, ACCESSKEYID,SECRETACCESSKEY);
        // 上传文件流。
        InputStream is = files.getInputStream();
        ObjectMetadata objectMetadata = new ObjectMetadata();
        //设置访问协议为http
        objectMetadata.setContentType("http");
        //设置能访问
        objectMetadata.setContentDisposition("inline; filename=noavatar_middle.gif");
        String strDate = DateUtil.date2str(new Date(), DateUtil.Y_M_D);
        //第一个参数 是 存储空间的名称  第二个是  文件夹+文件名称  fileName 是 文件名称  is  是文件流，设置的Oss属性
        String objectName = strDate + "/" + fileName;
        ossClient.putObject(BUCKETNAME, objectName, is,objectMetadata);
        // 关闭OSSClient。
        ossClient.shutdown();
        //返回的是全路径，数据库中存储的路径，阿里云Oss的路径   返回至工具类
        
        return DOMAIN + objectName;
    }

    public static void deleteOss(String fileName){
        //创建实例
        OSSClient ossClient = new OSSClient(ENDPOINT, ACCESSKEYID,SECRETACCESSKEY);
        String objectName = fileName.replace(DOMAIN, "");
        // 删除文件。
        ossClient.deleteObject(BUCKETNAME,objectName);
        // 关闭OSSClient。
        ossClient.shutdown();
    }
}
