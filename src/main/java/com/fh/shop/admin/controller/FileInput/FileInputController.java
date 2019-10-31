package com.fh.shop.admin.controller.FileInput;

import com.fh.shop.admin.commons.ServerRespones;
import com.fh.shop.admin.commons.SyetemConst;
import com.fh.shop.admin.util.FileUtil;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.io.InputStream;

@RestController
@RequestMapping("/file")
public class FileInputController {

    @RequestMapping("/uploadFile")
    public ServerRespones uploadFile(@RequestParam MultipartFile files, HttpServletRequest request){
        try {
            //获取流
            InputStream is = files.getInputStream();
            //获取老名字
            String originalFilename = files.getOriginalFilename();
            //根据相对路径获取绝对路径
            String realPath = request.getServletContext().getRealPath(SyetemConst.IMAGE_PATH);
            String newName = FileUtil.copyFile(is, originalFilename, realPath);
            //路径返回至前台  前台存入隐藏域
            return ServerRespones.success(SyetemConst.IMAGE_PATH+newName);

        } catch (IOException e) {
            e.printStackTrace();
            return ServerRespones.error();
        }

    }
}
