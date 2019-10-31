package com.fh.shop.admin.controller.product;

import com.fh.shop.admin.biz.Product.IProductService;
import com.fh.shop.admin.commons.Log;
import com.fh.shop.admin.commons.ServerRespones;
import com.fh.shop.admin.param.product.ProductParam;
import com.fh.shop.admin.po.product.Product;
import com.fh.shop.admin.util.FileInputUtil;
import com.fh.shop.admin.util.FileUtil;
import com.fh.shop.admin.util.ReflectUtil;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/product")
public class ProductController {
    @Resource(name = "productService")
    private IProductService productService;

    @Autowired
    private HttpServletRequest request;
    @RequestMapping("/toList")
    public String toList(){

        return "product/list";
    }
    @RequestMapping("/findPageProductList")
    @ResponseBody
    public ServerRespones findPageProductList(ProductParam productParam){

        return productService.findPageProductList(productParam);
    }
    @RequestMapping("/addProduct")
    @ResponseBody
    public ServerRespones addProduct(Product product){
        return productService.addProduct(product);
    }
    @RequestMapping("/deleteProduct")
    @ResponseBody
    public ServerRespones deleteProduct(Long id){
        return productService.deleteProduct(id);
    }
    @RequestMapping("/findUpdateProduct")
    @ResponseBody
    public ServerRespones findUpdateProduct(Long id){

        return productService.findUpdateProduct(id);
    }

    @RequestMapping("/updateProduct")
    @ResponseBody
    public ServerRespones updateProduct(Product product){

        return productService.updateProduct(product,request);
    }
    @RequestMapping("/updateStatus")
    @ResponseBody
    public ServerRespones updateStatus(Product product){

        return productService.updateStatus(product);
    }

    //fileInput上传图片
/*    @RequestMapping("/addFileInputShop")
    @ResponseBody
    @Log("新增商品图片信息")
    public Map addFileInputShop(@RequestParam("files") CommonsMultipartFile file) {
        Map result = FileInputUtil.fileInput(file);
        return result;
    }*/

    //导出excle
    @RequestMapping("/exportExcle")
    public void exportExcle(ProductParam productParam, HttpServletResponse response) {
        //动态查询需要的数据
        List<Product> productExportList = productService.findexportProduct(productParam);
        //将其转换为workbook
        String[] headers = {"商品名","商品价格","生产日期","状态","品牌","商品类型"};
        String[] props ={"proName","price","createDate","status","brandName","cateName"};
        XSSFWorkbook workbook = ReflectUtil.buildXssfWorkBook(productExportList, "商品列表", headers, props, Product.class);
        //下载
        FileUtil.excelDownload(workbook,response);

    }

}
