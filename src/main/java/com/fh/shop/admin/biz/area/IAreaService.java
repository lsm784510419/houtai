package com.fh.shop.admin.biz.area;

import com.fh.shop.admin.commons.ServerRespones;
import com.fh.shop.admin.po.area.Area;
import com.fh.shop.admin.vo.area.AreaVo;

import java.util.List;

public interface IAreaService {
    List<AreaVo> findAreaList();

    void addArea(Area area);

    void updateArea(Area area);

    void deleteArea(List<Long> list);

    ServerRespones findAreaSelect(Long id);
}
