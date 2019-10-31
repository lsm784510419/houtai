package com.fh.shop.admin.mapper.log;

import com.fh.shop.admin.param.log.ParamSearchLog;
import com.fh.shop.admin.po.log.LogInfo;

import java.util.List;

public interface ILogMapper {


    void addLog(LogInfo logInfo);

    List<LogInfo> findPageLogList(ParamSearchLog paramSearchLog);

    Long findPageCount(ParamSearchLog paramSearchLog);
}
