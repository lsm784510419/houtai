package com.fh.shop.admin.controller.FileInput;

import com.fh.shop.admin.commons.ServerRespones;
import com.fh.shop.admin.util.OssUtil;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.io.InputStream;
import java.util.UUID;

@RestController
@RequestMapping("/file")
public class FileInputController1 {

    @RequestMapping("/uploadFile1")
    public ServerRespones uploadFile(@RequestParam MultipartFile files, HttpServletRequest request){
        try {
            //获取老名字
            String originalFilename = files.getOriginalFilename();
            //生成uuid
            String uuid = UUID.randomUUID().toString();
            //分割字符串也就是老名字，获取到后缀
            String endName = originalFilename.substring(originalFilename.lastIndexOf("."));
            //生成的uuid+后缀就是新名字
            originalFilename = uuid+endName;
            //调用工具类方法 传过去工具类所需要的方法  并接收返回的类型
            String fileName = OssUtil.ossFileInput(files, originalFilename);
            //响应给前台，前台存入隐藏域
            return ServerRespones.success(fileName);

        } catch (IOException e) {
            e.printStackTrace();
            return ServerRespones.error();
        }

    }
}
