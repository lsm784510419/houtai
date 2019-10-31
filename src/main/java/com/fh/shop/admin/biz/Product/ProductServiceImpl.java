package com.fh.shop.admin.biz.Product;

import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.fh.shop.admin.commons.Datetables;
import com.fh.shop.admin.commons.ServerRespones;
import com.fh.shop.admin.mapper.product.IProductMapper;
import com.fh.shop.admin.mapper.type.ITypeMapper;
import com.fh.shop.admin.param.product.ProductParam;
import com.fh.shop.admin.po.product.Product;
import com.fh.shop.admin.po.shop.Shop;
import com.fh.shop.admin.po.type.Type;
import com.fh.shop.admin.util.DateUtil;
import com.fh.shop.admin.util.FileUtil;
import com.fh.shop.admin.util.RedisUtil;
import com.fh.shop.admin.vo.product.ProductVo;
import org.apache.commons.lang3.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.xssf.usermodel.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.lang.reflect.Field;
import java.math.BigDecimal;
import java.util.*;

@Service("productService")
public class ProductServiceImpl implements IProductService {

    @Autowired
    private IProductMapper productMapper;

    @Autowired
    private ITypeMapper typeMapper;

    @Override
    public ServerRespones findPageProductList(ProductParam productParam) {
        long count = productMapper.findCount(productParam);
        List<Product> productList = productMapper.findPageProductList(productParam);
        List<ProductVo> productVoList = new ArrayList<>();
        for (Product product : productList) {
            ProductVo productVo = getProductVo(product);
            productVoList.add(productVo);
        }
        Datetables datetables = new Datetables(productParam.getDraw(),count,count,productVoList);
        return ServerRespones.success(datetables);
    }

    private ProductVo getProductVo(Product product) {
        ProductVo productVo = new ProductVo();
        productVo.setId(product.getId());
        productVo.setPrice(product.getPrice().toString());
        productVo.setProName(product.getProName());
        productVo.setCreateDate(DateUtil.date2str(product.getCreateDate(),DateUtil.Y_M_D));
        productVo.setStatus(product.getStatus());
        productVo.setBrandName(product.getBrandName());
        productVo.setBrandId(product.getBrandId());
        productVo.setProImg(product.getProImg());
        productVo.setCateName(product.getCateName());
        productVo.setStock(product.getStock());
        return productVo;
    }

    @Override
    public ServerRespones addProduct(Product product) {
        RedisUtil.del("cendProduct");
        productMapper.insert(product);
        return ServerRespones.success();
    }

    @Override
    public ServerRespones deleteProduct(Long id) {
        RedisUtil.del("cendProduct");
        productMapper.deleteById(id);
        return ServerRespones.success();
    }

    @Override
    public ServerRespones findUpdateProduct(Long id) {
        Product product = productMapper.selectById(id);
       /* String typeName1 = typeMapper.selectById(product.getCate1()).getTypeName();
        String typeName2 = typeMapper.selectById(product.getCate2()).getTypeName();
        String typeName3 = typeMapper.selectById(product.getCate3()).getTypeName();
        String cateName = typeName1+"-->"+typeName2+"-->"+typeName3;
        String cateName = productMapper.findCateName(id);*/
        String typeListAllJson = RedisUtil.get("typeListAll");
        if (StringUtils.isNotEmpty(typeListAllJson)){
            List<Type> typeList = JSONObject.parseArray(typeListAllJson,Type.class);
            String type1 = findIdByTypeName(product.getCate1(), typeList);
            String type2 = findIdByTypeName(product.getCate2(), typeList);
            String type3 = findIdByTypeName(product.getCate3(), typeList);
            product.setCateName(type1+"-->"+type2+"-->"+type3);
        }
        else {
            List<Type> typeList = typeMapper.selectList(null);
            typeListAllJson = JSONObject.toJSONString(typeList);
            RedisUtil.set("typeListAll", typeListAllJson);
            String type1 = findIdByTypeName(product.getCate1(), typeList);
            String type2 = findIdByTypeName(product.getCate2(), typeList);
            String type3 = findIdByTypeName(product.getCate3(), typeList);
            product.setCateName(type1 + "-->" + type2 + "-->" + type3);
        }
        ProductVo productVo = getProductVo(product);
        return ServerRespones.success(productVo);
    }
    private String findIdByTypeName(Long id,List<Type> typeList){
        for (Type type : typeList) {
            if (type.getId() == id){
                return type.getTypeName();
            }
        }
        return "";
    }

    @Override
    public ServerRespones updateProduct(Product product,HttpServletRequest request) {
        if (StringUtils.isNotEmpty(product.getNewProductImg())){
            String realPath = request.getServletContext().getRealPath(product.getProImg());
            FileUtil.deleteFile(realPath);
        }
        product.setProImg(product.getNewProductImg());
        RedisUtil.del("cendProduct");
        productMapper.updateById(product);
        return ServerRespones.success();
    }

    @Override
    public ServerRespones updateStatus(Product product) {
        productMapper.updateById(product);
        return ServerRespones.success();
    }

    @Override
    public List<Product> findexportProduct(ProductParam productParam) {

        List<Product> productList = productMapper.findexportProduct(productParam);
        return productList;
    }

}
