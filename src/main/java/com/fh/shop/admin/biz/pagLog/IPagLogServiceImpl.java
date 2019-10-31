package com.fh.shop.admin.biz.pagLog;

import com.fh.shop.admin.mapper.pagLog.IPagLogMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("pagLogService")
public class IPagLogServiceImpl implements IPagLogService {
    @Autowired
    private IPagLogMapper pagLogMapper;
}
