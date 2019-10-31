package com.fh.shop.admin.util;

import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

public class FileInputUtil {

    public static Map fileInput(CommonsMultipartFile file){
        //File.separator方法获取到的是/ 因为Linux和项目的/不一样
        //项目 / Linux \         不同
        HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
        String realPath = request.getServletContext().getRealPath("/");
        String imgDir=realPath+"/imgs/";
        File f =new File(imgDir);
        if (!f.exists()) {
            f.mkdirs();
        }
        Map map = new HashMap();
        String originalFilename = file.getOriginalFilename();
        int end = originalFilename.lastIndexOf(".");
        String endName = originalFilename.substring(end);
        String newName=UUID.randomUUID()+endName;

        try {
            file.transferTo(new File(imgDir+"/"+newName));
            String url ="/"+"imgs"+"/"+newName;
            map.put("url",url);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return map;
    }
}
