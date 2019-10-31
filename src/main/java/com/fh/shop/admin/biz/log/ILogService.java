package com.fh.shop.admin.biz.log;

import com.fh.shop.admin.param.log.ParamSearchLog;
import com.fh.shop.admin.po.log.LogInfo;
import com.fh.shop.admin.vo.log.LogVo;

import java.util.List;

public interface ILogService {

     void addLog(LogInfo logInfo);

    List<LogVo> findPageLogList(ParamSearchLog paramSearchLog);

    Long findPageCount(ParamSearchLog paramSearchLog);
}
