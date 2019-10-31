package com.fh.shop.admin.controller.user;

import com.alibaba.fastjson.JSONObject;
import com.fh.shop.admin.biz.menu.IMenuService;
import com.fh.shop.admin.biz.user.IUserService;
import com.fh.shop.admin.commons.*;
import com.fh.shop.admin.email.Email;
import com.fh.shop.admin.param.product.ProductParam;
import com.fh.shop.admin.param.user.ParamSearchUser;
import com.fh.shop.admin.param.user.UserParam;
import com.fh.shop.admin.po.menu.Menu;
import com.fh.shop.admin.po.product.Product;
import com.fh.shop.admin.po.user.User;
import com.fh.shop.admin.util.*;
import com.fh.shop.admin.vo.user.UserVo;
import com.itextpdf.text.*;
import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import org.apache.commons.lang3.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.*;
import org.apache.zookeeper.data.Id;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
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
import java.io.IOException;
import java.util.*;
import java.util.List;

@Controller
@RequestMapping("user")
public class UserController {

    @Resource(name="userService")
    private IUserService userService;
    @Autowired
    private HttpServletRequest request;
    @Autowired
    private HttpServletResponse response;

    @Resource(name = "menuService")
    private IMenuService menuService;
    @RequestMapping("addUser")
    @ResponseBody
    @Log("新增用户信息")
    public ServerRespones addUser(User user){
            userService.addUser(user);
            return ServerRespones.success();

    }
    @RequestMapping("toList")
    public String toList(){
        return "user/list";
    }
    @RequestMapping("findUserList")
    @ResponseBody
    public ServerRespones findUserList(ParamSearchUser userSearch){
        long count=userService.findUserCount(userSearch);
        List<UserVo> userList= userService.findUserList(userSearch);
        Datetables datetables = new Datetables(userSearch.getDraw(),count,count,userList);
        return ServerRespones.success(datetables);
    }

    /*修改上锁状态*/
    @RequestMapping("/updateLockStauts")
    @ResponseBody
    @Log("修改上锁状态信息")
    public ServerRespones updateLockStauts(Long id){
        userService.updateErrorLoginCount(id);
        return ServerRespones.success();
    }
    /*去修改密码页面*/
    @RequestMapping("/toUpdatePassword")
    public String toUpdatePassword(){

        return "user/password";
    }
    /*重置密码*/
    @RequestMapping("/resetPassword")
    @ResponseBody
    public ServerRespones resetPassword(Long id){
        return userService.resetPassword(id);
    }
    /*验证用户名唯一*/
    @RequestMapping("/verifyUserName")
    @ResponseBody
    public Map verifyUserName(String userName){
        Map<String,Boolean> result = new HashMap<>();
        User user =userService.verifyUserName(userName);
        if (user == null ){
            result.put("valid",true);
        }else{
            result.put("valid",false);
        }
        return result;
    }
    /*修改密码*/
    @RequestMapping("/updatePassword")
    @ResponseBody
    @Log("修改密码")
    public ServerRespones updatePassword(UserParam userParam){

        return userService.updatePassword(userParam);
    }
    /*去找回密码页面*/
    @RequestMapping("/toFindPassword")
    public String toFindPassword(){

        return "user/findPassword";
    }
    /*找回密码*/
    @RequestMapping("enbPassword")
    @ResponseBody
    public ServerRespones enbPassword(String mail){

        return userService.enbPassword(mail);
    }
    @RequestMapping("/deleteUser")
    @ResponseBody
    @Log("删除用户信息")
    public ServerRespones deleteUser(Long id){
            userService.deleteUser(id);
           return ServerRespones.success();
    }

    @RequestMapping("/findUpdateUser")
    @ResponseBody
    public ServerRespones findUserUpdate(Long id){
            UserVo user = userService.findUserUpdate(id);
           return ServerRespones.success(user);
    }
    @RequestMapping("updateUser")
    @ResponseBody
    @Log("修改用户信息")
    public ServerRespones updateUser(User user){
            userService.updateUser(user);
            return ServerRespones.success();
    }
    @RequestMapping("/addUserFileInput")
    @ResponseBody
    @Log("新增用户图片信息")
    public Map addUserFileInput(@RequestParam("files") CommonsMultipartFile file){
        Map map = FileInputUtil.fileInput(file);
        return map;
    }
    @RequestMapping("/deleteBatchUser")
    @ResponseBody
    @Log("批量删除用户信息")
    public ServerRespones deleteBatchUser(@RequestParam("idArr[]") List<Long> list){
            userService.deleteBatchUser(list);
           return ServerRespones.success();
    }

    /**
     * 判断登陆
     * @param user
     * @return
     */
    @RequestMapping("/login")
    @ResponseBody
    public ServerRespones login(User user, String imgCodeName){
        //获取前台传过来的账号密码
        String userName = user.getUserName();
        String password = user.getPassword();

        //根据前台传过来的账号密码判断是否为空
        if (StringUtils.isEmpty(userName) || StringUtils.isEmpty(password) || StringUtils.isEmpty(imgCodeName)){
            return ServerRespones.error(ResponseEnum.USERNAME_PASSWORD_IS_NULL);
        }
        //判断前台传过来的验证码和session中的是否一致
         //String imgCode = (String) request.getSession().getAttribute(KeyUtil.buildCodeKey(imgCodeName));
        String sessionId = DistributeSession.getSessionId(request, response);
        String imgCode = RedisUtil.get(KeyUtil.buildCodeKey(sessionId));
        if (!imgCodeName.equalsIgnoreCase(imgCode)){
            return ServerRespones.error(ResponseEnum.CODE_IS_ERROR);
        }
        //根据前台传过来的name查询出整个对象
        User userDB = userService.login(userName);
        //判断账号是否存在
        if (userDB == null){
            return ServerRespones.error(ResponseEnum.USERNAME_IS_ERROR);
        }
        //判断是否是当天登陆
       /* String Time = DateUtil.date2str(new Date(),DateUtil.Y_M_D);
        if (userDB.getLoginErrorDate() != null && !DateUtil.date2str(userDB.getLoginErrorDate(),DateUtil.Y_M_D).equals(Time)){
           userDB.setLoginErrorCount(0);
            userService.updateErrorLoginCount(userDB.getId());
        }*/
        //判断是否已锁定
        if (userDB.getLoginErrorCount() == SyetemConst.LOGIN_ERROR_COUNT){
            Date errorDate = DateUtil.str2date(DateUtil.date2str(userDB.getLoginErrorDate(), DateUtil.Y_M_D), DateUtil.Y_M_D);
            Date thisDate = DateUtil.str2date(DateUtil.date2str(new Date(), DateUtil.Y_M_D), DateUtil.Y_M_D);
            if(thisDate.after(errorDate)){
                //不在同一天    异常登陆次数是0
                userService.updateErrorLoginCount(userDB.getId());
            }else{
                return ServerRespones.error(ResponseEnum.USER_LOCKED);
            }

        }
        String salt = userDB.getSalt();
        String password1 = user.getPassword();
        //判断密码是否正确
        String LoginPassword = Md5Util.buildPassword(salt,password1);
        if (!LoginPassword.equals(userDB.getPassword())){
            //锁定用户的处理   1.先获取到锁定时间
            Date loginErrorDate = userDB.getLoginErrorDate();
            //锁定时间是否为空 ，如果是空的话证明是第一次登陆，修改错误登陆时间，并错误次数加+1
            if (loginErrorDate == null){
                Date date= new Date();
                userService.updateErrorLoginInfo(date,userDB.getId());
            }else{
                //不是空的话
                //1.比较是否在同一天
                Date date= new Date();
                Date thisTime = DateUtil.str2date(DateUtil.date2str(date, DateUtil.Y_M_D), DateUtil.Y_M_D);
                Date errorDate = DateUtil.str2date(DateUtil.date2str(userDB.getLoginErrorDate(), DateUtil.Y_M_D), DateUtil.Y_M_D);
                //不是在同一天，记录错误登陆时间，并将错误次数设置为1
                if (thisTime.after(errorDate)){
                    userService.resetErrorLogin(date,userDB.getId());
                    userDB.setLoginErrorCount(1);
                }else{
                    //在同一天，记录错误登录时间，并将错误次数+1
                    userService.updateErrorLoginInfo(date,userDB.getId());
                    userDB.setLoginErrorCount(userDB.getLoginErrorCount()+1);
                }
                if (userDB.getLoginErrorCount() == SyetemConst.LOGIN_ERROR_COUNT ){
                    EmailUtil.buildEmail(userDB.getEmail(),"密码被锁定","<h1>如不是本人操作，请尽快修改密码</h1>");
                }
            }

            return ServerRespones.error(ResponseEnum.PASSWORD_IS_ERROR);
        }
        //成功
        userService.updateErrorLoginCount(userDB.getId());
        //放入session   登录信息   当前登陆的用户
        //request.getSession().setAttribute(SyetemConst.CURRENT_USER,userDB);
        //转换为json格式的字符串 因为已经获取过sessionId所以不用在获取   将当前登陆用户信息存入到redis中
        String userDBJson = JSONObject.toJSONString(userDB);
        RedisUtil.setEx(KeyUtil.buildUserDBKey(sessionId),SyetemConst.USER_EXPIRE,userDBJson);
        //根据userId查询出所有的菜单url
        List<Menu> menuList=menuService.findUrl(userDB.getId());
        //查询出菜单表所有信息
        List<Menu> allMenuList= menuService.findAllMenu();
        //查询userId查询出菜单表的所有信息
        List<Menu> menuTypeList= menuService.findMenuTypeOr2(userDB.getId());

       //将根据userid查询出来的所有类型的信息放入session中
        //request.getSession().setAttribute(SyetemConst.LOGIN_MENU_TYPE_OR_TWO,menuTypeList);
        //转换为json格式的字符串 因为已经获取过sessionId所以不用在获取   将当前登陆用户拥有的所有菜单权限存入到redis中
        String MenuTypeListJson = JSONObject.toJSONString(menuTypeList);
        RedisUtil.setEx(KeyUtil.buildUserAllMenuKey(sessionId),SyetemConst.USER_EXPIRE,MenuTypeListJson);

        //放入session  菜单信息
        //request.getSession().setAttribute(SyetemConst.LOGIN_MENU,menuList);
        //转换为json格式的字符串 因为已经获取过sessionId所以不用在获取   将当前登陆用户拥有的菜单的url存入到redis中
        String menuListJson = JSONObject.toJSONString(menuList);
        RedisUtil.setEx(KeyUtil.buildUserMenuUrlKey(sessionId),SyetemConst.USER_EXPIRE,menuListJson);
        //将查询出来的所有信息放入session 权限拦截器
       // request.getSession().setAttribute(SyetemConst.ALL_LOGIN_MENU,allMenuList);
        //转换为json格式的字符串 因为已经获取过sessionId所以不用在获取   将菜单中的所有信息存入到redis中
        String allMenuListJson = JSONObject.toJSONString(allMenuList);
        RedisUtil.setEx(KeyUtil.buildAllMenuListKey(sessionId),SyetemConst.USER_EXPIRE,allMenuListJson);
        //记录登陆成功时间
        userService.updateLoginTime(userDB.getId(),new Date());
        //记录成功登陆的次数
        Date currDate = DateUtil.str2date(DateUtil.date2str(new Date(), DateUtil.Y_M_D), DateUtil.Y_M_D);
       //判断登陆时间是否为空，是空就证明第一次登陆
        if (userDB.getLoginTime() == null){
            //登陆次数重置为1   修改数据库
            userService.resetLoginCount(userDB.getId());
            //修改session信息
            userDB.setLoginCount(1);
        }else{
            //不为空就判断当前登陆时间和上次登陆时间是否一致
            Date loginTime = DateUtil.str2date(DateUtil.date2str(userDB.getLoginTime(), DateUtil.Y_M_D), DateUtil.Y_M_D);
            //如果当前登陆时间在上次登陆时间之后，就证明不是第一天登陆
            if (currDate.after(loginTime)){
                //把登陆次数设置为1
                userService.resetLoginCount(userDB.getId());
                userDB.setLoginCount(1);
            }else{
                //否则就是当天登陆，登陆次数加1
                userService.updateLoginCount(userDB.getId());
                userDB.setLoginCount(userDB.getLoginCount()+1);
            }
        }
        //登陆成功清除验证码
        RedisUtil.del(KeyUtil.buildCodeKey(sessionId));
        //上面的都判断都通过则返回正确的
        return ServerRespones.success();
    }


    @RequestMapping("/outLogin")
    public String outLogin(){
        String sessionId = DistributeSession.getSessionId(request, response);
        RedisUtil.delBatch(KeyUtil.buildUserDBKey(sessionId),KeyUtil.buildUserMenuUrlKey(sessionId),
                    KeyUtil.buildUserAllMenuKey(sessionId),KeyUtil.buildAllMenuListKey(sessionId)
                );
        return "redirect:"+SyetemConst.LOGIN_URL;
    }

    /**
     * 导出excel
     * @param
     * @param response
     */

    //导出excle
    @RequestMapping("/exportExcle")
    public void exportExcle(ParamSearchUser paramSearchUser, HttpServletResponse response) {
        //动态查询需要的数据
        List<User> userExportList = userService.findexportUser(paramSearchUser);
        //将其转换为workbook
        XSSFWorkbook workbook = userService.buildXssfWorkBook(userExportList);
        //下载
        FileUtil.excelDownload(workbook,response);

    }



    /**
     * 导出Pdf
     * @param response
     * @param req
     * @param paramSearchUser
     */
    @RequestMapping("/downUserPdf")
    public void downShopPdf(HttpServletResponse response, HttpServletRequest req,ParamSearchUser  paramSearchUser) {
        String realPath = req.getSession().getServletContext().getRealPath(File.separator);
        try {
            // 第一步，实例化一个document对象
            Document document = new Document();
            // 第二步，设置要到出的路径
            response.setCharacterEncoding("utf-8");
            response.setContentType("application/octet-stream");
            response.setHeader("Content-Disposition", "attachment;filename=" + UUID.randomUUID().toString() + ".pdf");
            ServletOutputStream out = response.getOutputStream();
            // 如果是浏览器通过request请求需要在浏览器中输出则使用下面方式
            // OutputStream out = response.getOutputStream();
            // 第三步,设置字符
            BaseFont bfChinese = BaseFont.createFont("C:/windows/fonts/simsun.ttc,1", BaseFont.IDENTITY_H,
                    BaseFont.EMBEDDED);
            Font fontZH = new Font(bfChinese, 12.0F, 0);
            // 第四步，将pdf文件输出到磁盘
            PdfWriter writer = PdfWriter.getInstance(document, out);
            // 第五步，打开生成的pdf文件
            document.open();
            // 第六步,设置内容
            String title = "导出用户pdf的情况";
            document.add(new Paragraph(new Chunk(title, fontZH).setLocalDestination(title)));
            document.add(new Paragraph("\n"));
            // 创建table,注意这里的2是两列的意思,下面通过table.addCell添加的时候必须添加整行内容的所有列
            PdfPTable table = new PdfPTable(10);
            table.setWidthPercentage(100.0F);
            // 第一列是列表名
            table.setHeaderRows(1);
            table.getDefaultCell().setHorizontalAlignment(1);
            table.addCell(new Paragraph("ID", fontZH));
            table.addCell(new Paragraph("用户名", fontZH));
            table.addCell(new Paragraph("真实姓名", fontZH));
            table.addCell(new Paragraph("性别", fontZH));
            table.addCell(new Paragraph("年龄", fontZH));
            table.addCell(new Paragraph("电话", fontZH));
            table.addCell(new Paragraph("邮箱", fontZH));
            table.addCell(new Paragraph("薪资", fontZH));
            table.addCell(new Paragraph("入职时间", fontZH));
            table.addCell(new Paragraph("图片", fontZH));
            List<User> list = userService.downExcel(paramSearchUser);
            for (int i = 0; i < list.size(); i++) {
                table.addCell(new Paragraph("" + (list.get(i).getId()), fontZH));
                table.addCell(new Paragraph("" + (list.get(i).getUserName()),fontZH));
                table.addCell(new Paragraph("" + (list.get(i).getRealName()),fontZH));
                table.addCell(new Paragraph("" + (list.get(i).getSex()==1?"男":"女"),fontZH));
                table.addCell(new Paragraph("" + (list.get(i).getAge()),fontZH));
                table.addCell(new Paragraph("" + (list.get(i).getPhone()),fontZH));
                table.addCell(new Paragraph("" + (list.get(i).getEmail()),fontZH));
                table.addCell(new Paragraph("" + (list.get(i).getPrice()),fontZH));
                table.addCell(new Paragraph("" + (DateUtil.date2str(list.get(i).getEntryDate(),DateUtil.Y_M_D)),fontZH));
                table.addCell(Image.getInstance(realPath + list.get(i).getUserImg()));
            }
            document.add(table);
            document.add(new Paragraph("\n"));
            // 第七步，关闭document
            document.close();
            writer.close();
            System.out.println("导出pdf成功~");
        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
        }
    }

    @RequestMapping("/findUser")
    @ResponseBody
    public ServerRespones findUser(){
        String sessionId = DistributeSession.getSessionId(request, response);
        String userJson = RedisUtil.get(KeyUtil.buildUserDBKey(sessionId));
        User user = JSONObject.parseObject(userJson, User.class);
        return ServerRespones.success(user);
    }


    //导出word
    /*   @RequestMapping("productDownWord")
    public void productDownPdf(HttpServletRequest req, HttpServletResponse resp,ParamSearchUser paramSearchUser) throws IOException, TemplateException, DocumentException, com.lowagie.text.DocumentException {
        List<User> list= userService.downExcel(paramSearchUser);
        //转换图片编码
        for (int i = 0; i < list.size(); i++) {
            String str = (String) list.get(i).getUserImg();
            String imageBase = tupianbianma.getImageBase(str, req);
            list.get(i).getUserImg();

        }

        *//*String realPath = req.getServletContext().getRealPath("/");*//*
        *//*	System.out.println(realPath);*//*
        //创建freemarker 配置文件对象
        Configuration cfg=new Configuration(Configuration);
        //设置模板所在位置的目录路径
        //cfg.setDirectoryForTemplateLoading(new File(realPath+"/freemarker"));
        String aa = File.separator;
        cfg.setClassForTemplateLoading(UserController.class, aa);
        //设置编码
        cfg.setDefaultEncoding("UTF-8");
        //获取指定模板
        Template template = cfg.getTemplate("user_word.ftl");
        Map<String,Object> map = new HashMap<>();
        map.put("list",list);

        //指定要生成的文件
        //响应流
        resp.setCharacterEncoding("UTF-8");
        resp.setHeader("Content-Disposition", "attachment;filename="+"productPDF.pdf");
        ServletOutputStream outputStream = resp.getOutputStream();

        //生成字符串写入流
        StringWriter writer = new StringWriter();
        template.process(map,writer);
        writer.flush();
        String html = writer.toString();
        // 把html代码传入渲染器中
        ITextRenderer renderer= new ITextRenderer();
        String a = req.getSession().getServletContext().getRealPath(aa);
        renderer.getFontResolver().addFont(a+"freemarker/SIMSUN.TTC",BaseFont.IDENTITY_H,BaseFont.NOT_EMBEDDED);
        renderer.setDocumentFromString(html);
        renderer.layout();
        renderer.createPDF(outputStream);
        renderer.finishPDF();
        writer.close();
        outputStream.close();
        System.out.println("PDF成功");
    }*/

}
