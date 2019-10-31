package com.fh.shop.admin.biz.type;

import com.fh.shop.admin.commons.ServerRespones;
import com.fh.shop.admin.po.type.Type;

import java.util.List;

public interface ITypeService {

    ServerRespones findTypeList();

    ServerRespones addType(Type type);

    ServerRespones deleteType(List<Long> ids);

    ServerRespones updateType(Type type);

    ServerRespones findPidByName(Long id);
}
