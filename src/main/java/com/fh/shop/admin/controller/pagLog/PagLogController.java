package com.fh.shop.admin.controller.pagLog;

import com.fh.shop.admin.biz.pagLog.IPagLogService;
import com.fh.shop.admin.commons.ServerRespones;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;

@Controller
@RequestMapping("/pagLog")
public class PagLogController {


    @Resource(name = "pagLogService")
    private IPagLogService pagLogService;
    @RequestMapping("/toList")
    public String toList(){
        return "pagLog/list";
    }

    @RequestMapping("/findPageList")
    public ServerRespones findPageList(){

        return pagLogService.findPageList();
    }
}
