package com.fh.shop.admin.biz.Product;

import com.fh.shop.admin.commons.ServerRespones;
import com.fh.shop.admin.param.product.ProductParam;
import com.fh.shop.admin.po.product.Product;
import com.fh.shop.admin.po.shop.Shop;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

public interface IProductService {
    ServerRespones findPageProductList(ProductParam productParam);

    ServerRespones addProduct(Product product);

    ServerRespones deleteProduct(Long id);

    ServerRespones findUpdateProduct(Long id);

    ServerRespones updateProduct(Product product,HttpServletRequest request);

    ServerRespones updateStatus(Product product);

    List<Product> findexportProduct(ProductParam productParam);

}