package com.fh.shop.admin.util;

import org.apache.commons.lang3.StringUtils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class DateUtil {

    public static final String Y_M_D="yyyy-MM-dd";
    public static final String FOR_YEAR="yyyy-MM-dd HH:mm:ss";

    public static String date2str(Date data,String pattern){
        if (data==null){
            return "";
        }
        SimpleDateFormat sdf= new SimpleDateFormat(pattern);
        String strDate = sdf.format(data);
        return strDate;
    }
    public static Date str2date(String string,String pattern){
        if (StringUtils.isEmpty(string)){
            return null;
        }
        Date currDate = null;
        SimpleDateFormat sdf =new SimpleDateFormat(pattern);
        try {
       currDate = sdf.parse(string);

        } catch (ParseException e) {
            e.printStackTrace();
        }
          return currDate;
    }
}
