package com.fh.shop.admin.biz.area;

import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.fh.shop.admin.commons.ServerRespones;
import com.fh.shop.admin.mapper.area.IAreaMapper;
import com.fh.shop.admin.po.area.Area;
import com.fh.shop.admin.util.RedisUtil;
import com.fh.shop.admin.vo.area.AreaVo;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service("areaService")
public class AreaServiceImpl implements IAreaService {
    @Autowired
    private IAreaMapper areaMapper;

    @Override
    public List<AreaVo> findAreaList() {
        //缓存中取数据
        String areaListJson = RedisUtil.get("areaList");
        //判断缓存是否有数据
        if (StringUtils.isNotEmpty(areaListJson)){
            List<Area> areaList = JSONObject.parseArray(areaListJson, Area.class);
            List<AreaVo> areaVoList = getAreaVos(areaList);
            return areaVoList;
        }
        List<Area> areaList = areaMapper.findAreaList();
        //转换数据类型
        areaListJson= JSONObject.toJSONString(areaList);
        //存入缓存
        RedisUtil.set("areaList",areaListJson);
        List<AreaVo> areaVoList = getAreaVos(areaList);
        return areaVoList;
    }

    private List<AreaVo> getAreaVos(List<Area> areaList) {
        List<AreaVo> areaVoList = new ArrayList<>();
        for (Area areaPo : areaList) {
            AreaVo areaVo = getAreaVo(areaPo);
            areaVoList.add(areaVo);
        }
        return areaVoList;
    }

    private AreaVo getAreaVo(Area areaPo) {
        AreaVo areaVo = new AreaVo();
        areaVo.setId(areaPo.getId());
        areaVo.setName(areaPo.getAreaName());
        areaVo.setpId(areaPo.getFatherId());
        return areaVo;
    }

    @Override
    public void addArea(Area area) {
        RedisUtil.del("areaList");
        areaMapper.addArea(area);
    }

    @Override
    public void updateArea(Area area) {
        RedisUtil.del("areaList");
        areaMapper.updateArea(area);
    }

    @Override
    public void deleteArea(List<Long> list) {
        RedisUtil.del("areaList");
        areaMapper.deleteArea(list);
    }

    @Override
    public ServerRespones findAreaSelect(Long id) {
        String areaListJson = RedisUtil.get("areaList");
        if (StringUtils.isNotEmpty(areaListJson)){
            List<Area> areaList = JSONObject.parseArray(areaListJson, Area.class);
            List<Area> idByFatherId = getIdByFatherId(id, areaList);
            return ServerRespones.success(idByFatherId);
        }
       /* QueryWrapper<Area> areaQueryWrapper = new QueryWrapper<>();
        areaQueryWrapper.eq("fatherId",id);*/
        List<Area> areaList = areaMapper.selectList(null);
        areaListJson = JSONObject.toJSONString(areaList);
        RedisUtil.set("areaList",areaListJson);
        List<Area> idByFatherId = getIdByFatherId(id, areaList);
        return ServerRespones.success(idByFatherId);
    }
    private List<Area> getIdByFatherId(Long id,List<Area> areaList){
        List<Area> areas = new ArrayList<>();
        for (Area area : areaList) {
            if (area.getFatherId() == id){
                areas.add(area);
            }
        }
        return areas;
    }
}
