package com.fh.shop.admin.controller.log;

import com.fh.shop.admin.biz.log.ILogService;
import com.fh.shop.admin.commons.Datetables;
import com.fh.shop.admin.param.log.ParamSearchLog;
import com.fh.shop.admin.po.log.LogInfo;
import com.fh.shop.admin.vo.log.LogVo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;

@Controller
@RequestMapping("/log")
public class LogController {
    @Resource(name = "logService")
    private ILogService logService;


    @RequestMapping("/toList")
    public String toList(){

        return "log/list";
    }

    @RequestMapping("/findPageLogList")
    @ResponseBody
    public Datetables findPageLogList(ParamSearchLog paramSearchLog){
       List<LogVo> pageList= logService.findPageLogList(paramSearchLog);
        Long count= logService.findPageCount(paramSearchLog);
        Datetables datetables = new Datetables(paramSearchLog.getDraw(),count,count,pageList);
        return datetables;
    }
}
