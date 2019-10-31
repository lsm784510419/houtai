package com.fh.shop.admin.controller.shop;

import com.fh.shop.admin.biz.shop.IShopService;
import com.fh.shop.admin.commons.Datetables;
import com.fh.shop.admin.commons.Log;
import com.fh.shop.admin.commons.ServerRespones;
import com.fh.shop.admin.param.shop.ParamSearchShop;
import com.fh.shop.admin.po.shop.Shop;
import com.fh.shop.admin.util.DateUtil;
import com.fh.shop.admin.util.FileInputUtil;
import com.fh.shop.admin.util.FileUtil;
import com.fh.shop.admin.vo.shop.ShopVo;
import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Controller
@RequestMapping("shop")
public class ShopController {

    @Resource(name = "shopService")
    private IShopService shopService;

    @RequestMapping("/toList")
    public String toList() {

        return "/shop/list";
    }

    @RequestMapping("findPageShopList")
    @ResponseBody
    public Datetables findPageShopList(ParamSearchShop paramSearchShop) {
        Long count = shopService.findShopCount(paramSearchShop);
        List<ShopVo> shopVoList = shopService.findPageShopList(paramSearchShop);
        Datetables ShopList = new Datetables(paramSearchShop.getDraw(), count, count, shopVoList);

        return ShopList;
    }

    @RequestMapping("/addShop")
    @ResponseBody
    @Log("新增商品信息")
    public ServerRespones addShop(Shop shop) {
        shopService.addShop(shop);
        return ServerRespones.success();
    }

    @RequestMapping("/deleteShop")
    @ResponseBody
    @Log("删除商品信息")
    public ServerRespones deleteShop(int id) {
        shopService.deleteShop(id);
        return ServerRespones.success();
    }

    @RequestMapping("findUpdateShop")
    @ResponseBody
    public ServerRespones findUpdateShop(int id) {

        ShopVo shop = shopService.findUpdateShop(id);
        return ServerRespones.success(shop);
    }

    @RequestMapping("/updateShop")
    @ResponseBody
    @Log("修改商品信息")
    public ServerRespones updateShop(Shop shop) {
        shopService.updateShop(shop);
        return ServerRespones.success();
    }

    //fileInput上传图片
    @RequestMapping("/addFileInputShop")
    @ResponseBody
    @Log("新增商品图片信息")
    public Map addFileInputShop(@RequestParam("files") CommonsMultipartFile file) {
        Map result = FileInputUtil.fileInput(file);
        return result;
    }

    //修改上下架状态
    @RequestMapping("/updateIsUp")
    @ResponseBody
    @Log("修改商品上下架信息")
    public ServerRespones updateIsUp(Long id) {
        shopService.updateIsUp(id);
        return ServerRespones.success();

    }

    //导出excle
    @RequestMapping("/exportExcle")
    public void exportExcle(ParamSearchShop paramSearchShop, HttpServletResponse response) {
        //动态查询需要的数据
        List<Shop> shopExportList = shopService.findexportShop(paramSearchShop);
        //将其转换为workbook
        Workbook workbook = buildWorkBook(shopExportList);
        //下载
        response.setCharacterEncoding("UTF-8");
        response.setHeader("Content-Disposition", "attachment;filename=" + "shop.xlsx");
        try {
            ServletOutputStream outputStream = response.getOutputStream();
            workbook.write(outputStream);
            outputStream.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    //构建workBook
    private Workbook buildWorkBook(List<Shop> shopExportList) {
        XSSFWorkbook workBook = new XSSFWorkbook();
        //当前表
        XSSFSheet sheet = workBook.createSheet();
        //构建大标题
        buildBigTitle(sheet);
        //构造标题行
        buildTitleRow(sheet);
        //构造内容
        buildBody(shopExportList, sheet);
        return workBook;
    }

    private void buildBigTitle(XSSFSheet sheet) {
        XSSFRow row = sheet.createRow(3);
        XSSFCell cell = row.createCell(7);
        cell.setCellValue("商品列表");
        CellRangeAddress cellRangeAddress = new CellRangeAddress(3, 5, 7, 9);
        sheet.addMergedRegion(cellRangeAddress);
    }

    //构造内容
    private void buildBody(List<Shop> shopExportList, XSSFSheet sheet) {
        for (int i = 0; i < shopExportList.size(); i++) {
            Shop shop = shopExportList.get(i);
            XSSFRow row = sheet.createRow(i + 7);
            row.createCell(6).setCellValue(shop.getShopName());
            row.createCell(7).setCellValue(shop.getPrice().toString());
            row.createCell(8).setCellValue(DateUtil.date2str(shop.getShopTime(), DateUtil.FOR_YEAR));
            row.createCell(9).setCellValue(shop.getIsHotCakes() == 1 ? "是" : "否");
            row.createCell(10).setCellValue(shop.getStock());
            row.createCell(11).setCellValue(shop.getIsUp() == 1 ? "正常" : "下架");
        }
    }

    //构造标题行
    private void buildTitleRow(XSSFSheet sheet) {
        XSSFRow row = sheet.createRow(6);
        String[] titles = {"商品名称", "商品价格", "生产日期", "是否热销", "库存量", "上架状态"};
        for (int i = 0; i < titles.length; i++) {
            row.createCell(i + 6).setCellValue(titles[i]);
        }
    }

    //导出word
    @RequestMapping("/exportWord")
    public void exportWord(ParamSearchShop paramSearchShop, HttpServletResponse response, HttpServletRequest request) throws IOException {
        //动态查询需要的数据
        List<Shop> shopExportList = shopService.findexportShop(paramSearchShop);
        //转换为指定的格式
        File file = buildWord(shopExportList);
        //下载
        FileUtil.downloadFile(request,response,file);
    }


    private File buildWord(List<Shop> shopExportList) throws IOException {
        Configuration configuration = new Configuration();
        configuration.setClassForTemplateLoading(this.getClass(),"/template");
        configuration.setDefaultEncoding("UTF-8");
        Template template = configuration.getTemplate("shop.xml");
        Map data = new HashMap();
        data.put("shopExportList",shopExportList);
        FileOutputStream out = null;
        OutputStreamWriter osw = null;
        File file = null;
        try {
            file = new File("D:/daochu"+UUID.randomUUID().toString()+".doc");
            out = new FileOutputStream(file);
            osw = new OutputStreamWriter(out, "UTF-8");
            template.process(data, osw);
            osw.flush();
        } catch (TemplateException e) {
            e.printStackTrace();
        }finally {
            if (osw != null){
                osw.close();
                osw = null ;
            }
            if (out != null){
                out.close();
                out =null;
            }
        }
        return file;
    }
}