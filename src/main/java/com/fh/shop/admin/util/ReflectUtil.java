package com.fh.shop.admin.util;

import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.xssf.usermodel.*;

import java.lang.reflect.Field;
import java.math.BigDecimal;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ReflectUtil {

    public static XSSFWorkbook buildXssfWorkBook(List dataList, String sheetName, String[] headers, String[] props, Class clazz) {
       //创建poi对象 导出excel
        XSSFWorkbook workbook = new XSSFWorkbook();
        //创建sheet页
        XSSFSheet sheet = workbook.createSheet();
        sheet.setDefaultColumnWidth(15*1);
        //设置单元格格式 日期的
        XSSFCellStyle dateStyle = workbook.createCellStyle();
        dateStyle.setDataFormat(HSSFDataFormat.getBuiltinFormat("m/d/yy"));
        //价格的
        XSSFCellStyle priceStyle = workbook.createCellStyle();
        priceStyle.setDataFormat(HSSFDataFormat.getBuiltinFormat("0.00"));
        Map<String,XSSFCellStyle> styleMap = new HashMap<>();
        styleMap.put("dateStyle",dateStyle);
        styleMap.put("priceStyle",priceStyle);
        //创建标题行
        sheet = buildHeaders(headers,sheet);
        //创建内容行
        buildBodys(dataList,sheet,clazz,styleMap,props);
        return workbook;
    }


    private static XSSFSheet buildHeaders(String[] headers,XSSFSheet sheet) {

        //创建标题行
        XSSFRow row = sheet.createRow(0);
        //循环传过来的标题
        for (int i = 0; i < headers.length; i++) {
            //给每个单元格的标题赋值
            row.createCell(i).setCellValue(headers[i]);
        }
        return sheet;
    }
    private static void buildBodys(List dataList, XSSFSheet sheet,Class clazz,Map<String,XSSFCellStyle> styleMap,String[] props) {
        //循环传过来的List集合中的对象
        for (int i = 0; i < dataList.size(); i++) {
            //获取当前循环的对象
            Object o = dataList.get(i);
            //创建构造内容的行
            XSSFRow row = sheet.createRow(i + 1);
            //循环传过来的指定参数
            for (int j = 0; j < props.length; j++) {
                try {
                    //根据传过来的参数获取到指定的属性
                    Field declaredField = clazz.getDeclaredField(props[j]);
                    //将私有化的属性放开   暴力访问
                    declaredField.setAccessible(true);
                    //找到对象中的属性值
                    Object obj = declaredField.get(o);
                    //判断属性类型
                    Class<?> type = declaredField.getType();

                    if (type == java.lang.String.class){
                        row.createCell(j).setCellValue(String.valueOf(obj));
                    }
                    if (type == java.lang.Integer.class || type == int.class){
                        row.createCell(j).setCellValue(Integer.valueOf(String.valueOf(obj)));
                    }
                    if (type == java.lang.Double.class){
                        row.createCell(j).setCellValue(Double.valueOf(String.valueOf(obj)));
                    }
                    if (type == java.util.Date.class){
                        XSSFCell cell = row.createCell(j);
                        cell.setCellValue((Date)obj);
                        cell.setCellStyle(styleMap.get("dateStyle"));
                    }
                    if (type == java.math.BigDecimal.class){
                        XSSFCell cell = row.createCell(j);
                        cell.setCellValue(((BigDecimal)obj).doubleValue());
                        cell.setCellStyle(styleMap.get("priceStyle"));
                    }
                } catch (NoSuchFieldException e) {
                    e.printStackTrace();
                } catch (IllegalAccessException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
