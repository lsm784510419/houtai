package com.fh.shop.admin.biz.user;

import com.fh.shop.admin.commons.ServerRespones;
import com.fh.shop.admin.param.user.ParamSearchUser;
import com.fh.shop.admin.param.user.UserParam;
import com.fh.shop.admin.po.product.Product;
import com.fh.shop.admin.po.user.User;
import com.fh.shop.admin.vo.user.UserVo;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.List;
import java.util.Map;

public interface IUserService {

    void addUser(User user);

    long findUserCount(ParamSearchUser userSearch);

    List<UserVo> findUserList(ParamSearchUser userSearch);

    void deleteUser(Long id);

    UserVo findUserUpdate(Long id);

    void updateUser(User user);

    void deleteBatchUser(List<Long> list);

    User login(String userName);

    List<User> downExcel(ParamSearchUser paramSearchUser);

    void updateLoginTime(Long id, Date date);

    void resetLoginCount(Long id);

    void updateLoginCount(Long id);

    void updateErrorLoginInfo(Date date, Long id);

    void resetErrorLogin(Date date, Long id);

    void updateErrorLoginCount(Long id);

    void updateErrorLoginDate(Date date, Long id);

    ServerRespones updatePassword(UserParam userParam);

    ServerRespones resetPassword(Long id);

    ServerRespones enbPassword(String mail);

    User verifyUserName(String userName);

    List<User> findexportUser(ParamSearchUser paramSearchUser);

    XSSFWorkbook buildXssfWorkBook(List<User> userExportList);
}
