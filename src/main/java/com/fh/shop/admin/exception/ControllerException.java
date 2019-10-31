package com.fh.shop.admin.exception;

import com.fh.shop.admin.commons.ServerRespones;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

@ControllerAdvice
public class ControllerException {

    @ExceptionHandler(Exception.class)
    @ResponseBody
    public ServerRespones handException (Exception ex){
        ex.printStackTrace();
        return ServerRespones.error();
    }
}
