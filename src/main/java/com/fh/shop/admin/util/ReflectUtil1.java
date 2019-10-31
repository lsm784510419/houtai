package com.fh.shop.admin.util;

import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.xssf.usermodel.*;

import java.lang.reflect.Field;
import java.math.BigDecimal;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ReflectUtil1 {
    public XSSFWorkbook buildXssfWorkBook(List dataList,String sheetName,String[] headers, String[] props,Class clazz) {
        XSSFWorkbook workbook = new XSSFWorkbook();
        //设置单元格格式   日期
        XSSFCellStyle dateStyle = workbook.createCellStyle();
        dateStyle.setDataFormat(HSSFDataFormat.getBuiltinFormat("m/d/yy"));
        //价格
        XSSFCellStyle priceStyle = workbook.createCellStyle();
        priceStyle.setDataFormat(HSSFDataFormat.getBuiltinFormat("0.00"));
        Map<String,XSSFCellStyle> styleMap = new HashMap<>();
        styleMap.put("dateStyle",dateStyle);
        styleMap.put("priceStyle",priceStyle);
        //构建标题行
        XSSFSheet sheet = buildHeaderRows(workbook,headers);
        //构建内容行
        buildBodys(dataList,styleMap,sheet,props,clazz);
        return workbook;
    }

    private XSSFSheet buildHeaderRows(XSSFWorkbook workbook,String[] headers) {
        XSSFSheet sheet = workbook.createSheet();
        //构建标题行
        XSSFRow row = sheet.createRow(0);
        for (int i = 0; i < headers.length; i++) {
            row.createCell(i).setCellValue(headers[i]);
        }
        return sheet;
    }
    private void buildBodys(List dataList,Map<String,XSSFCellStyle> styleMap, XSSFSheet sheet,String[] props,Class clazz) {
        for (int i = 0; i < dataList.size(); i++) {
            Object o = dataList.get(i);
            XSSFRow row = sheet.createRow(i + 1);
            for (int j = 0; j < props.length; j++) {
                try {
                    Field declaredField = clazz.getDeclaredField(props[j]);
                    declaredField.setAccessible(true);
                    Object obj = declaredField.get(o);
                    Class<?> type = declaredField.getType();
                    if (type == java.lang.String.class){
                        row.createCell(j).setCellValue(String.valueOf(obj));
                    }
                    if (type == java.lang.Double.class){
                        row.createCell(j).setCellValue(String.valueOf(obj));
                    }
                    if (type == java.lang.Integer.class){
                        row.createCell(j).setCellValue(String.valueOf(obj));
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
