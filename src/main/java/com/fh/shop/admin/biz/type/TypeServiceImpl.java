package com.fh.shop.admin.biz.type;

import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.fh.shop.admin.commons.ServerRespones;
import com.fh.shop.admin.mapper.type.ITypeMapper;
import com.fh.shop.admin.po.type.Type;
import com.fh.shop.admin.util.RedisUtil;
import com.fh.shop.admin.vo.type.TypeVo;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service("typeService")
public class TypeServiceImpl implements ITypeService {
    @Autowired
    private ITypeMapper typeMapper;
    @Override
    public ServerRespones findTypeList() {
        //单表的树进行展示
        String typeListAllJson = RedisUtil.get("typeListAll");
        //判断缓存中是否有数据
        if (StringUtils.isNotEmpty(typeListAllJson)){
            //有数据进行转换
            List<Type> typeList = JSONObject.parseArray(typeListAllJson, Type.class);
            //po转换为vo    因为前台的数据需要转换   ztree需要的有规定
            List<TypeVo> typeVoList = getTypeVos(typeList);
            //响应给前台
            return ServerRespones.success(typeVoList);
        }
        //走到这里说明缓存没有数据，需要去数据库查
        List<com.fh.shop.admin.po.type.Type> typeList = typeMapper.selectList(null);
        //类型转换
        String typeListDB = JSONObject.toJSONString(typeList);
        //存入缓存服务器
        RedisUtil.set("typeListAll",typeListDB);
        List<TypeVo> typeVoList = getTypeVos(typeList);
        return ServerRespones.success(typeVoList);
    }

    private List<TypeVo> getTypeVos(List<Type> typeList) {
        List<TypeVo> typeVoList = new ArrayList<>();
        for (Type typePo : typeList) {
            TypeVo typeVo = new TypeVo();
            typeVo.setId(typePo.getId());
            typeVo.setName(typePo.getTypeName());
            typeVo.setpId(typePo.getPid());
            typeVoList.add(typeVo);
        }
        return typeVoList;
    }

    @Override
    public ServerRespones addType(Type type) {
        RedisUtil.del("typeListAll");
        typeMapper.addType(type);
        return ServerRespones.success();
    }

    @Override
    public ServerRespones deleteType(List<Long> ids) {
        RedisUtil.del("typeListAll");
        typeMapper.deleteBatchIds(ids);
        return ServerRespones.success();
    }

    @Override
    public ServerRespones updateType(Type type) {
        RedisUtil.del("typeListAll");
        typeMapper.updateById(type);
        return ServerRespones.success();
    }

    /**
     * 此方法为商品页面三级联动所需要的数据
     * @param id
     * @return
     */
    @Override
    public ServerRespones findPidByName(Long id) {
        //从缓存中取数据
        String typeListAllJson = RedisUtil.get("typeListAll");
        //判断缓存中是否有数据
        if (StringUtils.isNotEmpty(typeListAllJson)){
            List<Type> typeListDB = JSONObject.parseArray(typeListAllJson, Type.class);
            List<Type> typeIdList = getTypeIdList(id, typeListDB);
            return ServerRespones.success(typeIdList);
        }
       /* QueryWrapper<Type> typeQueryWrapper = new QueryWrapper<>();
        typeQueryWrapper.eq("pid",id);*/
       //去数据库查数据
        List<Type> typeList = typeMapper.selectList(null);
        //转换数据
        typeListAllJson = JSONObject.toJSONString(typeList);
        //存入缓存
        RedisUtil.set("typeListAll",typeListAllJson);
        List<Type> typeIdList = getTypeIdList(id, typeList);
        return ServerRespones.success(typeIdList);
    }
    private List<Type> getTypeIdList(Long id, List<Type> typeList){
        List<Type> idList= new ArrayList<>();
        for (Type type : typeList) {
            //如果Pid==id就证明获取这个节点下的所有孩子  存入数组返回
            if (type.getPid()==id){
                idList.add(type);
            }
        }
        return idList;
    }
}
