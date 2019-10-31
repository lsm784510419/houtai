package com.fh.shop.admin.controller.clearCache;

import com.fh.shop.admin.commons.ServerRespones;
import com.fh.shop.admin.util.RedisUtil;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RequestMapping("/cache")
@RestController
public class CacheController {
    @RequestMapping("/clearProductCache")
    public ServerRespones clearProductCache(){
        RedisUtil.del("cendProduct");
        return ServerRespones.success();
    }
}
