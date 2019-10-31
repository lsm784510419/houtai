package com.fh.shop.admin.biz.log;

import com.fh.shop.admin.mapper.log.ILogMapper;
import com.fh.shop.admin.param.log.ParamSearchLog;
import com.fh.shop.admin.po.log.LogInfo;
import com.fh.shop.admin.util.DateUtil;
import com.fh.shop.admin.vo.log.LogVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service("logService")
public class LogServiceImpl implements ILogService {
    @Autowired
    private ILogMapper logMapper;
    @Override
    public void addLog(LogInfo logInfo) {
        logMapper.addLog(logInfo);
    }

    @Override
    public List<LogVo> findPageLogList(ParamSearchLog paramSearchLog) {
        List<LogInfo> pageLogList = logMapper.findPageLogList(paramSearchLog);
        List<LogVo> logVoList = new ArrayList<>();
        for (LogInfo logInfo : pageLogList) {
            LogVo logVo = getLogVo(logInfo);
            logVoList.add(logVo);
        }
        return logVoList;
    }

    private LogVo getLogVo(LogInfo logInfo) {
        LogVo logVo = new LogVo();
        logVo.setId(logInfo.getId());
        logVo.setUserName(logInfo.getUserName());
        logVo.setRealName(logInfo.getRealName());
        logVo.setCurrDate(DateUtil.date2str(logInfo.getCurrDate(),DateUtil.FOR_YEAR));
        logVo.setErrorMsg(logInfo.getErrorMsg());
        logVo.setInfo(logInfo.getInfo());
        logVo.setStatus(logInfo.getStatus());
        logVo.setDetail(logInfo.getDetail());
        logVo.setContent(logInfo.getContent());
        return logVo;
    }

    @Override
    public Long findPageCount(ParamSearchLog paramSearchLog) {
        Long pageCount = logMapper.findPageCount(paramSearchLog);
        return pageCount;
    }

}
