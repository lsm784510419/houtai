package com.fh.shop.admin.mapper.type;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.fh.shop.admin.po.type.Type;

import java.util.List;

public interface ITypeMapper extends BaseMapper<com.fh.shop.admin.po.type.Type> {
    void addType(Type type);

}
