package com.fh.shop.admin.biz.user;

import com.alibaba.fastjson.JSONObject;
import com.fh.shop.admin.commons.ResponseEnum;
import com.fh.shop.admin.commons.ServerRespones;
import com.fh.shop.admin.commons.SyetemConst;
import com.fh.shop.admin.mapper.area.IAreaMapper;
import com.fh.shop.admin.mapper.user.IUserMapper;
import com.fh.shop.admin.param.user.ParamSearchUser;
import com.fh.shop.admin.param.user.UserParam;
import com.fh.shop.admin.po.area.Area;
import com.fh.shop.admin.po.user.User;
import com.fh.shop.admin.po.userrole.UserRole;
import com.fh.shop.admin.util.DateUtil;
import com.fh.shop.admin.util.EmailUtil;
import com.fh.shop.admin.util.Md5Util;
import com.fh.shop.admin.util.RedisUtil;
import com.fh.shop.admin.vo.user.UserVo;
import org.apache.commons.lang3.RandomStringUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.xssf.usermodel.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.rmi.MarshalledObject;
import java.util.*;

@Service("userService")
public class UserServiceImpl implements IUserService {

    @Autowired
    private IUserMapper userMapper;

    @Autowired
    private IAreaMapper areaMapper;

    @Override
    public void addUser(User user) {
        //md5处理密码加密
        String salt = UUID.randomUUID().toString();
        String md5Password = Md5Util.buildPassword(salt,user.getPassword());
        user.setSalt(salt);
        user.setPassword(md5Password);
        //
        user.setLoginCount(0);
        //添加用户信息
        userMapper.addUser(user);

        //添加用户和角色之间的关系
        addUserRole(user);

    }

    private void addUserRole(User user) {
        Long userId = user.getId();
        String roleIds = user.getRoleIds();
        if (StringUtils.isNotEmpty(roleIds)){
            String[] roleIdArr = roleIds.split(",");
            for (String roleId : roleIdArr) {
                UserRole userRole = new UserRole();
                userRole.setUserId(userId);
                userRole.setRoleId(Long.parseLong(roleId));
                userMapper.addUserRole(userRole);
            }
        }
    }

    @Override
    public long findUserCount(ParamSearchUser userSearch) {
        buildRoleSearch(userSearch);
        long userCount = userMapper.findUserCount(userSearch);

        return userCount;
    }

    @Override
    public List<UserVo> findUserList(ParamSearchUser userSearch) {
        buildRoleSearch(userSearch);
        List<UserVo> userVoList =new ArrayList<>();
            List<User> userList = userMapper.findUserList(userSearch);
        for (User userinfo : userList) {
            Long userId = userinfo.getId();
           List<String> roleNames= userMapper.findUserRoleList(userId);
            UserVo userVo = getUserVo(userinfo);
            String roleNameStr = StringUtils.join(roleNames,",");
            userVo.setRoleIds(roleNameStr);
            userVoList.add(userVo);
        }
        return userVoList;
    }

    private void buildRoleSearch(ParamSearchUser userSearch) {
        String roleIds = userSearch.getRoleIds();
        if (StringUtils.isNotEmpty(roleIds)){
            List<Integer> roleIdList = new ArrayList();
            String[] roleId = roleIds.split(",");
            for (String s : roleId) {
                roleIdList.add(Integer.parseInt(s));
            }
            userSearch.setRoleList(roleIdList);
            userSearch.setRoleListSize(roleIdList.size());
        }
    }

    private UserVo getUserVo(User userinfo) {
        UserVo userVo =new UserVo();
        userVo.setId(userinfo.getId());
        userVo.setUserName(userinfo.getUserName());
        userVo.setRealName(userinfo.getRealName());
        userVo.setSex(userinfo.getSex());
        userVo.setAge(userinfo.getAge());
        userVo.setPhone(userinfo.getPhone());
        userVo.setEmail(userinfo.getEmail());
        userVo.setPrice(userinfo.getPrice().toString());
        userVo.setEntryDate(DateUtil.date2str(userinfo.getEntryDate(),DateUtil.Y_M_D));
        userVo.setUserImg(userinfo.getUserImg());
        userVo.setStatus(userinfo.getLoginErrorCount() == SyetemConst.LOGIN_ERROR_COUNT);
        userVo.setAreaName(userinfo.getAreaName());
        userVo.setArea1(userinfo.getArea1());
        userVo.setArea2(userinfo.getArea2());
        userVo.setArea3(userinfo.getArea3());
        return userVo;
    }

    @Override
    public void deleteUser(Long id) {
        //删除用户表
        userMapper.deleteUser(id);
        //删除中间关联表
        userMapper.deleteUserRole(id);
    }

    @Override
    public UserVo findUserUpdate(Long id) {
        User userUpdate = userMapper.findUserUpdate(id);
        String areaListJson = RedisUtil.get("areaList");
        if (StringUtils.isNotEmpty(areaListJson)){
            List<Area> areaList = JSONObject.parseArray(areaListJson, Area.class);
            String areaName1 = getAreaName(userUpdate.getArea1(), areaList);
            String areaName2 = getAreaName(userUpdate.getArea2(), areaList);
            String areaName3 = getAreaName(userUpdate.getArea3(), areaList);
            userUpdate.setAreaName(areaName1+"-->"+areaName2+"-->"+areaName3);
        }
        else {
            //数据库查询
            List<Area> areaList = areaMapper.selectList(null);
            //转换数据类型
            areaListJson = JSONObject.toJSONString(areaList);
            //存入缓存
            RedisUtil.set("areaList",areaListJson);
            //根据关联条件的ID  每级下拉框的id获取对应的name
            String areaName1 = getAreaName(userUpdate.getArea1(), areaList);
            String areaName2 = getAreaName(userUpdate.getArea2(), areaList);
            String areaName3 = getAreaName(userUpdate.getArea3(), areaList);
            userUpdate.setAreaName(areaName1+"-->"+areaName2+"-->"+areaName3);
        }
            List<Integer> roleIdList= userMapper.findRoleIdList(id);
            UserVo userVo = getUserVo(userUpdate);
            userVo.setPassword(userUpdate.getPassword());
            userVo.setRoleNames(roleIdList);
            userVo.setSalt(userUpdate.getSalt());
            return userVo;

    }

    private String getAreaName(Long id,List<Area> areaList){
        for (Area area : areaList) {
            if (area.getId() == id){
                return area.getAreaName();
            }
        }
        return "";
    }

    @Override
    public void updateUser(User user) {

        userMapper.updateUser(user);
        //修改中间表
        //进行修改时先删除
        userMapper.deleteUserRole(user.getId());
        //后新增   此方法是提出来的方法 直接调用
        addUserRole(user);
    }

    @Override
    public void deleteBatchUser(List<Long> list) {
        //批量删除用户信息
        userMapper.deleteBatchUser(list);
        //批量删除用户关联表的信息
        userMapper.deleteUserRoles(list);

    }

    @Override
    public User login(String userName) {
        User login = userMapper.login(userName);
        login.setStrLoginTime(DateUtil.date2str(login.getLoginTime(),DateUtil.FOR_YEAR));
        return login;

    }

    @Override
    public List<User> downExcel(ParamSearchUser paramSearchUser) {
        return userMapper.downExcel(paramSearchUser);
    }

    @Override
    public void updateLoginTime(Long id, Date date) {
        userMapper.updateLoginTime(id,date);
    }

    @Override
    public void resetLoginCount(Long id) {
        userMapper.resetLoginCount(id);
    }

    @Override
    public void updateLoginCount(Long id) {
        userMapper.updateLoginCount(id);
    }

    @Override
    public void updateErrorLoginInfo(Date date, Long id) {
        userMapper.updateErrorLoginInfo(date,id);
    }

    @Override
    public void resetErrorLogin(Date date, Long id) {
        userMapper.resetErrorLogin(date,id);
    }

    @Override
    public void updateErrorLoginCount(Long id) {
        userMapper.updateErrorLoginCount(id);
    }

    @Override
    public void updateErrorLoginDate(Date date, Long id) {
        userMapper.updateErrorLoginDate(date,id);
    }

    @Override
    public ServerRespones updatePassword(UserParam userParam) {
        //进行非空判断
        if (StringUtils.isEmpty(userParam.getOldPassword())
                || StringUtils.isEmpty(userParam.getNewPassword())
                || StringUtils.isEmpty(userParam.getConfirmPassword())){

            return ServerRespones.error(ResponseEnum.PASSWORD_IS_NULL);
        }
        //判断新密码和和确认密码是否一致
        if (!userParam.getNewPassword().equals(userParam.getConfirmPassword())){
            return ServerRespones.error(ResponseEnum.PASSWORD_IS_DIFFERENT);
        }
        //判断原密码是否正确
        User userUpdate = userMapper.findUserUpdate(userParam.getUserId());
        String password = userUpdate.getPassword();
        String salt = userUpdate.getSalt();
        String newPassword = userParam.getNewPassword();
        String oldPassword = userParam.getOldPassword();
        if (!password.equals(Md5Util.buildPassword(salt,oldPassword))){
            return ServerRespones.error(ResponseEnum.OLD_PASSWORD_IS_ERROR);
        }
        //进行修改
        userParam.setNewPassword(Md5Util.buildPassword(salt,newPassword));
        userMapper.updatePassword(userParam);
        return ServerRespones.success();
    }

    @Override
    public ServerRespones resetPassword(Long id) {
        User userUpdate = userMapper.findUserUpdate(id);
        if (userUpdate ==null){
            return ServerRespones.error(ResponseEnum.USER_IS_NULL);
        }
        String salt = userUpdate.getSalt();
        String password = SyetemConst.INIT_PASSWORD;
        String password1 = Md5Util.buildPassword(salt, password);
        userMapper.resetPassword(id,password1);
        return ServerRespones.success(ResponseEnum.RESET_PASSWORD_SUCCESS);
    }

    @Override
    public ServerRespones enbPassword(String mail) {
        //查询出所有邮箱
        User user = userMapper.findEmail(mail);
        //判断邮箱是否存在
        if (user == null){
            return ServerRespones.error(ResponseEnum.EMAIL_IS_NULL);
        }
        //发送邮件
        //1.重置新密码
        String password = RandomStringUtils.randomAlphanumeric(6);
        //2.发送邮件
        EmailUtil.buildEmail(mail,"找回的密码","您的新密码为:"+password);
        //更新数据库
        String passwordDB = Md5Util.buildPassword(user.getSalt(), password);
        userMapper.resetPassword(user.getId(),passwordDB);
        return ServerRespones.success();
    }

    @Override
    public User verifyUserName(String userName) {
        User user = userMapper.verifyUserName(userName);
        return user;
    }

    @Override
    public List<User> findexportUser(ParamSearchUser paramSearchUser) {

        List<User> userList = userMapper.findexportUser(paramSearchUser);
        return userList;
    }




    public XSSFWorkbook buildXssfWorkBook(List<User> userExportList) {
        XSSFWorkbook workbook = new XSSFWorkbook();
        //设置单元格格式   日期
        XSSFCellStyle dateStyle = workbook.createCellStyle();
        dateStyle.setDataFormat(HSSFDataFormat.getBuiltinFormat("m/d/yy"));
        //价格
        XSSFCellStyle priceStyle = workbook.createCellStyle();
        priceStyle.setDataFormat(HSSFDataFormat.getBuiltinFormat("0.00"));
        XSSFSheet sheet = buildHeaderRows(workbook);
        //构建内容行
        buildBodys(userExportList, dateStyle, priceStyle, sheet);
        return workbook;
    }

    private void buildBodys(List<User> userExportList, XSSFCellStyle dateStyle, XSSFCellStyle priceStyle, XSSFSheet sheet) {
        for (int i = 0; i < userExportList.size(); i++) {
            User user = userExportList.get(i);
            XSSFRow row1 = sheet.createRow(i + 5);
            row1.createCell(5).setCellValue(user.getUserName());
            row1.createCell(6).setCellValue(user.getRealName());
            row1.createCell(7).setCellValue(user.getSex()==1?"男":"女");
            row1.createCell(8).setCellValue(user.getAge());
            row1.createCell(9).setCellValue(user.getPhone());

            XSSFCell priceCell = row1.createCell(10);
            priceCell.setCellValue(user.getPrice().doubleValue());
            priceCell.setCellStyle(priceStyle);
            XSSFCell dateCell = row1.createCell(11);
            dateCell.setCellValue(user.getEntryDate());
            dateCell.setCellStyle(dateStyle);
            row1.createCell(12).setCellValue(user.getRoleIds());
            row1.createCell(13).setCellValue(user.getAreaName());
        }
    }

    private XSSFSheet buildHeaderRows(XSSFWorkbook workbook) {
        XSSFSheet sheet = workbook.createSheet();
        //构建标题行
        XSSFRow row = sheet.createRow(4);
        row.createCell(5).setCellValue("用户名");
        row.createCell(6).setCellValue("真实姓名");
        row.createCell(7).setCellValue("性别");
        row.createCell(8).setCellValue("年龄");
        row.createCell(9).setCellValue("电话");
        row.createCell(10).setCellValue("薪资");
        row.createCell(11).setCellValue("入职时间");
        row.createCell(12).setCellValue("角色");
        row.createCell(13).setCellValue("地区");
        return sheet;
    }

}
