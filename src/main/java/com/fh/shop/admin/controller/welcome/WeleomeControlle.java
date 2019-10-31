package com.fh.shop.admin.controller.welcome;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class WeleomeControlle {

    @RequestMapping("/index")
    public String weleome(){

        return "index";
    }
}
